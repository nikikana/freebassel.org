require 'rubygems'
require "google/api_client"
require "google_drive"
require 'nokogiri'
require 'faraday'
require_relative "config/config.rb"

desc "Update Supporters List"
task :update_supporters_list do
	require_relative 'get_supporters_data.rb'
	# Main
	access_token = generate_access_token(GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET)
	session = create_session(access_token)
	worksheet = fetch_worksheet(session, GOOGLE_SPREADSHEET_KEY)
	supporters = generate_supporters_list(worksheet)

	# Write the supporters list as JSON into the _data directory
	File.open("_data/supporters.json", "w") do |f|
	  f.write(JSON.pretty_generate(supporters))
	end
end

desc "Fetch Change.org Data"
task :fetch_change_org_petition do
	client = Faraday.new(:url => 'https://api.change.org/v1/petitions/4400820')
	client.params = {'api_key' => CHANGE_ORG_API_KEY}
	response = client.get

	File.open("_data/changeorg.json", "w") do |f|
		f.write(JSON.pretty_generate(JSON.parse(response.body)))
	end
end
