# FREEBASSEL

FREEBASSEL is a campaign to bring about the safe and immediate release of Bassel Khartabil from wrongful detainment in Syria since March 2012. He is a well known contributor to global software and culture communities like Creative Commons, Mozilla Firefox, Wikipedia, Open Clip Art Library, Fabricatorz, and Sharism. He is missed by these communities, his family, friends and loved ones. The campaign says, We will not stop campaigning for him until we see him as a free global citizen once again.

[freebassel.org](http://freebassel.org)

# Updating the supporters list

If you have access to the Freebassel supporters list via Google Docs, you can update it with a script.

## Requirements

* Ruby
* Bundler

To install the necessary gems, run:

  bundle install

## Instructions

Create a Google API client ID and secret, as per these instructions:

  * https://developers.google.com/drive/web/auth/web-server

Copy `config/config-sample.rb` to `config/config.rb` and fill in the Client ID, Secret, and the spreadsheet ID.

Run the script with:

  bundle exec ruby get_supporters_data.rb

Follow the instructions to authorize the application. The `_data/supporters.json` will be updated.
