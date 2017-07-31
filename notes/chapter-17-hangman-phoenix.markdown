# Hangman and Phoenix

## (Re)creating the Phoenix app with a Hangman connection

We're going to make our Phoenix app depend on our Hangman application

Where are we going to create the connection to Hangman? Based on the URL, so that each URL http://xx/hangman will be routed to our Hangman app in some way. Go and update `gallows/web/router.ex` file

Create a new *scope* for the route, a controller, a view and a template

Phoenix apps are created with a default `Page` controller/view/template. You’ll probably want to either delete or rename them in order to get your route (http://yourserver.com/hangman) working

## An initial server

## Add a form

## More complex helpers

## Wrapping up: adding graphics

