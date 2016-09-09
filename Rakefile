require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/{**/*_spec.rb,features/**/*.feature}'
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: %i(spec rubocop)
