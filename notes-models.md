# Introduction to Models

A _model_ is something that is a virtual representation of something else.  In a web application, a model is software represenation
of a real-world thing.

In Rails, a model is a simple Ruby class that happens to live under
`app/models`.  Methods and data members of the class are designed to
embody the rules, behavior, and policies of the real-world objects
they represent. For example,
to build the website for United Airlines, we would need represent
many real-world things: passengers, airplanes, reservations, flights,
airports, baggage, and boarding passes. Each of these real-world
entities would be represented by a model.

Most models also act as a source of data. A _Flight_ class would
not only provide an interface to learn about the origin, destination,
and list of passengers, but would also have the capability to
persist this information to a database.

In Rails, a model that wants to persist its data to a database
simply derives from a base class named `ApplicationRecord`.  

A naming convention is used to automatically associate a model
class to its underlying table in the database:

* Model class names are _singular nouns_
* Table names are the _plural_ version of the class name

```
Model Class Name            Database Table Name
------------------          -------------------
Flight                      flights
Person                      people
Product                     products
Movie                       movies
Octopus                     octopi
Mouse                       mice
```

``` ruby
class Flight < ApplicationRecord
end

class Person < ApplicationRecord
end
```
TABLE: **flights**

|id|origin|departure_time|destination|flight_number|miles_earned|
|--|------|--------------|-----------|-------------|------------|
|14|ORD|9:40 am|JFK|133|705|
|15|LAX|12:19 pm|STL|501|1104|
|16|SEA|7:53 pm|SFO|242|489|

TABLE: **people**

|id|first_name|last_name|email|hobby|
|--|------|--------------|------------|------|
|26|Cookie|Monster|cookie@example.com|Eating cookies|
|27|Margaret|Hamilton|margaret@example.com|Building software|
|28|Alan|Turing|alan@example.com|Decryption|

## Defining Your Domain Models

Thanks to the `ez` gem, you can get your database up and running quickly, skipping the more formal `Migrations` functionality in Rails.

### Database Schema

Your database schema will be generated automatically based on a description of your domain models.

Each domain model is translated into two physical artifacts:

1. A Ruby class derived from `ApplicationRecord`
2. A table in a relational database

By default, Rails will take care of constructing a SQLite3 database file for you, named `db/development.sqlite3`.  All of your
tables will live inside of this file.

You will never touch this file directly.  Modifying the schema (tables and columns) and managing the data (rows) is all
done from Ruby.  

### 3-Step Recipe For Defining A Database-Backed Model

1. If you don't have a file named `db/models.yml`, run `rails db:migrate` to generate it.
2. Add the model definition to the `db/models.yml` file.
3. Run `rails db:migrate` to apply your specification to the database and to generate Ruby model classes,
if necessary (see below).

Whenever you change `db/models.yml`, be sure to `rails db:migrate` to update your database.

Here's an example of how all of these things relate to each other:

``` yml
# db/models.yml
Flight:
  origin: text
  departure_time: time
  destination: text
  flight_number: text
  miles_earned: integer
```

``` ruby
# app/models/flight.rb
class Flight < ApplicationRecord
end
```
TABLE: **flights**

|id|origin|departure_time|destination|flight_number|miles_earned|
|--|------|--------------|-----------|-------------|------------|
|14|ORD|9:40 am|JFK|133|705|
|15|LAX|12:19 pm|STL|501|1104|
|16|SEA|7:53 pm|SFO|242|489|
### Ruby Model Classes

Rails provides a component called _ActiveRecord_ to provide easy database acccess.  ActiveRecord adheres to a particular
pattern in computer science called an _object-relational mapper_ (ORM): it connects an object-oriented programming language (like Ruby)
to a relational database system (like SQLite3, Micosoft SQLServer, MySQL, Postgresql, Oracle, DB2, and more).

* _Models_ are simply Ruby classes that represent real-world things.
* In Rails, model files are expected to be in the `/app/models` folder.
* Database-backed models must derive from ApplicationRecord:  `class Flight < ApplicationRecord`.
* Model objects (instances) map to specific rows in the table, and object attributes map to specific column (cell) values.
* Use `rails console` to interact with your models and the live database.
* Learn how to "CRUD" data with model methods: `.new`, .`save`, `.find_by`, `.where`, `.update`, and `.delete`

# Cheat Sheet: Model CRUD in the Rails Console

Models are our gateway to our application's data set.  Each model is a table of data.  We can have as many rows in the table as we want.  The columns are defined by the model's schema.

Once a model's table schema has been defined in the `db/models.yml` file and the corresponding `app/models` class file exists, we can create new rows to the table by having the user fill out forms in our web interface or by manually adding rows by using the `rails console` tool.  We can also read rows from the table, update individual rows, and delete rows.

These four activities --- create, read, update, and delete --- are often referred to by their acronum, `crud`.

