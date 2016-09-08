# Suzy
## A Simple Message Queue

This is an experiment in writing a message broker. It's written in Ruby and backed by Postgres.

### About

This is a simple message broker that uses HTTP calls to queue and dequeue messages. The API was designed with
Grape, and the APIs are self-documenting. In fact, after starting the app, you can visit the admin console
(http://your-queue-host/console) and click "Routes" to see the available API endpoints.

### Usage

After starting the application, you can visit the console to view the current queues, as well as the pending messages.

Using the console, you click "Purge" besides a queue to empty it of message, or "Delete" to entirely delete the queue
and all associated messages.

Currently, the API to queue and dequeue messages supports one version ("v1"). It's usage is simple and there are three
routes:

`GET /v1/queues`

This route will return a JSON object in the response body that contains the queues and their pending message counts.

```
{
  "queue-1": 35,
  "queue-2": 22
}
```

`GET /v1/queues/:queue-name`

Use this route to retrieve a pending message from the named queue.

```
{
  "body": "Message body!",
  "headers" : { 
    "arbitrary-header": "arbitrary metadata",
    "arbitrary-header-2": "yet more arbitrary metadata"
  }
}
```

`POST /v1/queues/:queue-name`

Use this route to queue a new message into the named queue.

The request body should look like the message above, with a body and any arbitrary headers
as a JSON object.

### Installation

There is currently not a gem package for this. Just clone this repo, then run `bundle install` and `bundle exec rackup`.  
The default server is Puma.
