# FREEBASSEL

FREEBASSEL is a campaign to bring about the safe and immediate release of Bassel Khartabil from wrongful detainment in Syria since March 2012. He is a well known contributor to global software and culture communities like Creative Commons, Mozilla Firefox, Wikipedia, Openclipart, Fabricatorz, and Sharism. He is missed by these communities, his family, friends and loved ones. The campaign says, We will not stop campaigning for him until we see him as a free global citizen once again.

[freebassel.org](http://freebassel.org)

## Development

### Requirements

* Ruby
* [Bundler](http://bundler.io/)
* [Jekyll](http://jekyllrb.com/docs/installation/)

### Installation

    git clone https://github.com/Fabricatorz/freebassel.org
    cd freebassel.org
    bundle install

### Run the site in development mode

    jekyll serve

The site will compile and run at http://localhost:4000

### Adding news articles

To add a news article, create a file in the `_posts` directory, and name the file using this pattern:

    _posts/YYYY-MM-DD-domain.html

At the top of the file, add the frontmatter, following this template:

    ---
    layout: press
    title: "ARTICLE TITLE"
    source: "WEBSITE NAME"
    link: URL
    categories: [ press ]
    ---

If you have time, copy the HTML of the news article and paste it below the frontmatter.

### Updating the supporters list

If you have access to the Freebassel supporters list via Google Docs, you can update it with a script.

Create a Google API client ID and secret, as per these instructions:

  * https://developers.google.com/drive/web/auth/web-server

Copy `config/config-sample.rb` to `config/config.rb` and fill in the Client ID, Secret, and the spreadsheet ID.

Run the script with:

    bundle exec ruby get_supporters_data.rb

Follow the instructions to authorize the application. The `_data/supporters.json` will be updated.
