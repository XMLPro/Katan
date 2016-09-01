var ws
$(() => {
    if(document.getElementById("map")){
  "use strict"
  // JavaなどでいうMain
  const ctx = document.getElementById("map").getContext("2d")
  ctx.fillStyle = '#3333ff'
  ctx.fillRect(0, 0, 500, 500)          // マップ全体を青色に

  const hoge = new Local()              // ローカル決め打ち
  const pm = new PaintMap(ctx)          // ライブラリを利用
  const tiles = hoge.init()

  let rects = new Array() //四角形の座標
  let tf = true
  for(var j=0; j<19; j++){
      for(var i=0; i<6; i++){
      let x = tiles[j].coordinates[i][0];
      let y = tiles[j].coordinates[i][1];
      tf  =true
      for (let value of rects) {
        if (Math.abs(value[0] - x) < 3 && Math.abs(value[1] - y) < 3) {
          tf = false
          break
        }
      }
      if (tf) {
        rects.push([x, y])
      }
    }
  }
  // ゲームループ とりあえず60FPSぐらいで描画
  setInterval(() => {
    pm.paintHexagons(5, tiles)            // タイルの描画
    pm.paintNum(tiles)                    // 数字の描画
    ctx.fillStyle = '#FF3333'
    for (let value of rects) {
      ctx.fillRect(value[0]-10, value[1]-10, 20, 20)

    }
  }, 1000 / 60)
    }

    ws = websocket();
    $("form").on("submit", function (e) {
      ws.trigger("chat", $("#msg").val());
      e.preventDefault();
    });

    ws.bind("chat_receive", function (data) {
      $("#msg_view").prepend("<li>" + data + "</li>")
    })
    
})