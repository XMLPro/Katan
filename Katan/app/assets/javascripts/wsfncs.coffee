$ ->
  ws = websocket()
  broadcast_ws = broadcast_websocket()

  ws.bind "chat_receive", (data) -> $("#msg_view").prepend("<li>#{data}</li>")
  ws.bind "draw_info", (data) ->
    $(".info-wrap").html(data)

  broadcast_ws.bind "notice", (data) ->
    alert(data.result)
  broadcast_ws.bind "draw_building", (data) ->
    target = $($("." + data.place)[data.position])
    target.attr({"src": image_path(data.building_type)})
