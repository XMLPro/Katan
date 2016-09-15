$ ->
  ws = websocket()
  ws.bind "notice", (data) -> alert(data.result)
  ws.bind "chat_receive", (data) -> $("#msg_view").prepend("<li>#{data}</li>")
  ws.bind "draw_building", (data) ->
    intersection = $($(".intersection")[data.intersection_pos])
    console.log(data)
    console.log(image_path(data.building_type))
    intersection.attr({"src": image_path(data.building_type)})
