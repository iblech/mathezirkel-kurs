function UI(model, camera, canvas0, canvas1) {
    this.model   = model;
    this.camera  = camera;
    this.canvas0 = canvas0.getContext("2d");
    this.canvas1 = canvas1.getContext("2d");
    this.width   = 1000;
    this.height  = 1000;

    this.startTime = new Date().getTime();
    this.speedup   = 600;
    this.dt        = 1;

    this.selectedBody   = undefined;
    this.stopAfterAngle = undefined;

    this.model.runFirstPhysicsStep(this.dt);

    canvas0.setAttribute("width",  1000);
    canvas0.setAttribute("height", 1000);
    canvas1.setAttribute("width",  1000);
    canvas1.setAttribute("height", 1000);

    var t = this;

    document.getElementsByTagName("body")[0].addEventListener("keyup", function (ev) {
        switch(String.fromCharCode(ev.which)) {
            case "P":
                if(t.pauseTime) {
                    t.unpause();
                } else {
                    t.pause();
                }
                break;
            case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7":
                t.unpause();
                t.stopAfterAngle = (ev.which - 48) / 8 * 2*Math.PI;
                break;
        }
    });

    var k = Cont(this, this.handleMouse);
    canvas1.addEventListener("click",     k);
    canvas1.addEventListener("mousemove", k);
    document.getElementsByTagName("body")[0].addEventListener("keyup", k);

    window.setInterval(function () { t.refresh() }, 100);
}

UI.prototype.handleMouse = function (wait, abort, ev) {
    var body = this.bodyNearPixelCoordinates([ev.offsetX, ev.offsetY]);
    if(!body) {
        this.selectedBody = undefined;
        return;
    }
    if(this.selectedBody && this.selectedBody !== body) {
        var oldSelectedBody = this.selectedBody;
        this.selectedBody = undefined;
        this.drawJustBody(oldSelectedBody);
    }
    this.selectedBody = body;
    this.drawJustBody(body);
    if(ev.type !== "click") return;

    var bodyPos      = this.model.bodies[body]["pos"];
    var bodyPixelPos = this.toPixelCoordinates(bodyPos);

    var wasPaused = this.pauseTime;
    this.pause();

    wait(function (ev) {
        this.canvas1.clearRect(0,0, this.width, this.height);

        var mousePos = this.fromPixelCoordinates([ev.offsetX, ev.offsetY]);
        var delta    = [ mousePos[0] - bodyPos[0], mousePos[1] - bodyPos[1] ];
        var vel      = this.model.bodies[body]["vel"];

        if(ev.shiftKey) {  // tangent direction
            var gamma = (delta[0] * vel[0] + delta[1] * vel[1]) / (vel[0]*vel[0] + vel[1]*vel[1]);
            delta = [ gamma * vel[0], gamma * vel[1] ];
        } else if(ev.ctrlKey) {  // normal direction
            var gamma = (delta[0] * vel[0] + delta[1] * vel[1]) / (vel[0]*vel[0] + vel[1]*vel[1]);
            delta = [ delta[0] - gamma * vel[0], delta[1] - gamma * vel[1] ];
        }

        if(ev.altKey) {  // length quantization
            var len   = Math.sqrt(delta[0]*delta[0] + delta[1]*delta[1]);
            var gamma = Math.round(len / 3e6) * 3e6 / len;
            delta = [ gamma * delta[0], gamma * delta[1] ];
        }

        if(ev.which == 27) {
            if(! wasPaused) this.unpause();
            return abort();
        } else if(ev.type === "mousemove") {
            this.canvas1.beginPath();
            this.arrowFromTo(this.canvas1, [bodyPixelPos[0], bodyPixelPos[1]], this.toPixelCoordinates([bodyPos[0]+delta[0], bodyPos[1]+delta[1]]));
            this.canvas1.strokeStyle = "black";
            this.canvas1.lineWidth = 3;
            this.canvas1.stroke();
        } else if(ev.type === "click") {
            var scale = 1e-4;
            this.model.applyThrust(body, [scale * delta[0], scale * delta[1]]);
            this.unpause();
            return abort();
        }
    });
};

