window.fp_ms = 0.06
window.t1 = 0
window.t2 = 0

window.turn = 1

window.doit = (a,b,c) ->
  window["t#{[window.turn]}"] = Date.now()
  window.turn += 1
  if window.turn == 3
    ms_diff = window.t2 - window.t1
    frame_diff = Math.floor(ms_diff * window.fp_ms)
    alert("frames: #{frame_diff}")
    window.turn = 1
  else
    window.turn = 2

window.startItUp = ->
  document.addEventListener("keypress", window.doit)
