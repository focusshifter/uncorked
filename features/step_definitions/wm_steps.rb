When(/^the client does a GET request to "([^"]*)"$/) do |path|
  get path, {}, 'CONTENT_TYPE' => 'application/json'
end

When(/^the client does a POST request to "([^"]*)" with the following content:$/) do |path, body|
  post path, body, 'CONTENT_TYPE' => 'application/json'
end

When(/^the client does a DELETE request to "([^"]*)"$/) do |path|
  delete path, {}, 'CONTENT_TYPE' => 'application/json'
end

Given(/^the client is authorized$/) do
  User.create(email: 'test@example.net')

  post '/login', '{"email": "test@example.net"}', 'CONTENT_TYPE' => 'application/json'
  token = JSON.parse(last_response.body).dig('token')
  header 'Authorization', "Bearer #{token}"
end

Given(/^the set of "([^"]*)" exist:$/) do |model_class, rows|
  model = Object.const_get(model_class)
  model.unrestrict_primary_key

  rows.hashes.each do |params|
    model.create(params)
  end

  model.restrict_primary_key
end

Then(/^the collection "([^"]*)" should have (\d+) (item|items)$/) do |model_class, count, _items|
  model = Object.const_get(model_class)
  expect(model.count).to eq(count.to_i)
end

Then(/^the response status should be "([^\"]*)"$/) do |status|
  begin
    expect(last_response.status).to eq(status.to_i)
  rescue RSpec::Expectations::ExpectationNotMetError => e
    puts last_response.body
    raise e
  end
end

Then(/^the response "([^"]*)" should equal "([^"]*)"$/) do |field_path, value|
  target = field_path.split('.')
  expect(JSON.parse(last_response.body).dig(*target)).to eq(value)
end

Then(/^the response "([^"]*)" should have (\d+) (item|items)$/) do |field_path, count, _items|
  target = field_path.split('.')
  expect(JSON.parse(last_response.body).dig(*target).size).to eq(count.to_i)
end

Then(/^the response should have "([^"]*)"$/) do |field_path|
  target = field_path.split('.')
  expect(JSON.parse(last_response.body).dig(*target)).to be
end

Then(/^the response should include the following:$/) do |json|
  begin
    expect(JSON.parse(last_response.body)).to include(JSON.parse(json))
  rescue RSpec::Expectations::ExpectationNotMetError => e
    puts last_response.body
    raise e
  end
end
