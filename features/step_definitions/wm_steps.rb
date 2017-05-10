When(/^the client does a GET request to "([^"]*)"$/) do |path|
  get path
end

When(/^the client does a POST request to "([^"]*)" with the following content:$/) do |path, body|
  post path, body, 'CONTENT_TYPE' => 'application/json'
end

Given(/^the client is authorized$/) do
  header 'Authorization', 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.2VByW6IFUhAo4846CDwJHOCGN0AMeScni-hivpuIK5k'
end

Given(/^the set of "([^"]*)" exist:$/) do |model_class, rows|
  model = Object.const_get(model_class)
  model.unrestrict_primary_key

  rows.hashes.each do |params|
    model.create(params)
  end

  model.restrict_primary_key
end


Then(/^the response status should be "([^\"]*)"$/) do |status|
  expect(last_response.status).to eq(status.to_i)
end