UI.prototype.arrowFromTo = function (canvas, src, dst) {
    var len   = 20;
    var angle = Math.atan2(dst[1] - src[1], dst[0] - src[0]);
    canvas.moveTo(src[0], src[1]);
    canvas.lineTo(dst[0], dst[1]);
    canvas.lineTo(dst[0] - len*Math.cos(angle-Math.PI/6), dst[1] - len*Math.sin(angle-Math.PI/6));
    canvas.moveTo(dst[0], dst[1]);
    canvas.lineTo(dst[0] - len*Math.cos(angle+Math.PI/6), dst[1] - len*Math.sin(angle+Math.PI/6));
};

UI.prototype.bodyNearPixelCoordinates = function (pos) {
    for(var name in this.model.bodies) {
        var bodyPos = this.toPixelCoordinates(this.model.bodies[name]["pos"]);
        if((bodyPos[0]-pos[0])*(bodyPos[0]-pos[0]) + (bodyPos[1]-pos[1])*(bodyPos[1]-pos[1]) <= 20*20) {
            return name;
        }
    }
    return undefined;
}

UI.prototype.pause = function () {
    if(this.pauseTime) return;
    this.pauseTime = new Date().getTime();
};

UI.prototype.unpause = function () {
    if(! this.pauseTime) return;
    this.startTime += new Date().getTime() - this.pauseTime;
    this.pauseTime = 0;
};

UI.prototype.refresh = function () {
    if(this.pauseTime) return;

    var stoppingCondition;
    if(!(typeof(this.stopAfterAngle) === "undefined")) {
        stoppingCondition = (function () {
            var pos   = this.model.bodies["iss"].pos;
            var angle = Math.atan2(pos[1], pos[0]);
            if(angle < 0) angle += 2*Math.PI;
            if(angle >= this.stopAfterAngle && angle < this.stopAfterAngle + 2*Math.PI/8) {
                this.pause();
                this.stopAfterAngle = undefined;
            }
        }).bind(this);
    }

    this.model.runPhysicsTo((new Date().getTime() - this.startTime) * this.speedup / 1000, this.dt, stoppingCondition);
    this.draw();
};

UI.prototype.toPixelCoordinates = function (pos) {
    pos = this.camera.toDisplayCoordinates(pos);
    return [(pos[0] + 0.5) * this.width, (0.5 - pos[1]) * this.height];
}

UI.prototype.fromPixelCoordinates = function (pos) {
    return this.camera.fromDisplayCoordinates([pos[0] / this.width - 0.5, -pos[1] / this.height + 0.5]);
}

UI.prototype.drawJustBody = function (body) {
    var pos = this.toPixelCoordinates(this.model.bodies[body]["pos"]);
    this.canvas0.beginPath();
    this.canvas0.arc(pos[0], pos[1], 0.5 * Math.log(this.model.bodies[body]["mass"] || 1e5), 0, 2 * Math.PI, false);
    this.canvas0.fillStyle = this.selectedBody === body ? "black" : this.model.bodies[body]["color"];
    this.canvas0.fill();
};

UI.prototype.draw = function () {
    this.canvas0.fillStyle   = "white";
    this.canvas0.strokeStyle = "black";

    this.canvas0.clearRect(0,0, this.width, this.height);

    for(name in this.model.bodies) {
        var body = this.model.bodies[name];
        var pos  = this.toPixelCoordinates(body["pos"]);
        this.drawJustBody(name);

        this.canvas0.beginPath();
        for(var i = 0; i < body["hist"].length; i++) {
            var oldPos = this.toPixelCoordinates(body["hist"][i]);
            if(i == 0) {
                this.canvas0.moveTo(oldPos[0], oldPos[1]);
            } else {
                this.canvas0.lineTo(oldPos[0], oldPos[1]);
            }
        }
        this.canvas0.lineTo(pos[0], pos[1]);
        this.canvas0.lineWidth   = 5;
        this.canvas0.strokeStyle = "gray";
        this.canvas0.stroke();
    }
};

UI.prototype.run = function () {
    this.draw();
};
