Feature: Wines

  Scenario: Retrieve a list of wines
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title       | uuid                                 |
      | 1  | Fanagoria   | 7dabbec1-e299-4037-a027-428b15f7fe4d |
      | 2  | Abrau Durso | c8ef659e-93dc-47d9-bd30-edf153aaf61e |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
      | 2  | NR Pinot Noir        | ee799610-7d68-443a-88b4-2aeda45b5056 | 1         |
      | 3  | Brut NV              | c37f1e1d-3171-46c8-8da6-75360c5c906b | 2         |
    When the client does a GET request to "/wines"
    Then the response status should be "200"
    And the response should include the following:
      """
        {
          "_links": {
            "self": {
              "href": "http://example.org/wines",
              "title": "The collection of Wines"
            }
          },
          "_embedded": {
            "wines": [
              {
                "_links": {
                  "self": {
                    "href": "http://example.org/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143",
                    "title": "Cru Lermont Saperavi"
                  },
                  "winery": {
                    "href": "http://example.org/wineries/7dabbec1-e299-4037-a027-428b15f7fe4d",
                    "title": "Fanagoria"
                  },
                  "reviews": {
                    "href": "http://example.org/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143/reviews",
                    "title": "Reviews for Cru Lermont Saperavi"
                  }
                },
                "id": "e2ce9fb0-c26d-406c-84e2-77e6df725143",
                "title": "Cru Lermont Saperavi"
              },
              {
                "_links": {
                  "self": {
                    "href": "http://example.org/wines/ee799610-7d68-443a-88b4-2aeda45b5056",
                    "title": "NR Pinot Noir"
                  },
                  "winery": {
                    "href": "http://example.org/wineries/7dabbec1-e299-4037-a027-428b15f7fe4d",
                    "title": "Fanagoria"
                  },
                  "reviews": {
                    "href": "http://example.org/wines/ee799610-7d68-443a-88b4-2aeda45b5056/reviews",
                    "title": "Reviews for NR Pinot Noir"
                  }
                },
                "id": "ee799610-7d68-443a-88b4-2aeda45b5056",
                "title": "NR Pinot Noir"
              },
              {
                "_links": {
                  "self": {
                    "href": "http://example.org/wines/c37f1e1d-3171-46c8-8da6-75360c5c906b",
                    "title": "Brut NV"
                  },
                  "winery": {
                    "href": "http://example.org/wineries/c8ef659e-93dc-47d9-bd30-edf153aaf61e",
                    "title": "Abrau Durso"
                  },
                  "reviews": {
                    "href": "http://example.org/wines/c37f1e1d-3171-46c8-8da6-75360c5c906b/reviews",
                    "title": "Reviews for Brut NV"
                  }
                },
                "id": "c37f1e1d-3171-46c8-8da6-75360c5c906b",
                "title": "Brut NV"
              }
            ]
          }
        }
      """

  Scenario: Add a new wine
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title       | uuid                                 |
      | 1  | Fanagoria   | 7dabbec1-e299-4037-a027-428b15f7fe4d |
      | 2  | Abrau Durso | c8ef659e-93dc-47d9-bd30-edf153aaf61e |
    When the client does a POST request to "/wines" with the following content:
    """
      {
        "title": "Cru Lermont Saperavi",
        "winery_id": "7dabbec1-e299-4037-a027-428b15f7fe4d"
      }
    """
    Then the response status should be "201"
    And the response "title" should equal "Cru Lermont Saperavi"
    And the response should have "id"
    And the response "_links.winery.href" should equal "http://example.org/wineries/7dabbec1-e299-4037-a027-428b15f7fe4d"

  Scenario: Add a new winery without required fields
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title       | uuid                                 |
      | 1  | Fanagoria   | 7dabbec1-e299-4037-a027-428b15f7fe4d |
      | 2  | Abrau Durso | c8ef659e-93dc-47d9-bd30-edf153aaf61e |
    When the client does a POST request to "/wines" with the following content:
    """
      {
        "title": "Cru Lermont Saperavi"
      }
    """
    Then the response status should be "400"
    And the response should have "errors"

  Scenario: View a selected wine
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title     | uuid                                 |
      | 1  | Fanagoria | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
    When the client does a GET request to "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143"
    Then the response status should be "200"
    And the response "title" should equal "Cru Lermont Saperavi"
    And the response should have "id"
    And the response "_links.winery.href" should equal "http://example.org/wineries/7dabbec1-e299-4037-a027-428b15f7fe4d"

  Scenario: Delete a wine
    Given the client is authorized
    And the set of "Winery" exist:
      | id | title     | uuid                                 |
      | 1  | Fanagoria | 7dabbec1-e299-4037-a027-428b15f7fe4d |
    And the set of "Wine" exist:
      | id | title                | uuid                                 | winery_id |
      | 1  | Cru Lermont Saperavi | e2ce9fb0-c26d-406c-84e2-77e6df725143 | 1         |
    When the client does a DELETE request to "/wines/e2ce9fb0-c26d-406c-84e2-77e6df725143"
    Then the response status should be "204"
    And the collection "Winery" should have 1 items
    And the collection "Wine" should have 0 items
