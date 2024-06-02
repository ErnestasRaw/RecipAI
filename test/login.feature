Feature: Login
  Scenario: Successful login
    Given the app is running
    When I enter valid credentials
    Then I should be logged in