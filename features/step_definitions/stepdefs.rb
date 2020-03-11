require 'net/http'
require 'uri'
require 'json'

module Rest_service
  def Rest_service.get_request(method)
    if method == "POST"
      URI.parse("https://restful-booker.herokuapp.com/booking")
    else
      URI.parse("https://restful-booker.herokuapp.com/booking/1")
    end
  end
end

World Rest_service

Given(/^I have set a connection for (POST|DELETE)$/) do|method|
  @uri = Rest_service.get_request(method)
  @req_options = {
    use_ssl: @uri.scheme="https",
  }
end

When(/^I send a POST request to "(.*?)" with json$/) do |end_point, json_text|
  request = Net::HTTP::Post.new(@uri)
  request['content-type'] = 'application/json'
  request['accept'] = 'application/json'
  request.body = json_text
  @response = Net::HTTP.start(@uri.hostname, @uri.port, @req_options) do |http|
    http.request(request)
  end
  @last_json = @response.body
end

Then(/^the HTTP status code should be "([^"]*)"$/) do |http_code|
  expect(@response.code).to eq(http_code)
end

When(/^I send a DELETE request to "(.*?)"$/) do |end_point|
  request = Net::HTTP::Delete.new(@uri)
  request['content-type'] = 'application/json'
  request['Cookie'] = 'token=78f465fed6af256'
  @response = Net::HTTP.start(@uri.hostname, @uri.port, @req_options) do |http|
    http.request(request)
  end
  @last_json = @response.body
end
