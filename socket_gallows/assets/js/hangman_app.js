const RESPONSES = {
    won:          [ "success", "You Won!" ],
    lost:         [ "danger",  "You Lost!" ],
    lost_timeout: [ "danger",  "It took you too much time, Loser!" ],
    good_guess:   [ "success", "Good guess!" ],
    bad_guess:    [ "warning", "Bad guess!" ],
    already_used: [ "info",    "You already guessed that" ],
    initializing: [ "info",    "Let's Play!" ]
}

import HangmanSocket from "./hangman_socket"

let view = function(hangman) {
    let app = new Vue({
        el: "#app",
        data: {
            tally: hangman.tally
        },
        computed: {
            game_over: function() {
                let state = this.tally.game_state
                return (state == "won") || (state == "lost") || (state == "lost_timeout")
            },
            game_state_message: function() {
                let state = this.tally.game_state
                return RESPONSES[state][1]
            },
            game_state_class: function() {
                let state = this.tally.game_state
                return RESPONSES[state][0]
            }
        },
        methods: {
            guess: function(ch) {
                hangman.make_move(ch)
            },
            new_game: function() {
                hangman.new_game()
            },
            already_guessed: function(ch) {
                return this.tally.used.indexOf(ch) >= 0
            },
            correct_guess: function(ch) {
                return this.already_guessed(ch) &&
                       (this.tally.letters.indexOf(ch) >= 0)
            },
            turns_gt: function(left) {
                return this.tally.turns_left > left
            }
        }
    })
    return app;
}

function keyup_listener(event, hangman) {
  if (event.keyCode < 65) {
    console.log("key", event.key, "is not in the allowed range (a-z)")
    return
  }

  if (event.keyCode > 90) {
    console.log("key", event.key, "is not in the allowed range (a-z)")
    return
  }

  hangman.make_move(event.key)
}

window.onload = function() {
    let tally = {
        turns_left:   7,
        letters:      ["a", "_", "c" ],
        game_state:   "initializing",
        used:         [ ],
        seconds_left: 60
    }
    let hangman = new HangmanSocket(tally)
    let app     = view(hangman)

    document.addEventListener("keyup", function (event) {
      keyup_listener(event, hangman)
    })

    hangman.connect_to_hangman()
}
