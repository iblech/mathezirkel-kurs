function Camera() {
    this.frame = "fixed";
    this.width  = 1000;
    this.height = 1000;
    this.offset = [0.0, 0.0];
    this.scale  = 1/30000000;
}

Camera.prototype.toDisplayCoordinates = function (pos) {
    return [this.scale * (this.offset[0] + pos[0]), this.scale * (this.offset[1] + pos[1])];
};
