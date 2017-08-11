import HangmanSocket from "./hangman_socket"

window.onload = () => {
  const socket = new HangmanSocket()
  socket.connect_to_hangman()
}
