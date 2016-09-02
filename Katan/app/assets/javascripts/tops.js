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
        let intersections = $(".intersection")
        let map_coordinate = $('#map').offset();
        let x = map_coordinate["left"] - 10;
        let y = map_coordinate["top"] - 10;
        for(let i = 0; i < intersections.length; i++){
            $(intersections[i])
                .css("width", "20px")
                .css("height", "20px")
                .css("left", x + rects[i][0] + "px")
                .css("top", y + rects[i][1] + "px");
        }
        // ゲームループ とりあえず60FPSぐらいで描画
        setInterval(() => {
            pm.paintHexagons(5, tiles)            // タイルの描画
            pm.paintNum(tiles)                    // 数字の描画
        }, 1000 / 60)
    }

    ws = websocket();
    $("#form").on("submit", function (e) {
        ws.trigger("chat", $("#msg").val());
        e.preventDefault();
    });

    ws.bind("chat_receive", function (data) {
        $("#msg_view").prepend("<li>" + data + "</li>")
    })
})
