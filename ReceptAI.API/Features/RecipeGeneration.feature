Feature: Recipe generation based on ingredients

  Scenario: Successful recipe generation
    Given I have the following valid ingredients ids: 1, 2, 3
    When I request to generate a recipe with valid ingredients
    Then the response should be an OK result with a valid recipe

  Scenario: Failed recipe generation due to invalid ingredient ids
    Given I have the following invalid ingredients ids: -500, -501
    When I request to generate a recipe with invalid ingredients
    Then the response should be a BadRequest result
