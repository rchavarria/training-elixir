# Channels and a Single Page App

## Introduction to Phoenix channels

Channels are:

- bidirectional communication between client and server
- nested inside conventional HTTP requests
- reliable, performant, cross browser

In HTTP requests, the client (browser) sends the request, and it's routed to a controller method that then renders a view

With channels, first, the socket must be opened. A new connection is created between the browser and the server. From this point, both client and server can start sending messages. Both sides, must have message listeners, to respond to those messages. 

Channel modules are similar to Controller modules in the Phoenix side. Socket module is like the Router.

We can have multiple channels on each socket. One browser gets only one socket.

Phoenix terminology: the *endpoint* defines a socket (similar to HTTP endpoints), the *socket* defines the channels, the *channels* handle the messages

## Configuring channes support

The endpoint can be found on `lib/socket_gallows_web/endpoint.ex`

The socket module, similar to the router module, is found on `lib/socket_gallows_web/channels/user_socket.ex`

We're going to create our channels on `lib/socket_gallows_web/channels/` folder

**What We Saw**

We looked at the code to see how the endpoint connects a socket to a socket handler (user_socket.ex) and how the socket handler then acts as a router, forwarding requests to a channel based on the topic.

Channels are a little like controllers in HTML servers: they handle incoming requests from the browser.

The join function in the channel is called when a client asks to join the channel. It can pattern match on the topic name.

**Every App is Special**

A thread that runs through this course is the idea of designing for decoupling using the Single Responsibility Principle. As we’ve seen, this applies equally to individual functions, to complete modules, and to entire applications.

So when it came time to add websocket (WS) support to Hangman, we resisted the temptation to stick the new code into the existing Gallows app. The reason—the two apps really have almost nothing in common.

In some frameworks, you’d be forced to shoehorn the WS code into the HTML server because that server contained all the application logic. But we’ve been careful to keep things separate—the game logic is its own application.

Think of the flexibility this gives us. We could version our API by simply deploying the WS server to different URLs, all without impacting the HTML users. We could deploy WS servers to machines with a different configuration to the HTML servers, as their usage characteristics might be different. The WS server can have a totally different release and bug fix cycle to the HTML server.

It seems to make a lot of sense.

## Adding JavaScript

## Joining a channel

## Pushing the tally from the server

## Introduction to data binding

## Finishing the client


