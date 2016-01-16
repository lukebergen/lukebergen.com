window.State = {
  current_char: "",
  reaction_times: [],
  start: 0,
  misclicks: 0,
  number_of_reactions: 0
}

setup_reaction = ->
  input_letters = document.getElementById("letters").value.split(",")
  reaction_char_el = document.getElementById("react-to-this")
  rand = Math.round(Math.random() * 1000) % input_letters.length
  window.State.current_char = input_letters[rand]
  window.State.misclicks = 0
  window.State.start = new Date()
  reaction_char_el.innerHTML = window.State.current_char

  left = Math.round((window.innerWidth - 20) * Math.random())
  top = Math.round((window.innerHeight - 20) * Math.random())
  reaction_char_el.style["left"] = "#{left}px"
  reaction_char_el.style["top"] = "#{top}px"

start = ->
  window.State.reaction_times = []
  window.State.number_of_reactions = 0
  setup_reaction()

react = (event) ->
  char = String.fromCharCode(event.keyCode)
  if char == State.current_char
    window.State.reaction_times.push( (new Date()) - window.State.start + (500 * window.State.misclicks))
    if window.State.number_of_reactions == 11
      # we're done. Display results and such
      document.getElementById("react-to-this").innerHTML = ""
      lis = ""
      total = 0
      for r in window.State.reaction_times
        total += r
        lis = lis + "<li>#{r}</li>"

      lis += "<li>average: #{total / window.State.reaction_times.length}</li>"
      document.getElementById("results").innerHTML = lis
    else
      window.State.number_of_reactions += 1
      setup_reaction()
  else
    window.State.misclicks += 1

document.addEventListener "DOMContentLoaded", ->
  start_button = document.getElementById("start-button")
  start_button.addEventListener("click", start)
  start_button.addEventListener("keypress", react)
