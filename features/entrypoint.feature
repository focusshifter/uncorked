Feature: Provide a root Entrypoint

  Scenario:
    When the client does a GET request to "/"
    Then the response status should be "200"
    And the response should be a "root" JSON schema
