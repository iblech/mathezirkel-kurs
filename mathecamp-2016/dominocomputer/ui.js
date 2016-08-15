function hs2js (str) {
    return parseFloat(str);
}

function updateTime (time) {
    $("line").each(function (index) {
        beginTime   = hs2js(this.getAttribute("data-begin-time"));
        toppledTime = hs2js(this.getAttribute("data-toppled-time"));

        var x1 = hs2js(this.getAttribute("data-x1"));
        var y1 = hs2js(this.getAttribute("data-y1"));
        var x2 = hs2js(this.getAttribute("data-x2"));
        var y2 = hs2js(this.getAttribute("data-y2"));

        var theta = time < beginTime ? 0 : time >= toppledTime ? 1 : (time - beginTime) / (toppledTime - beginTime);

        var xmid = (1 - theta) * x1 + theta * x2;
        var ymid = (1 - theta) * y1 + theta * y2;

        if(this.getAttribute("data-part") == "a") {
            this.setAttribute("x1", x1);
            this.setAttribute("y1", y1);
            this.setAttribute("x2", xmid);
            this.setAttribute("y2", ymid);
            this.style.stroke = "red";
        } else if(this.getAttribute("data-part") == "b") {
            this.setAttribute("x1", xmid);
            this.setAttribute("y1", ymid);
            this.setAttribute("x2", x2);
            this.setAttribute("y2", y2);
            this.style.stroke = "black";
        }
    });
}
