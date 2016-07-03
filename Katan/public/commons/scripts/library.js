// マップ描画
class PaintMap {
  constructor(ctx) {
    this.ctx = ctx;
  }
  // 六角形単体の描画を行う
  paintHexagon(x, y, r) {
    this.ctx.fillStyle = '#55ff55'
    this.ctx.beginPath()
    for(let i = 0; i <= 2 * Math.PI; i += 2 * Math.PI / 6) {
      this.ctx.lineTo(x + Math.sin(i) * r, y + Math.cos(i) * r)   // 六角形の各点の描画
    }
    this.ctx.closePath()
    this.ctx.stroke()
    this.ctx.fill()
  }

  // 六角形の全体配置を決定する関数
  paintHexagons(row = 5, tiles) {
    for(let i = 0; i < tiles.length; i++) {
      console.log(tiles[i])
      this.paintHexagon(tiles[i].getX(), tiles[i].getY(), 50)
    }
  }

  paintNum(tiles) {
    // 未実装
    console.log(tiles[0].getNumber())
  }
}

class Tile {
  constructor(resource, number, x, y) {
    this.resource = resource
    this.number = number
    this.x = x
    this.y = y
  }
  getResource() {
    return this.resource
  }
  getNumber() {
    return this.number
  }
  getX() {
    return this.x
  }
  getY() {
    return this.y
  }
}

const GenerateTiles = ((tileNum = 19) => {
  const tiles = new Array(tileNum)
  const row = 5
  let count = 0
  for(let i = 1; i <= row; i++) {
    for(let j = 1; j <= row - Math.abs((row - 2) - i); j++) {
      // 座標のずらし方は適当
      tiles[count] = new Tile(0, 6, j * 92 + 45 * Math.abs((row - 2) - i) - 20, i * 80)
      count++
    }
  }
  return tiles
})
