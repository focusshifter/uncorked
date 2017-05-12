Feature: Provide a root Entrypoint

  Scenario:
    When the client does a GET request to "/"
    Then the response status should be "200"
    And the response should include the following:
      """
      {
        "_links": {
          "self": {
            "href": "/",
            "title": "API Entrypoint"
          },
          "wineries": {
            "href": "/wineries",
            "title": "The collection of Wineries"
          },
          "wines": {
            "href": "/wines",
            "title": "The collection of Wines"
          },
          "login": {
            "href": "/login",
            "title": "Get an auth token"
          },
          "signup": {
            "href": "/signup",
            "title": "Register as a new user"
          }
        }
      }
      """
