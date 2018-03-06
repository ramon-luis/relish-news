# README

Relish News is a news reader that allows users to save favorite newsfeeds.

Users can:
* create an account
* update an account
* delete an account
* create (save) favorite topics
* update the ranking of favorite topics
* delete favorite topics
* view news topics as a collection of headlines or a collection of article cards
* view news articles as text only or open the original source
* browse news topics and sources
* search for news
* save topics, sources, and searches as favorite topics

**Important:** run `db:seed` to populate topic database before running


## Layout

* **Headlines**: displays news headlines based on user's favorite topics.  Default is top US news headlines if no user logged in or no user favorites.  This view is a minimal view that allows easy scanning of headlines.
* **Sections (Top US, Business, Sports, Tech)**: browse news "sections" by topic.  These are fixed sections (i.e. user cannot change).
  * Users can choose to read sections in a "richer" view that includes headlines, image, and preview or read sections by headlines only.
  * Users can read simplified versions of articles within the application that contain text and limited images
* **Search**: allows users to search for news (across entire internet) based on input
  * Users can save searches as favorite topics
* **Favorites** (if logged in): allows user to manage favorites (CRUD)
* **Account** (if logged in): allows user to manage account admin (name, email, password)


## Models

* **User** (CRUD) allows users can create an account, edit an account, and delete an account
* **Favorite** (CRUD): allows users to create, edit, and delete favorite newsfeeds based on topic
* **Topic**: maintains useful information about news topics such as name, param_url to pass to API, and route to pass to controller to view within application
* **NewsAPI**: used to acess remote data via JSON from [News API](https://newsapi.org)

## Development Notes

* Notable development:
  * ability to save search queries as user favorite
  * ability to view article text directly in relish news app with link to original source
    * source HTML is parsed and reformatted to display in easy to read format
    * Textract gem parses original HTML to pull out article text with markdown formatting
    * Redcarpet gem parses markdown formatted text to HTML
  * ability to toggle views between headlines only and article cards (image & preview)
  * dropdown in navbar to browse more topics
  * fixed navbar that always remains at top of screen
  * custom fonts
  * refactored code with partials where applicable

## References

The code base originated from the required [starting point](https://github.com/ucwebdev/starting-point).

Certain sections of code (including user login and authentication) are based upon code in the [Ruby Rails Tutorial](https://www.railstutorial.org).
