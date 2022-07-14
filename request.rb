require 'httparty'
require 'json'
require 'dotenv/load'

# Travis API endpoint to fetch subscription data.
URL = "https://api.travis-ci.com/v2_subscriptions"

# Travis CI API token
token = ENV['TRAVIS_TOKEN']

# API call headers
headers = { 
	"Authorization"  => "token #{token}",
	"Content-Type" => "application/json",
	"Accept" => "application/json",
	"Travis-API-Version" => "3",
	"path" => "/v2_subscriptions"
}

# Make API call if username(s) for End User / Organzation are set
if ENV['USER_LOGIN'] || ENV['ORG_LOGIN']
	response = HTTParty.get(
		URL,
		:query => {format: :json},
		:headers => headers
	)

# Iterate over found subscriptions and find corresponding user login and remaining credits
	response['v2_subscriptions'].each do |sub|
		if ENV['USER_LOGIN'] && sub['owner']['@type'] == "user" && sub['owner']['login'] == ENV['USER_LOGIN']
			owner = sub['owner']['login']
			remaining_credits = sub['addons'][0]['current_usage']['remaining']

			p "***** USER ***************"
			p "User: #{owner}"
			p "Remaining Credits: #{remaining_credits}"
			p "***************************"
		elsif ENV['ORG_LOGIN'] && sub['owner']['@type'] == "organization" && sub['owner']['login'] == ENV['ORG_LOGIN']
			owner = sub['owner']['login']
			remaining_credits = sub['addons'][0]['current_usage']['remaining']

			p "***** Organization ***************"
			p "Org: #{owner}"
			p "Remaining Credits: #{remaining_credits}"
		end
	end
else
	p "No End user or Org username set in .env file!"
end
