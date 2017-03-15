# FREEBASSEL

FREEBASSEL is a campaign to bring about the safe and immediate release of Bassel Khartabil from wrongful detainment in Syria since March 2012. He is a well known contributor to global software and culture communities like Creative Commons, Mozilla Firefox, Wikipedia, Openclipart, Fabricatorz, and Sharism. He is missed by these communities, his family, friends and loved ones. The campaign says, We will not stop campaigning for him until we see him as a free global citizen once again.

[freebassel.org](http://freebassel.org)

## Development

### Requirements

* Ruby

### Installation

    gem install bundler
    git clone https://github.com/freebassel/freebassel.org
    cd freebassel.org
    bundle install

### Run the site in development mode

    bundle exec jekyll serve

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

Press posts may not have any more categories other than `press`.

If you have time, copy the HTML of the news article and paste it below the frontmatter.

### Adding events

Events go in the `_posts` directory just like news, but use the
following frontmatter:

    ---
    layout: events
    title: "Event Title"
    categories: [ events ]
    ---

Event posts may have *one* additional category to indicate the hashtag
for the event, such as `[ events, whereisbassel ]`.

### Addding headlines

If you want the post to be a headline on the top of the homepage, add
the `headline` tag to its frontmatter:

    ---
    layout: events
    title: "Event Title"
    categories: [ events ]
    tags: [ headline ]
    ---

### Adding testimonials

To add a new notable quote to the homepage, edit the `_data/testimonials.yaml` file, and add a new entry, following this template:

    - name: NAME
      affiliation: POSITION, ORGANIZATION
      quote: "QUOTE"
      image: IMAGE_URL

The image should be at least 60px in either dimension and have the subject in the center (The smallest square Flickr photos of 75 × 75px work perfectly). You can save the image locally in the `/assets/images/photos/` directory.

### Updating the supporters list

If you have access to the Freebassel supporters list via Google Docs, you can update it with a script.

Create a Google API client ID and secret, as per these instructions:

  * https://developers.google.com/drive/web/auth/web-server

Copy `config/config-sample.rb` to `config/config.rb` and fill in the Client ID, Secret, and the spreadsheet ID.

Run the script with:

    bundle exec rake update_supporters_list

Follow the instructions to authorize the application. The `_data/supporters.json` will be updated.

### Updating the change.org petition data.

You'll need an API key from [change.org](https://change.org). You can find instructions [here](https://www.change.org/developers/api-key).

Set the value of CHANGE_ORG_API_KEY in config.rb.

Run the rake task with

    bundle exec rake fetch_change_org_petition
