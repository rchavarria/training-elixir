# Channels and a Single Page App

## Introuction to Phoenix channels

Channels are:

- bidirectional communication between client and server
- nested inside conventional HTTP requests
- reliable, performant, cross browser

In HTTP requests, the client (browser) sends the request, and it's routed to a controller method that then renders a view

With channels, first, the socket must be opened. A new connection is created between the browser and the server. From this point, both client and server can start sending messages. Both sides, must have message listeners, to respond to those messages. 

Channel modules are similar to Controller modules in the Phoenix side.

We can have multiple channels on each socket. One browser gets only one socket.

Phoenix terminology: the *endpoint* defines a socket (similar to HTTP endpoints), the *socket* defines the channels, the *channels* handle the messages

## Configuring channes support

## Adding JavaScript

## Joining a channel

## Pushing the tally from the server

## Introduction to data binding

## Finishing the client


