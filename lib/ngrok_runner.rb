require 'tempfile'
require 'timeout'
require 'uri'
require 'json'

module Signal
  # This module dynamically starts and detects the ngrok URL
  # It can potentially be extracted as a gem.
  module NgrokRunner
    module_function

    def start_for(env)
      unless already_running?(env)
        pid = fork do
          `ngrok http --bind-tls=true -config #{config_file_path(env)} #{ngrok_tunnelling_port(env)}`
        end
        at_exit { stop_for(env) }
        write_pid_to_file(env, pid)
      end
      ensure_finished_loading(env)
    end

    def stop_for(env)
      `pkill -TERM -P #{current_pid(env)}` if already_running?(env)
    end

    def url(env)
      ngrok_api_uri = URI("http://localhost:#{ngrok_client_api_port(env)}/api/tunnels")
      JSON.load(Net::HTTP.get(ngrok_api_uri))['tunnels'][0]['public_url']
    rescue
      nil
    end

    # methods below are private methods

    def ngrok_tunnelling_port(env)
      case env
      when 'development'
        4567
      when 'test'
        4568
      else
        raise "#{env} is not supported by NgrokRunner"
      end
    end

    def ngrok_client_api_port(env)
      case env
      when 'development'
        4040
      when 'test'
        4041
      else
        raise "#{env} is not supported by NgrokRunner"
      end
    end

    def config_file_path(env)
      file = Tempfile.new("ngrok-#{env}")
      file.write(
        <<-eos
web_addr: localhost:#{ngrok_client_api_port(env)}
        eos
      )
      file.close
      file.path
    end

    def pid_file_path(env)
      File.expand_path("../../../tmp/pids/ngrok.#{env}", __FILE__)
    end

    def current_pid(env)
      File.read(pid_file_path(env)).to_i if File.exist?(pid_file_path(env))
    end

    def already_running?(env)
      pid = current_pid(env)
      !(pid.nil? || Process.getpgid(pid).nil?)
    rescue Errno::ESRCH
      false
    end

    def write_pid_to_file(env, pid)
      FileUtils.mkdir_p(File.dirname(pid_file_path(env)))
      File.open(pid_file_path(env), 'w') { |file| file.write(pid) }
    end

    def ensure_finished_loading(env)
      Timeout.timeout(5) do
        loop do
          break unless url(env).nil?
          sleep 0.5
        end
      end
    end
  end
end
