function UI(model, camera, canvas) {
    this.model  = model;
    this.camera = camera;
    this.canvas = canvas;
    this.width  = 1000;
    this.height = 1000;

    this.startTime = new Date().getTime();
    this.speedup   = 600;
    this.dt        = 1;

    this.model.runFirstPhysicsStep(this.dt);
    var t = this;
    window.setInterval(function () { t.refresh() }, 50);

    document.getElementsByTagName("body")[0].addEventListener("keyup", function (ev) {
        switch(String.fromCharCode(ev.which)) {
            case "P":
                if(t.pauseTime) {
                    t.unpause();
                } else {
                    t.pause();
                }
                break;
        }
    });
}

UI.prototype.pause = function () {
    this.pauseTime = new Date().getTime();
};

UI.prototype.unpause = function () {
    this.startTime += new Date().getTime() - this.pauseTime;
    this.pauseTime = 0;
};

UI.prototype.refresh = function () {
    if(this.pauseTime) return;
    this.model.runPhysicsTo((new Date().getTime() - this.startTime) * this.speedup / 1000, this.dt);
    this.draw();
};

UI.prototype.toPixelCoordinates = function (pos) {
    pos = this.camera.toDisplayCoordinates(pos);
    return [(pos[0] + 0.5) * this.width, (0.5 - pos[1]) * this.height];
}

UI.prototype.draw = function () {
    this.canvas.fillStyle   = "white";
    this.canvas.strokeStyle = "black";

    this.canvas.clearRect(0,0, this.width, this.height);

    for(name in this.model.bodies) {
        var body = this.model.bodies[name];
        var pos  = this.toPixelCoordinates(body["pos"]);
        this.canvas.beginPath();
        this.canvas.arc(pos[0], pos[1], 0.5 * Math.log(body["mass"]), 0, 2 * Math.PI, false);
        this.canvas.fillStyle = body["color"];
        this.canvas.fill();

        this.canvas.beginPath();

        for(var i = 0; i < body["hist"].length; i++) {
            var oldPos = this.toPixelCoordinates(body["hist"][i]);
            if(i == 0) {
                this.canvas.moveTo(oldPos[0], oldPos[1]);
            } else {
                this.canvas.lineTo(oldPos[0], oldPos[1]);
            }
        }
        this.canvas.lineTo(pos[0], pos[1]);
        this.canvas.lineWidth   = 5;
        this.canvas.strokeStyle = "gray";
        this.canvas.stroke();
    }
};

UI.prototype.run = function () {
    this.draw();
};
