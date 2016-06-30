// マップ描画ライブラリ
class paintMap {
  constructor(ctx) {
    this.ctx = ctx;
  }
  // 六角形単体の描画を行う
  paintHexagon(x, y, r, color) {
    this.ctx.fillStyle = color
    this.ctx.beginPath()
    for(let i = 0; i <= 2 * Math.PI; i += 2 * Math.PI / 6) {
      this.ctx.lineTo(x + Math.sin(i) * r, y + Math.cos(i) * r)   // 六角形の各点の描画
    }
    this.ctx.closePath()
    this.ctx.stroke()
    this.ctx.fill()
  }

  // 六角形の全体配置を決定する関数
  paintHexagons(row = 5, tileColor) {
    for(let i = 1; i <= row; i++) {
      for(let j = 1; j <= row - Math.abs((row - 2) - i); j++) {
        // 座標のずらし方は適当
        this.paintHexagon(j * 92 + 45 * Math.abs((row - 2) - i) - 20, i * 80, 50, tileColor)
      }
    }
  }
}
