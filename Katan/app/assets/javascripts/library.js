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

  paintHexagons(row = 5, tiles) {
    tiles.forEach(tile => this.paintHexagon(tile.getX(),tile.getY(), 50))
  }

  paintNum(tiles, arcColor = '#eeeeee', numColor = '#444444') {
    this.ctx.font = '20px sans-serif'

    tiles.forEach(tile => {
      this.ctx.beginPath()
      this.ctx.fillStyle = arcColor
      this.ctx.arc(tile.getX(), tile.getY(), 20, 0, Math.PI * 2, true)
      this.ctx.fill()
      this.ctx.stroke()
      this.ctx.closePath()
      this.ctx.fillStyle = numColor
      this.ctx.fillText(tile.getNumber(), tile.getX() - 5, tile.getY() + 5, 10)
    })
  }
}

class Tile {
  constructor(resourceId, number, x, y) {
    this.resourceId = resourceId
    this.number = number
    this.x = x
    this.y = y
    this.coordinates = new Array(6)
    for (var i = 0; i < 6; i++) {
      this.coordinates[i] = new Array(x+52.5*Math.cos(i*Math.PI/3+Math.PI/2)
        ,y+52.5*Math.sin(i*Math.PI/3+Math.PI/2))
    }


  }
  getResourceId() {
    return this.resourceId
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

class Player {
  // 資源は未実装
  constructor(id, name, resourceNum) {
    this.id = id
    this.name = name
    this.resource = new Array(resourceNum, 0)
  }

  getId() {
    return this.id
  }

  getName() {
    return this.name
  }

  getResource() {
    return this.resource
  }

  setResource(resourceId, num) {
    this.resource[resourceId] = num
  }
}

class Base {
  constructor() {
  }
  init() {
    return this.GenerateTiles()
  }
}

class Local extends Base{
  GenerateTiles(tileNum = 19) {
    const tiles = new Array(tileNum)
    const row = 5
    let count = 0
    for(let i = 1; i <= row; i++) {
      for(let j = 1; j <= row - Math.abs((row - 2) - i); j++) {
        // 座標のずらし方は適当
        tiles[count] = new Tile(0, 12, j * 92 +45 * Math.abs((row - 2) - i) -20, i * 80)
        count++
      }
    }
    return tiles
  }
}

class Server extends Base{
  GenerateTiles() {
    // 未実装
  }
}

function websocket(){
    if(!ws) return new WebSocketRails("localhost:3000/websocket")
    else return ws
}
