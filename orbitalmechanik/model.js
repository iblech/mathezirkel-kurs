function Model() {
    var rotate = function (phi, pos) {
        return [ Math.cos(phi)*pos[0] - Math.sin(phi)*pos[1], Math.sin(phi)*pos[0] + Math.cos(phi)*pos[1] ];
    };

    this.G      = 6.67408e-11;
    this.bodies = {
        "earth": {
            "mass":  5.927e24,
            "pos":   [0.0, 0.0],
            "vel":   [0.0, 0.0],
            "color": "blue",
        },
        "iss": {
            "mass":  0,  // 419455,
            "pos":   [0.0, 409000 + 6370000],
            "vel":   [-7660.0, 0.0],
            "color": "red",
        },
        "iss2": {
            "mass":  0,  // 419455,
            "pos":   rotate(Math.PI / 5, [0.0, 409000 + 6370000]),
            "vel":   rotate(Math.PI / 5, [-7660.0, 0.0]),
            "color": "darkred",
        },
    };

    this.time    = 0;
    this.stepNum = 0;

    for(name in this.bodies) {
        this.bodies[name]["hist"] = [];
    }
}

Model.prototype.calcAcceleration = function (name) {
    acc0 = 0.0;
    acc1 = 0.0;
    for(name_ in this.bodies) {
        if(name == name_ || this.bodies[name_]["mass"] == 0) continue;
        r0 = this.bodies[name_]["pos"][0] - this.bodies[name]["pos"][0];
        r1 = this.bodies[name_]["pos"][1] - this.bodies[name]["pos"][1];
        mu = this.G * this.bodies[name_]["mass"] / Math.pow(Math.sqrt(r0*r0 + r1*r1), 3);
        acc0 = acc0 + mu * r0;
        acc1 = acc1 + mu * r1;
    }
    return [acc0,acc1];
};

Model.prototype.runFirstPhysicsStep = function (dt) {
    for(name in this.bodies) {
        if(name == "earth") continue;
        var acc = this.calcAcceleration(name);
        this.bodies[name]["vel"][0] += dt * acc[0] / 2;
        this.bodies[name]["vel"][1] += dt * acc[1] / 2;
    }
};

Model.prototype.runPhysicsStep = function (dt) {
    for(name in this.bodies) {
        if(name == "earth") continue;
        this.bodies[name]["pos"][0] += dt * this.bodies[name]["vel"][0];
        this.bodies[name]["pos"][1] += dt * this.bodies[name]["vel"][1];
    }

    var accs = {};
    for(name in this.bodies) {
        if(name == "earth") continue;
        accs[name] = this.calcAcceleration(name);
    }

    for(name in this.bodies) {
        if(name == "earth") continue;
        this.bodies[name]["vel"][0] += dt * accs[name][0];
        this.bodies[name]["vel"][1] += dt * accs[name][1];
    }

    this.stepNum++;
    if(this.stepNum % 10 == 0) {
        this.stepNum = 0;
        for(name in this.bodies) {
            if(name == "earth") continue;
            this.bodies[name]["hist"].push([this.bodies[name]["pos"][0], this.bodies[name]["pos"][1]]);
            if(this.bodies[name]["hist"].length > 2000) this.bodies[name]["hist"].shift();
        }
    }
};

Model.prototype.runPhysicsTo = function (userTime, dt, stoppingCondition) {
    while(this.time < userTime && (!stoppingCondition || !stoppingCondition())) {
        this.runPhysicsStep(dt);
        this.time += dt;
    }
};

Model.prototype.applyThrust = function (body, vel) {
    this.bodies[body]["vel"][0] += vel[0];
    this.bodies[body]["vel"][1] += vel[1];
}
