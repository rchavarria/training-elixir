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

## Configuring channels support

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

We can start adding JavaScript code to `/assets/js/app.js`

**What We Saw**

Brunch bundles your application’s JavaScripts into a single file. This is stored in `priv/static/js/app.js`, and rebuilt every time you build the app.

Brunch constructs this from `assets/js/app.js`, which can be considered to be the entry point for your JavaScript code. Any additional JavaScript files imported or required into this file (either directly or transitively) will be included in the target `app.js`.

The default `assets/js/app.js` simply imports `phoenix_html`. This contains support code for all Phoenix apps.

We wrote our Hangman code in the file `hangman_app.js`, and included it in the file build by importing it into `app.js`. Remember to use a relative path to refer to JavaScript files in the local file tree.

Later, we’ll add view-related code to `hangman_app.js`. To keep our code clean, we added a second JavaScript file, `hangman_socket.js`, to handle the traffic to and from the server.

We can use the default Phoenix `PageController`, view, and template to load our JavaScript into the browser. As we’ll see later, you can also use it to populate a template DOM for the client-side JavaScript to use.

I use Chrome, and its DevTools has a handy-dandy WebSocket inspector build in. Click the WS (web socket) button at the top of the network tab.

## Joining a channel

On the client, the sequence is

```javascript
// /socket matches the name in endpoint.ex

let socket = new Socket("/socket", {})
socket.connect()

// hangman.game is the topic. It is routed though
// user_socket.ex to hangman_channel.ex
let channel = socket.channel("hangman:game", {})
channel.join()
```

We’ll see in the next unit that the `join()` call is asynchronous.

## Pushing the tally from the server

The call to `channel.join()` is asynchronous, which means we have to register callback functions for the success and failure returns.

```javascript
  this.channel
      .join()
      .receive("ok", resp => {
        console.log("Joined successfully", resp)
        this.fetch_tally()
      })
      .receive("error", resp => {
        alert("Unable to join", resp)
        throw(resp)
      })
```

In fact, from this point on both the client and server are operating as asynchronous event handlers, running when messages are received over the channel (and when the player interacts on the client).

When the server receives a `join` request, it can initialize state that can be used for the rest of the conversation.

The `socket` value that is passed to every WS call is similar to the `conn` value passed in HTML controllers—it can be updated as events are handled and passed to the next event.

A `conn` value uses the `session` field for this, but the `socket` value has a field called `assigns`. (This is poor naming, because it has nothing to do with the concept of assigns on the HTML side.)

On the server, we handle incoming messages by writing callbacks

```
def handle_in("tally", _, socket) do ...
```

As all functions are called using pattern matching, you can write multiple versions of this function that respond both to different message names and potentially to different values in the paramaters passed on in the socket.

On the client, we handle incoming messages using

```
channel.on("tally", response => { . . . })
```

## Introduction to data binding

## Finishing the client


