// マップ描画
class PaintMap {
  constructor(ctx) {
    this.ctx = ctx;
      this.x = 0
      this.y = 0
  }

  setPosition(x, y){
      this.x = x
      this.y = y
  }

  getPosition(){
      return [this.x, this.y]
  }

  // 六角形単体の描画を行う
  paintHexagon(color, x, y, r) {
    this.ctx.fillStyle = color
    this.ctx.beginPath()
    for(let i = 0; i <= 2 * Math.PI; i += 2 * Math.PI / 6) {
      this.ctx.lineTo(x + Math.sin(i) * r, y + Math.cos(i) * r)   // 六角形の各点の描画
    }
    this.ctx.closePath()
    this.ctx.stroke()
    this.ctx.fill()
  }

  paintHexagons(row = 5, tiles, colorPack) {
    tiles.forEach(tile => this.paintHexagon(colorPack[tile.getField().attr("resource_type")], tile.getX(),tile.getY(), 50))
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
        tile.getField().css({
            left: tile.getX() + this.x - tile.getField().width()/2,
            top: tile.getY() + this.y - tile.getField().height()/2
        })
    })
  }
}

class Tile {
  constructor(field, x, y) {
    this.field = field
    this.x = x
    this.y = y
    this.coordinates = new Array(6)
    for (var i = 0; i < 6; i++) {
      this.coordinates[i] = [x+52.5*Math.cos(i*Math.PI/3+Math.PI/2),
          y+52.5*Math.sin(i*Math.PI/3+Math.PI/2)]
    }


  }
  getField() {
    return this.field
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
  init(fields) {
    return this.GenerateTiles(fields)
  }
}

class Local extends Base{
  GenerateTiles(fields) {
    const tileNum = fields.length
    const tiles = new Array(tileNum)
    const row = 5
    let count = 0
    for(let i = 1; i <= row; i++) {
      for(let j = 1; j <= row - Math.abs((row - 2) - i); j++) {
        // 座標のずらし方は適当
        tiles[count] = new Tile($(fields[count]), j * 92 +45 * Math.abs((row - 2) - i) -20, i * 80)
        count++
      }
    }
    return tiles
  }
}

class Server extends Base{
  GenerateTiles(fields) {
    // 未実装
  }
}

function websocket(){
    if(!ws) return new WebSocketRails(location.host + "/websocket")
    else return ws
}

function broadcast_websocket(){
    if(!broadcast_ws) return websocket().subscribe("broadcast")
}
