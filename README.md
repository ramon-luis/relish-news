# README

Relish News is a news reader that allows users to save favorite newsfeeds.

Important: run `db:seed` to populate topic database before running


## Layout

* **Headlines**: displays news headlines based on user's favorite topics.  Default is top US news headlines if no user logged in or no user favorites.  This view is a minimal view that allows easy scanning of headlines.
* **Sections (Top US, Business, Sports, Tech)**: browse news "sections" by topic.  These are fixed sections (i.e. user cannot change) and show a "richer" view that includes headlines, image, and preview.
* **Search**: allows users to search for news (across entire internet) based on input
* **Favorites** (if logged in): allows user to manage favorites (CRUD)
* **Account** (if logged in): allows user to manage account admin (name, email, password)


## Models

* **User** (CRUD) allows users can create an account, edit an account, and delete an account
* **Favorite** (CRUD): allows users to create, edit, and delete favorite newsfeeds based on topic
* **Topic**: maintains useful information about news topics such as name, param_url to pass to API, and route to pass to controller to view within application
* **NewsAPI**: used to acess remote data via JSON from [News API](https://newsapi.org)

## Development Notes

* I have intentionally attempted to develop much of the application in advance due to limited personal time during the last weeks of the quarter.
* Remaining (hopeful) development includes:
  * properly connecting Topics and Favorites
  * sorting Headline sections based on user favorite rank
  * link Headline titles to "richer" topic view
  * ability to save search queries as user favorite topics
  * add dropdown to menu bar to browse more topics
  * make the header fixed
  * create an about page
  * improve visual appearance
  * refactor code, including creating partials where applicable

## References

The code base originated from the required [starting point](https://github.com/ucwebdev/starting-point).

Certain sections of code (including user login and authentication) are based upon code in the [Ruby Rails Tutorial](https://www.railstutorial.org).
