Feature: description

  Scenario: Create a booking
  Given I have set a connection for POST
    When I send a POST request to "/booking.json" with json
    """
    {
      "firstname" : "Jim",
      "lastname" : "Brown",
      "totalprice" : 111,
      "depositpaid" : true,
      "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
      },
      "additionalneeds" : "Breakfast"
    }
    """
    Then the HTTP status code should be "200"

  Scenario: Delete a booking
  Given I have set a connection for DELETE
    When I send a DELETE request to "/booking/"
    Then the HTTP status code should be "200"
