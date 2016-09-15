$ ->
  ws = websocket()
  ws.bind "notice", (data) -> alert(data.result)
  ws.bind "chat_receive", (data) -> $("#msg_view").prepend("<li>#{data}</li>")
  ws.bind "draw_building", (data) ->
    $($(".intersection")[data.intersection_pos]).css("background-color", "blue")
