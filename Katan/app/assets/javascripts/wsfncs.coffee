$ ->
  ws = websocket()
  ws.bind "chat_receive", (data) -> $("#msg_view").prepend("<li>#{data}</li>")
  ws.bind "notice", (data) ->
    alert(data.result)
  ws.bind "draw_info", (data) ->
    $(".info-wrap").html(data)
  ws.bind "draw_building", (data) ->
    target = $($("." + data.place)[data.position])
    target.attr({"src": image_path(data.image_name)})
  ws.bind "draw_info", (data) ->
    $(".info-wrap").html(data)
  ws.bind "dice_info", (data) ->
    $(".dice-info").html("サイコロの目は#{data}でした！")
