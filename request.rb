require 'httparty'
require 'json'
require 'dotenv/load'

URL = "https://api.travis-ci.com/v2_subscriptions"
token = ENV['TRAVIS_TOKEN']

headers = { 
  "Authorization"  => "token #{token}",
  "Content-Type" => "application/json",
  "Accept" => "application/json",
  "Travis-API-Version" => "3",
  "path" => "/v2_subscriptions"
}

response = HTTParty.get(
  URL,
  :query => {format: :json},
  :headers => headers
)
remaining_credits = response['v2_subscriptions'][2]['addons'][0]['current_usage']['remaining']

p "Remaining credits are #{remaining_credits}"