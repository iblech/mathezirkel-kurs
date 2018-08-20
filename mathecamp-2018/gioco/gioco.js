gioco = {};

gioco.init = function () {
    gioco.canvas = document.createElement("canvas");
    gioco.canvas.style.backgroundColor = "white";
    gioco.canvas.width  = 600;
    gioco.canvas.height = 300;

    gioco.ctx = gioco.canvas.getContext("2d");
    // gioco.ctx.save();

    var cell = document.createElement("div");
    cell.style.display = "table-cell";
    cell.style.position = "absolute";
    cell.style.left = "0px";
    cell.style.top = "0px";
    cell.style.bottom = "0px";
    cell.style.width = "100%";
    cell.style.height = "100%";
    cell.style.textAlign = "center";
    cell.style.verticalAlign = "middle";

    cell.appendChild(gioco.canvas);

    gioco.pressedKeys = {};
    gioco.events = [];
    window.addEventListener("keydown", function (ev) {
        gioco.pressedKeys[ev.key] = true;
    });
    window.addEventListener("keyup", function (ev) {
        delete gioco.pressedKeys[ev.key];
    });
    gioco.canvas.addEventListener("click", function (ev) {
        var rect = gioco.canvas.getBoundingClientRect();
        if(gioco.events.length < 100) {
            gioco.events.push({ type: "click", x: ev.clientX - rect.left, y: ev.clientY - rect.top });
        }
    });

    document.getElementsByTagName("body")[0].appendChild(cell);
    document.getElementsByTagName("body")[0].style.backgroundColor = "#dddddd";
};

// gioco.update = function () {
//     gioco.ctx.restore();
//     gioco.ctx.save();
// };

gioco.fill = function (c) {
    gioco.drawRect(0,0, gioco.canvas.width,gioco.canvas.height, c);
};

gioco.drawRect = function (x,y,w,h,c) {
    gioco.ctx.fillStyle = c;
    gioco.ctx.fillRect(x,y,w,h);
};

gioco.drawLine = function (x1,y1,x2,y2,c,s) {
    gioco.ctx.strokeStyle = c;
    if(typeof s !== "undefined") gioco.ctx.lineWidth = s;
    gioco.ctx.beginPath();
    gioco.ctx.moveTo(x1,y1);
    gioco.ctx.lineTo(x2,y2);
    gioco.ctx.stroke();
};

gioco.drawCircle = function (x,y,r,c) {
    gioco.ctx.fillStyle = c;
    gioco.ctx.beginPath();
    gioco.ctx.arc(x, y, r, 0, 2 * Math.PI);
    gioco.ctx.fill();
};

gioco.drawText = function (x,y,s,t,c) {
    gioco.ctx.fillStyle = c;
    gioco.ctx.font = "" + s + "px sans-serif";
    gioco.ctx.textAlign = "center";
    gioco.ctx.fillText(t,x,y+s/2);
};

gioco.getEvents = function () {
    var e = gioco.events;
    gioco.events = [];
    return e;
}
