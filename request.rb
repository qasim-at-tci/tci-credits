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

response['v2_subscriptions'].each do |sub|
  if ENV['USER_LOGIN'] && sub['owner']['@type'] == "user" && sub['owner']['login'] == ENV['USER_LOGIN']
    owner = sub['owner']['login']
    rc = sub['addons'][0]['current_usage']['remaining']
    p "***** USER ***************"
    p "User: #{owner}"
    p "Remaining Credits: #{rc}"
    p "***************************"
  elsif ENV['ORG_LOGIN'] && sub['owner']['@type'] == "organization" && sub['owner']['login'] == ENV['ORG_LOGIN']
    owner = sub['owner']['login']
    rc = sub['addons'][0]['current_usage']['remaining']
    p "***** Organization ***************"
    p "Org: #{owner}"
    p "Remaining Credits: #{rc}"
  end
end