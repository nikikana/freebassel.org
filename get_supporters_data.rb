require "google/api_client"
require "google_drive"

require_relative "config/config.rb"

# Generate an access token
def generate_access_token(client_id, client_secret)
  auth = generate_client_authorization(client_id, client_secret)
  prompt_for_access_token(auth)
end

# Set up client authorization
def generate_client_authorization(client_id, client_secret)
  client = Google::APIClient.new
  auth = client.authorization
  auth.client_id = client_id
  auth.client_secret = client_secret

  auth.scope = [
    "https://www.googleapis.com/auth/drive"
  ]

  auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
  auth
end

# Prompt the user to authorize the app
def prompt_for_access_token(auth)
  print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
  print("2. Enter the authorization code shown in the page: ")
  auth.code = $stdin.gets.chomp
  auth.fetch_access_token!
  auth.access_token
end

# Create a session
def create_session(access_token)
  GoogleDrive.login_with_oauth(access_token)
end

# Get a worksheet
def fetch_worksheet(session, spreadsheet_key, sheet_number = 0)
  session.spreadsheet_by_key(GOOGLE_SPREADSHEET_KEY).worksheets[sheet_number]
end

# Generate supporters list
def generate_supporters_list(worksheet)
  # Remove the first element, which is the sheet headers
  responses = worksheet.rows.drop(1)

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

  # Remove duplicates
  supporters.uniq
end

# Main
access_token = generate_access_token(GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET)
session = create_session(access_token)
worksheet = fetch_worksheet(session, GOOGLE_SPREADSHEET_KEY)
supporters = generate_supporters_list(worksheet)

# Write the supporters list as JSON into the _data directory
File.open("_data/supporters.json", "w") do |f|
  f.write(JSON.pretty_generate(supporters))
end
