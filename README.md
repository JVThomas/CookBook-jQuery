# cookbook
cookbook is a simple Rails App that allows users to view and create recipes and comments to be posted on the site. The app utilizes Ruby on Rails and jQuery to serve up profiles, recipes, and comments (with jQuery allowing for dynamic page updates without browser refresh or re-route).

### Run
Downlaod the repo, create and migrate the database (rake db:create, rake db:migrate) and finally rails s to run.
Note: The app utilizes Postgres as a database, so make sure you have it running in the background. Furthermore, Facebook OAuth login requires your own API key. Simply register for one at https://developers.facebook.com/.

A demo of the app can be found here: http://cookbook-jquery.herokuapp.com/
