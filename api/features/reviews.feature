Feature: Reviews

  Scenario: Retrieve a list of reviews for a wine
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title       | uuid                                 |
      | 1  | Fanagoria   | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
    And the set of "Review" exist:
      | id | rating | summary                      | uuid                                 | wine_id | user_id |
      | 1  | 5      | Smooth body, pleasant smell. | f5bc3869-8cd5-476f-837f-d9fd31b7b7ef | 1       | 1       |
    When the client does a GET request to "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143/reviews"
    Then the response status should be "200"
    And the response should include the following:
      """
        {
          "_links": {
            "self": {
              "href": "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143/reviews",
              "title": "Reviews for Cru Lermont Saperavi"
            }
          },
          "_embedded": {
            "reviews": [
              {
                "_links": {
                  "self": {
                    "href": "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143/reviews/f5bc3869-8cd5-476f-837f-d9fd31b7b7ef"
                  },
                  "wine": {
                    "href": "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143",
                    "title": "Cru Lermont Saperavi"
                  }
                },
                "id": "f5bc3869-8cd5-476f-837f-d9fd31b7b7ef",
                "rating": 5,
                "summary": "Smooth body, pleasant smell.",
                "author": "Test User"
              }
            ]
          }
        }
      """

  Scenario: Add a new review
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title       | uuid                                 |
      | 1  | Fanagoria   | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
    When the client does a POST request to "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143/reviews" with the following content:
    """
      {
        "summary": "Smooth body, pleasant smell.",
        "rating": 5
      }
    """
    Then the response status should be "201"
    And the response "summary" should equal "Smooth body, pleasant smell."
    And the response "rating" should equal 5
    And the response should have "id"
    And the response "_links.wine.href" should equal "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143"

  Scenario: Add a new review without required fields
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title       | uuid                                 |
      | 1  | Fanagoria   | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
    When the client does a POST request to "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143/reviews" with the following content:
    """
      {
        "rating": 5
      }
    """
    Then the response status should be "400"
    And the response should have "errors"

  Scenario: Add a new review with rating out of bounds (1..5)
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title       | uuid                                 |
      | 1  | Fanagoria   | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
    When the client does a POST request to "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143/reviews" with the following content:
    """
      {
        "summary": "Smooth body, pleasant smell.",
        "rating": 10
      }
    """
    Then the response status should be "400"
    And the response should have "errors"

  Scenario: View a selected review
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title       | uuid                                 |
      | 1  | Fanagoria   | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
    And the set of "Review" exist:
      | id | rating | summary                      | uuid                                 | wine_id | user_id |
      | 1  | 5      | Smooth body, pleasant smell. | f5bc3869-8cd5-476f-837f-d9fd31b7b7ef | 1       | 1       |
    When the client does a GET request to "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143/reviews/f5bc3869-8cd5-476f-837f-d9fd31b7b7ef"
    Then the response status should be "200"
    And the response "summary" should equal "Smooth body, pleasant smell."
    And the response "rating" should equal 5
    And the response should have "id"
    And the response "_links.wine.href" should equal "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143"

  Scenario: Delete a review
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title       | uuid                                 |
      | 1  | Fanagoria   | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
    And the set of "Review" exist:
      | id | rating | summary                      | uuid                                 | wine_id | user_id |
      | 1  | 5      | Smooth body, pleasant smell. | f5bc3869-8cd5-476f-837f-d9fd31b7b7ef | 1       | 1       |
    When the client does a DELETE request to "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143/reviews/f5bc3869-8cd5-476f-837f-d9fd31b7b7ef"
    Then the response status should be "204"
    And the collection "Winery" should have 1 items
    And the collection "Wine" should have 1 items
    And the collection "Review" should have 0 items
