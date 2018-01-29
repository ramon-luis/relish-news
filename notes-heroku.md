# Heroku Cheat Sheet

Heroku.com is a "platform as a service" that simplifies the task of
deploying web application code to the cloud, so that your users can visit
your application in a secure, hosted environment.  

Heroku was first imagined as a Rails deployment service, but now supports many major
frameworks.

### Prerequisites and Concepts

* Before you deploy, your code must:
  * live in a local Git repository
  * have all files saved to disk
  * have been committed locally  
* For class, I will use a local Git repository.
* You must configure your application to conform to certain expectations so that Heroku can make sense
 of your application and run it.
* The Free account level puts your application "to sleep" if it has no traffic for 30 minutes.  The
next request will "wake it up" which takes 5-10 seconds.
* Your deployed application is assigned a random subdomain of `herokuapp.com`; for example,
`bluesky-giraffe.herokuapp.com`.  You can choose a custom subdomain, but your choice might already
be taken by someone else.
* If you want to use your own domain name entirely, you can buy it yourself and configure DNS appropriately.
I can't cover that in class, but the Heroku documentation is very helpful.


### Deployment Cheat Sheet

**Step 1: Edit Your Gemfile**

_[WARNING: Do not run `bundle install` until the Step 2]_

We can use Sqlite in our development and test environments, but not in production.  
Good choices for the production environment are MySQL, Postgresql, SQL Server, Oracle, and DB/2.  
Heroku only supports Postgresql. Therefore we need to configure our Gemfile like this:

``` ruby

group :development, :test do
  gem 'sqlite3'
  # ... other gems
end

group :production do
  gem 'pg'
  # ... other gems
end
```

The Gemfile we use in class has already been updated for you.

**Step 2: Bundle without Production gems**

You do not need to install the actual production gems on your machine, and the pg gem in particular can be
troublesome.  However, we still need to perform gem dependency resolution and update the Gemfile.lock
file appropriately:

`bundle install --without production`

**Step 3: Create a Heroku application under your account**

Assuming you have the Heroku CLI installed, you can initialize a new "application" under your Heroku account:

`heroku create [subdomain]`

You can leave the subdomain blank, in which case Heroku will generate a random one for you.

**Step 4: Commit Your Latest Changes**

```
git add -A
git commit -m "My commit message goes here"
```

**Step 5: Deploy (push) your code to your Heroku git repository**

`git push heroku master`

If you are familiar with Git branches, you can replace "master" with "[branchname]:master" to push your local
branch to Heroku's master branch.

**Step 6: Run your Rails tasks**

Heroku only supports the old-style `rake` syntax:

```
heroku run rake db:migrate
heroku run rake db:seed
```

**Step 7: Navigate to Your App**

Use `heroku open` or just put the URL into your browser.

Repeat Steps 5 and 6 as necessary.


**HOW TO: View Your Server Log**

`heroku logs` or `heroku logs --tail`
