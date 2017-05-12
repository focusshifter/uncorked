Feature: Wineries

  Scenario: Retrieve a list of wineries
    Given the client is authorized
    And the set of "Winery" exist:
      | title     | uuid                                 |
      | Fanagoria | 1360b914-b84e-4f7d-8c6e-b01d7b1e5b2f |
    When the client does a GET request to "/wineries"
    Then the response status should be "200"
    And the response should include the following:
    """
      {
        "_links": {
          "self": {
            "href": "/wineries",
            "title": "The collection of Wineries"
          }
        },
        "_embedded": {
          "wineries": [
            {
              "_links": {
                "self": {
                  "href": "/wineries/1360b914-b84e-4f7d-8c6e-b01d7b1e5b2f",
                  "title": "Fanagoria"
                }
              },
              "id": "1360b914-b84e-4f7d-8c6e-b01d7b1e5b2f",
              "title": "Fanagoria"
            }
          ]
        }
      }
    """


  Scenario: Add a new winery
    Given the client is authorized
    When the client does a POST request to "/wineries" with the following content:
    """
      {
        "title": "Fanagoria"
      }
    """
    Then the response status should be "201"
    And the response "title" should equal "Fanagoria"
    And the response should have "id"

  Scenario: Add a new winery without required fields
    Given the client is authorized
    When the client does a POST request to "/wineries" with the following content:
    """
      {}
    """
    Then the response status should be "400"
    And the response should have "errors"

  Scenario: View a selected winery
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title     | uuid                                 |
      | 1  | Fanagoria | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    When the client does a GET request to "/wineries/7dabbec1-e299-4037-a027-428b15f7fe4d"
    Then the response status should be "200"
    And the response "_links.self.href" should equal "/wineries/7dabbec1-e299-4037-a027-428b15f7fe4d"
    And the response "id" should equal "7dabbec1-e299-4037-a027-428b15f7fe4d"
    And the response "title" should equal "Fanagoria"

  Scenario: View a selected winery with wines
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title     | uuid                                 |
      | 1  | Fanagoria | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
    When the client does a GET request to "/wineries/7dabbec1-e299-4037-a027-428b15f7fe4d"
    Then the response status should be "200"
    And the response "title" should equal "Fanagoria"
    And the response "_links.wines" should have 1 item

  Scenario: Delete a winery (also will delete all the related wines)
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title     | uuid                                 |
      | 1  | Fanagoria | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
    When the client does a DELETE request to "/wineries/7dabbec1-e299-4037-a027-428b15f7fe4d"
    Then the response status should be "204"
    And the collection "Winery" should have 0 items
    And the collection "Wine" should have 0 items
