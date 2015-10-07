require "google/api_client"
require "google_drive"

require_relative "config/config.rb"

# Authorize with OAuth and gets an access token
client = Google::APIClient.new
auth = client.authorization
auth.client_id = GOOGLE_CLIENT_ID
auth.client_secret = GOOGLE_CLIENT_SECRET

auth.scope = [
  "https://www.googleapis.com/auth/drive"
]

auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"

# Prompt the user to authorize the app
print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
print("2. Enter the authorization code shown in the page: ")
auth.code = $stdin.gets.chomp
auth.fetch_access_token!
access_token = auth.access_token

# Create a session
session = GoogleDrive.login_with_oauth(access_token)

# Get the worksheet
ws = session.spreadsheet_by_key(GOOGLE_SPREADSHEET_KEY).worksheets[0]

# Remove the first element, which is the sheet headers
responses = ws.rows.drop(1)

# Get relevant data for each supporter
supporters = responses.map do |row|
  {
    :family_name => row[1],
    :given_name => row[2],
    :organization => row[3],
    :city => row[8],
    :country => row[9]
  }
end

unique_supporters = supporters.uniq

# Write the supporters list as JSON into the _data directory
File.open("_data/supporters.json", "w") do |f|
  f.write(JSON.pretty_generate(unique_supporters))
end
