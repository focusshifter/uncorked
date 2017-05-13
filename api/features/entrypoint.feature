Feature: Provide a root Entrypoint

  Scenario:
    When the client does a GET request to "/"
    Then the response status should be "200"
    And the response should include the following:
      """
        {
          "_links": {
            "self": {
              "href": "http://example.org/",
              "title": "API Entrypoint"
            },
            "wineries": {
              "href": "http://example.org/wineries",
              "title": "The collection of Wineries"
            },
            "winery": {
              "href": "http://example.org/wineries/{id}",
              "templated": true
            },
            "wines": {
              "href": "http://example.org/wines",
              "title": "The collection of Wines"
            },
            "wine": {
              "href": "http://example.org/wines/{id}",
              "templated": true
            },
            "login": {
              "href": "http://example.org/login",
              "title": "Get an auth token"
            },
            "signup": {
              "href": "http://example.org/signup",
              "title": "Register as a new user"
            }
          }
        }
      """
