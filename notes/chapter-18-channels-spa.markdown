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

Client considerations:

1. Pushing to and getting events from Phoenix is easy
2. Keeping the UI state in step is more difficult. We'll use data binding instead of raw event handlers to update the UI

We're going to use [Vue.js](https://vuejs.org/) to do that data binding. One of the first steps is to create an initial state for our application. We're going to use the `tally` returned by the server as a scheleton for our data model, our application state.

## Finishing the client

What We Saw

- Vue is one of a large number of JavaScript libraries that perform two-way mapping between a single definitive data source and its appearance on the browser screen (or, more accurately, its representation in the browser’s Document Object Model, or DOM).

- We tell Vue to manage a JavaScript object that represents the tally created by our game. Once that’s done, we can reference values in this object by name in our view. When the server sends changes, the view updates automatically.

- Vue can use the values in out object to represent both displayed data and the attributes on HTML tags (such as class and disabled). It also supports computed values, which look like data in the data source but are actually computed from it.

- Vue also supports callback methods, which make it each to tie browser events to code to be run.

- Careful choice of a JavaScript framework can dramatically simplify writing a client-side application.

The Final Code is available in our repository in the branch 180-code-channels:

```bash
$ git clone https://github.com/pragdave/e4p-code.git # if needed
$ git fetch origin 180-code-channels
$ git checkout 180-code-channels
$ cd game/socket_gallows
```

### Exercises

**If you lose a game, you currently never get to see the correct word. Change the hangman server to return the correct word in the letters list when a game is lost, and update the client to display it**

Done. The Hangman game builds the *tally* slightly different, showing all letters, guessed and not guessed.

