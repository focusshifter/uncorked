Feature: Log in and sign up users

  Scenario: Create a new user
    When the client does a POST request to "/signup" with the following content:
      """
      {
        "email": "test@example.net"
      }
      """
    Then the response status should be "201"
    And the response should have "token"
    And the response should include the following:
      """
      {
        "_links": {
          "self": {
            "href": "/signup",
            "title": "Signup"
          }
        },
        "email": "test@example.net"
      }
      """

  Scenario: Log in an existing user
    Given the set of "User" exist:
      | email            |
      | test@example.net |
    When the client does a POST request to "/login" with the following content:
      """
      {
        "_links": {
          "self": {
            "href": "/login",
            "title": "Login"
          }
        },
        "email": "test@example.net"
      }
      """
    Then the response status should be "200"
    And the response should have "token"
