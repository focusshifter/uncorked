Feature: Wineries

  Scenario: Retrieve a list of wineries
    Given the client is authorized
    And the set of "Winery" exist:
      | title     |
      | Fanagoria |
    When the client does a GET request to "/wineries"
    Then the response status should be "200"
    

  Scenario: Add a new winery
    Given the client is authorized
    When the client does a POST request to "/wineries" with the following content:
    """
      {
        "title": "Long Island Wine Country"
      }
    """
    Then the response status should be "201"


  Scenario: View a selected winery
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title     | uuid                                 |
      | 1  | Fanagoria | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    When the client does a GET request to "/wineries/7dabbec1-e299-4037-a027-428b15f7fe4d"
    Then the response status should be "200"
    And the response "_links.self.href" should equal "/wineries/7dabbec1-e299-4037-a027-428b15f7fe4d"
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
