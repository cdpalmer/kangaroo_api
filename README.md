# README

### System Requirements

Ruby 2.5.3

Rails 6

Postgres 9.6.10 and above

### What is this

This is a rails API that stores and processes data from OnConnect, a movie and theater API.

The only entry point is to create a zip code search.  This is done with an HTTP POST:

```
POST https://kangaroo-movies-api.herokuapp.com/searches?zip_code=80222
```

This endpoint will query the OnConnect API to look for theaters and their respective movie and show times within a 25 mile radius.
You will then receive a summary of the related data that has already been processed for that zip code, or the related data that was processed from the OnConnect API

Once data has been processed for the day, you can pull the found movies from the app:

```
GET https://kangaroo-movies-api.herokuapp.com/movies
```

If you'd like, you can sort through the movies by title:

```
GET https://kangaroo-movies-api.herokuapp.com/movies?sort=desc
```

### Notes

This is built off a free OnConnect API program, with limited API calls.

To save API calls, the zip code that is searched is saved.  Once a new zip code is submitted, the app will check if that zip code has been searched today, and only call the API if the consumer is requesting a new zip code's data.

When the app notices that the last zip code search was made before today's date, the data is wiped and we start the app clean and new.

### Tech notes

Standard rails application start up:

1. Clone the repo.

2. `bundle install` the gems

3. Create and migrate the database: `rake db:create db:migrate`

_NOTE_: For testing, there are no fixtures or seed data yet.  Everything is built of a webmock example of the OnConnect API payload

4. `rails s` will start the server

5. Go ahead and hit the local server with a new zip code search:
```
curl -X POST 127.0.0.1:3000/searches\?zip_code\=80222
```

_NOTE:_ I am aware I've committed the API key into my private repo.  It won't stay that way, it was just a last resort from difficulties of using ENV vars in the app.  
