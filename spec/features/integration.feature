Feature: Integration
  As a developer
  I want to perform end to end test without mocking
  so that I can be sure that the system is working as expected

  Scenario: Successful connection to the customer
    Given a consultant is ready to receive a call
    When a customer calls
    Then the consultant is connected to the customer
    When the consultant hangs up
    Then the consultant is diconneted from the cusotmer
