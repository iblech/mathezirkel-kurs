function pin(pinningTable, name, type, direction, value) {
    var f = direction === "up"
        ? function(x,y) { return x < y ? y : x }
        : function(x,y) { return x < y ? x : y };

    if(!(name in pinningTable)) pinningTable[name] = {};

    if(type in pinningTable[name]) {
        value = f(pinningTable[name][type], value);
    }

    return pinningTable[name][type] = value;
}

function histogram(domID, pinningTable, name, bins) {
    var average = 0;
    var maximum = 0;
    for(var i = 0; i < bins.length; i++) {
        average += bins[i].x * bins[i].y;
        if(bins[i].x > maximum && bins[i].y > 0) maximum = bins[i].x;
    }

    var margin = {top: 10, right: 20, bottom: 20, left: 60},
        width  = 500 - margin.left - margin.right,
        height = 300 - margin.top - margin.bottom;

    var svg = d3.select("#" + domID).append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    svg.append("text")
        .attr("x", width)
        .attr("y", 0)
        .attr("text-anchor", "end")
        .attr("font-weight", "bold")
        .text(name);
    svg.append("text")
        .attr("x", width)
        .attr("y", "1.2em")
        .attr("text-anchor", "end")
        .text("average: " + average.toFixed(2));
    svg.append("text")
        .attr("x", width)
        .attr("y", "2.4em")
        .attr("text-anchor", "end")
        .text("maximum: " + maximum);

    var x = d3.scale.linear().range([0, width]);

    var y = d3.scale.linear().range([height, 0]);

    var smartXMax = pin(pinningTable, name, "x-max", "up", d3.max(bins.map(function(d) { return d.x; })));
    var smartYMax = pin(pinningTable, name, "y-max", "up", d3.max(bins.map(function(d) { return d.y; })));
    var smartXMin = d3.min(bins.map(function(d) { return d.x; }));
    if(smartXMin > 0) smartXMin = 0;
    smartXMin = pin(pinningTable, name, "x-min", "down", smartXMin);
    x.domain([smartXMin, smartXMax]).nice();
    y.domain([0, smartYMax]);
    // no nice() for the y domain; it's good for numbers of occurences, not so
    // much for relative frequencies

    svg.selectAll(".bin")
        .data(bins)
        .enter().append("line")
        .attr("class", "bin")
        .attr("x1", function(d) { return x(d.x); })
        .attr("x2", function(d) { return x(d.x); })
        .attr("y1", height)
        .attr("y2", function(d) { return y(d.y); });

    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(d3.svg.axis().scale(x).orient("bottom"));

    svg.append("g")
        .attr("class", "y axis")
        .call(d3.svg.axis().scale(y).orient("left"));
}
