{
  "use strict"
  // JavaなどでいうMain
  const ctx = document.getElementById("map").getContext("2d")
  ctx.fillStyle = '#3333ff'
  ctx.fillRect(0, 0, 500, 500)          // マップ全体を青色に

  const hoge = new Local()              // ローカル決め打ち
  const pm = new PaintMap(ctx)          // ライブラリを利用

  const tiles = hoge.init()

  // ゲームループ とりあえず60FPSぐらいで描画
  setInterval(() => {
    pm.paintHexagons(5, tiles)            // タイルの描画
    pm.paintNum(tiles)                    // 数字の描画
  }, 1000 / 60)
}
