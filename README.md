# Heroku PG Rails Dev

Helper methods for working with Rails and heroku in a local environment.

## Usage

```
heroku pg:sync -a <application>
```

Drops your local development DB, captures a snapshot of the heroku DATABSE_URL and loads it up locally.
