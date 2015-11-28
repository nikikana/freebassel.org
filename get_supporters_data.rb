require "google/api_client"
require "google_drive"

# Generate an access token
def generate_access_token(client_id, client_secret)
  auth = generate_client_authorization(client_id, client_secret)

  # Check if the refresh token exists, or prompt for a new code
  if File.exists?('config/refresh_token.rb')
    require File.join(File.dirname(__FILE__), 'config', 'refresh_token')
    auth.refresh_token = GOOGLE_REFRESH_TOKEN
  else
    auth.code = prompt_for_auth_code(auth)
  end

  auth.fetch_access_token!

  save_refresh_token(auth.refresh_token)
  auth.access_token
end

# Set up client authorization
def generate_client_authorization(client_id, client_secret)
  client = Google::APIClient.new
  auth = client.authorization
  auth.client_id = client_id
  auth.client_secret = client_secret

  auth.scope = [
    "https://www.googleapis.com/auth/drive.readonly"
  ]

  auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
  auth
end

# Prompt the user to authorize the app, return authorization code
def prompt_for_auth_code(auth)
  print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
  print("2. Enter the authorization code shown in the page: ")
  $stdin.gets.chomp
end

# Save refresh token
def save_refresh_token(token)
  filename = 'refresh_token.rb'
  open(File.join(File.dirname(__FILE__), 'config', filename), 'w+') do |f|
    f.puts <<-"EOS"
GOOGLE_REFRESH_TOKEN = "#{token}"
EOS
    f.flush
  end
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
