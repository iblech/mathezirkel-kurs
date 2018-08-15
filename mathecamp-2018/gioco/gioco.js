gioco = {};

gioco.init = function () {
    gioco.canvas = document.createElement("canvas");
    gioco.canvas.style.backgroundColor = "white";
    gioco.canvas.width  = 600;
    gioco.canvas.height = 300;

    gioco.ctx = gioco.canvas.getContext("2d");
    gioco.ctx.save();

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
        console.log(3);
        if(gioco.events.length < 100) {
            gioco.events.push({ type: "click", x: ev.clientX - rect.left, y: ev.clientY - rect.top });
        }
    });

    document.getElementsByTagName("body")[0].appendChild(cell);
    document.getElementsByTagName("body")[0].style.backgroundColor = "#dddddd";
};

gioco.update = function () {
    gioco.ctx.restore();
    gioco.ctx.save();
};

gioco.drawRect = function (x,y,w,h,c) {
    gioco.ctx.fillStyle = c;
    gioco.ctx.fillRect(x,y,w,h);
};

gioco.getEvents = function () {
    var e = gioco.events;
    gioco.events = [];
    return e;
}