This cheat sheet summarizes how to CRUD any given model using the Rails console.

For the purposes of this cheat sheet, we will presume that our `db/models.yml` file looks like this:

``` ruby
Book:
  title: string
  author: string
  summary: text
  hardcover: boolean
```

and that you've run the `rails db:migrate` command.  You should end up with a Book model class defined in `app/models/book.rb` that looks like this:

``` ruby
class Book < ActiveRecord::Base
end
```

and the `db/schema.rb` file should look something like this:

``` ruby
ActiveRecord::Schema.define(version: 20170402002437) do

  create_table "books", force: true do |t|
    t.string  "title"
    t.string  "author"
    t.text    "summary"
    t.boolean "hardcover"
  end

end
```

### Start the Rails Console

To begin, make sure you've started the console by opening a command prompt at your application folder:

```
rails console
```

You should see something like this:
```
Welcome to the Rails Console.
------------------------------------------------------------

Use this console to add, update, and delete rows from the database.

Models: Book

HINTS:
* Type 'exit' (or press Ctrl-D) to when you're done.
* Press Ctrl-C if things seem to get stuck.
* Use the up/down arrows to repeat commands.
* Type the name of a Model to see what columns it has.

Loading development environment (Rails 4.2.4)
irb(main):001:0>
```

**IMPORTANT**: Don't forget to read the HINTS section that's displayed for you!

### Creating New Rows

Adding new rows to a model's data table is pretty easy.  We just use the `.create` method on our model class, and provide a *hash* of data that assigns cell values for each column in our new row.

``` ruby
irb(main):001:0> b = Book.new
irb(main):002:0> b.title = "Sherlock Holmes"
irb(main):003:0> b.author = "Sir Arthur Conan Doyle"
irb(main):005:0> b.save
   (0.1ms)  begin transaction
  SQL (0.4ms)  INSERT INTO "books" ("title", "author") VALUES (?, ?)  [["title", "Sherlock Holmes"], ["author", "Sir Arthur Conan Doyle"]]
   (1.1ms)  commit transaction
=> #<Book {"id"=>3, "title"=>"Sherlock Holmes", "summary"=>nil, "author"=>"Sir Arthur Conan Doyle", "hardcover"=>nil}>
```

There are some important things to notice in the above example:

* We don't have to provide values for every column.  If you don't provide a value for a `boolean` column, it will be assigned as `false`.  For all other column types, they will be `nil`.
* The INSERT jargon you see above is Ruby talking to the database on our behalf, instructing it to insert a new row into the table.
* The final line that starts with `=>` shows us the grand result of our `save` command.  We've created a new row for the `Book` model, and the database assigned it an arbitrary `id` value of `3`.

### Reading Rows of Data

Reading, or *querying*, our model is also pretty easy.  There are lots of ways we to read data from the table, depending in what question you'd like to ask.

**How Many Rows Are There?**

`Book.count`

**Display All Rows**

`Book.all`

**What is the first book?**

`Book.first`

**What is the last book?**

`Book.last`

**Retrieve the book that has an `id` of 1.**

`Book.find_by(id: 1)`

**Retrieve all hardcover books.**

`Book.where(hardcover: true)`

**Retrieve the first book in the table that was written by Plato.**

`Book.find_by(author: "Plato")`
`Book.where(author: "Plato").first`

**How many paperback books are there?**

`Book.where(hardcover: false).count`

### Accessing a Row's Attributes

Once you have a row's worth of data in hand, you can drill down to a specific attribute.  To make things a little easier to follow in these examples, we show how to first capture the result of a query into a variable, then ask for a specific attribute.

**Who wrote 'Sherlock Holmes'?**

``` ruby
mystery_book = Book.find_by(title: "Sherlock Holmes")
mystery_book.author
=> "Sir Arthur Conan Doyle"
```

**Is 'Sherlock Holmes' in paperback or hardcover?**

``` ruby
mystery_book = Book.find_by(title: "Sherlock Holmes")
mystery_book.hardcover?
=> false
```

### Updating a Row

You can also update existing data by using Ruby's familiar attribute syntax:

``` ruby
mystery_book = Book.find_by(title: "Sherlock Holmes")
mystery_book.title = "The Adventures of Sherlock Holmes"
mystery_book.save
=> true
```

Notice that we have to call the `.save` method to update the data table based on the contents of our `mystery_book` variable.

### Deleting a Row

Finally, here's how we delete a row:

``` ruby
mystery_book = Book.find_by(title: "Sherlock Holmes")
mystery_book.delete
```

If you want to delete every row in the table in one fell swoop, you can. Here, we will ask for a before-and-after count to prove that we did indeed lose all of our data:

``` ruby
Book.count
=> 1

Book.delete_all
=> 1

Book.count
=> 0
```
