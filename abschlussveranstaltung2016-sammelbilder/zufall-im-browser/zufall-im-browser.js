function wrap(code, repetitions) {
    if(code.substring(0, "#zufall\n".length) !== "#zufall\n")
        return code;

    addendum = "";

    var re   = /(\w+)\s*=/g;
    var match;
    while(match = re.exec(code)) {
        var name = match[1];
        if(name === "augenzahl") continue;
        addendum += "\n\
try:\n\
    if '" + name + "' in __variables:\n\
        __variables['" + name + "'] = __variables['" + name + "'] + " + name + "\n\
    else:\n\
        __variables['" + name + "'] = " + name + "\n\
except Exception:\n\
    pass"
    }

    code += addendum;

    code = code.replace(/\n/g, "\n ");
    code = code.replace(/^#zufall/, "def run(__variables):");
    code = code + "\n\
import random\n\
__number_of_rolls = 0\n\
augenzahl = 0\n\
def roll():\n\
    global __number_of_rolls\n\
    global augenzahl\n\
    __number_of_rolls = __number_of_rolls + 1\n\
    augenzahl = random.randint(1,6)\n\
    return augenzahl\n\
N = " + repetitions + "\n\
vars = {}\n\
for i in range(N):\n\
    __number_of_rolls = 0\n\
    localVars = {}\n\
    run(localVars)\n\
    localVars['AnzahlWuerfe'] = __number_of_rolls\n\
    for v in localVars:\n\
        if not v in vars: vars[v] = {}\n\
        if not localVars[v] in vars[v]: vars[v][localVars[v]] = 0\n\
        vars[v][localVars[v]] = vars[v][localVars[v]] + 1\n\
print(vars)\n\
for k in vars:\n\
    print('<script type=\\'text/javascript\\'>histogram(\\'' + k + '\\', ' + str(vars[k]) + ');</script>')\n\
"
    alert(code);

    return code;
}

function run() { 
    var prog = wrap(document.getElementById("code").value, document.getElementById("repetitions").value);
    Sk.configure({
        output: function(text) {
            document.getElementById("output").innerHTML += text;
        },
        read: function(x) {
            if(Sk.builtinFiles === undefined || Sk.builtinFiles["files"][x] === undefined)
                throw "File not found: '" + x + "'";
            return Sk.builtinFiles["files"][x];
        }
    });
    var myPromise = Sk.misceval.asyncToPromise(function() {
        return Sk.importMainWithBody("<stdin>", false, prog, true);
    });
    myPromise.then(function(mod) {
       console.log('success');
    }, function(err) {
       console.log(err.toString());
    });
}

function histogram(name, data) {
    alert(data);
    var bins = [];
    for(var k in data) {
        bins.push({ x: k, y: data[k] });
    }

    var margin = {top: 10, right: 20, bottom: 20, left: 60},
        width = 960 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

    var svg = d3.select("body").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var x = d3.scale.linear()
        .range([0, width]);

    var y = d3.scale.linear()
        .range([height, 0]);

    // Set the scale domains.
    x.domain([0, d3.max(bins.map(function(d) { return d.x; }))]).nice();
    y.domain([0, d3.max(bins.map(function(d) { return d.y; }))]).nice();

    // Add the bins.
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
        .call(d3.svg.axis()
        .scale(x)
        .orient("bottom"));

    svg.append("g")
        .attr("class", "y axis")
        .call(d3.svg.axis()
        .scale(y)
        .orient("left"));
}
