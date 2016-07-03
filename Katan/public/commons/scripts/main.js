{
  "use strict"
  // JavaなどでいうMain
  const ctx = document.getElementById("map").getContext("2d")
  ctx.fillStyle = '#3333ff'
  ctx.fillRect(0, 0, 500, 500)          // マップ全体を青色に

  const tiles = GenerateTiles()
  const pm = new PaintMap(ctx, tiles)   // ライブラリを利用
  pm.paintHexagons(5, tiles)            // タイルの描画
  pm.paintNum(tiles)                    // 数字の描画
}
