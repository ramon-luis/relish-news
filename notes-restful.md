### RESTful Development

* A _resource_ is something a user considers to be valuable.
* The internet is a collection of _resources_
* Servers hold resources and can hand out _representations_ of them
* Clients manipulate resources by sending HTTP requests
* An HTTP request consists of a _headers_ and a _body_.
* The two most important headers are the HTTP _method_ and _URL_.
* A URL is a resource locator, not a webpage address.
* A URL is usually a noun: `/flights`, `/products`, `/friends`
* The _method_ is sometimes called the _verb_.

HTTP Methods are: `GET`, `POST`, `PATCH`, and `DELETE`.

These (eerily) correspond to the typical database operations of
`READ`, `CREATE`, `UPDATE`, and `DELETE`.

Resources generally offer two `GET` representations: one for the entire collection,
and one for a particular item: `/flights/` and `/flights/329`; `/products` and `/products/teapot`.

Therefore, in theory, there are five ways for a client to interact with a server-based resource.  
For example, let's assume we have a resource named _flights_:

```
VERB      DB OPERATION    URL                Meaning
--------  ------------    --------------     ---------------------------------------
GET       READ            /flights           Retrieve the list of flights
GET       READ            /flights/:id       Retrieve the details of a single flight
POST      CREATE          /flights           Add a new flight to the list
PATCH     UPDATE          /flights/:id       Update the details of a single flight
DELETE    DELETE          /flights/:id       Remove a flight from the list
```

In practice, however, there are seven actions, not five, because a web application
needs the ability to display forms for the POST and PATCH scenarios:

```
HTTP VERB  DB OPERATION   URL                  Meaning
--------   ------------   ------------------   ---------------------------------------
GET        READ           /flights             Retrieve the list of flights
GET        READ           /flights/:id         Retrieve the details of a single flight
GET                       /flights/new         Retrieve a form to add a new flight
POST       CREATE         /flights             Add a new flight to the list
GET                       /flights/:id/edit    Retrieve a form to modify flight details
PATCH      UPDATE         /flights/:id         Update the details of a single flight
DELETE     DELETE         /flights/:id         Remove a flight from the list
```

> "In theory, theory and practice are the same; in practice, they are not." -- Unknown Genius

### The Golden 7

We can establish a convention for handing every type of request to different MVC handlers:

```
VERB       DB OPERATION   URL                  Handler Action
--------   ------------   ------------------   ---------------------------------------
GET        READ           /flights             index
GET        READ           /flights/:id         show
GET                       /flights/new         new
POST       CREATE         /flights             create
GET                       /flights/:id/edit    edit
PATCH      UPDATE         /flights/:id         update
DELETE     DELETE         /flights/:id         destroy
```

Therefore, every resource your application provides will need (a maximum of) seven routes.  

### The Grand Unified Theory of RESTful Development

This leads directly to the following consequence when using an MVC architecture
for web development:

* Your web application is nothing more than a collection of _resources_
* Each resource will be implemented by exactly one _controller_
* Each controller will require (at most) seven _actions_
* Each action may use one or more models to gather data for the corresponding _view_
