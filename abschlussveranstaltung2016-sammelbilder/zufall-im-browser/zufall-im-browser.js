var editor;

function wrap(code, repetitions) {
    if(code.substring(0, "#zufall\n".length) !== "#zufall\n")
        return code;

    addendum = "";

    var re   = /(\w+)\s*=[^=]/g;
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
__numberOfRolls = 0\n\
__rollsSeen = {}\n\
__maximalNumberOfRolls = 10000\n\
augenzahl = 0\n\
geseheneAugenzahlen = 0\n\
def roll(sides=6):\n\
    global __numberOfRolls\n\
    global augenzahl\n\
    global geseheneAugenzahlen\n\
    __numberOfRolls = __numberOfRolls + 1\n\
    if __numberOfRolls > __maximalNumberOfRolls:\n\
        raise Exception(\"Too many rolls.\\n\")\n\
    augenzahl = random.randint(1,sides)\n\
    __rollsSeen[augenzahl] = True\n\
    geseheneAugenzahlen = len(__rollsSeen)\n\
    return augenzahl\n\
N = " + repetitions + "\n\
vars = {}\n\
print(\"__JS:clearOutputs()\")\n\
for i in range(N):\n\
    __numberOfRolls = 0\n\
    __rollsSeen = {}\n\
    augenzahl = 0\n\
    geseheneAugenzahlen = 0\n\
    localVars = {}\n\
    run(localVars)\n\
    localVars['numberOfDiceRolls'] = __numberOfRolls\n\
    for v in localVars:\n\
        if not v in vars: vars[v] = {}\n\
        if not localVars[v] in vars[v]: vars[v][localVars[v]] = 0\n\
        vars[v][localVars[v]] = vars[v][localVars[v]] + 1\n\
for k in sorted(vars):\n\
    if len(vars[k]) > 1:\n\
        data = [ { 'x': i, 'y': vars[k][i] } for i in vars[k] ]\n\
        print(\"__JS:histogram('\" + k + \"', \" + str(data) + \")\")\n\
"

    return code;
}

function clearOutputs() {
    d3.selectAll("#plots > *").remove();
    document.getElementById("output").innerHTML = "";
}

function run() { 
    var prog = wrap(editor.getValue(), document.getElementById("repetitions").value);
    var skipNewline = false;
    Sk.configure({
        output: function(text) {
            if(text.substring(0, "__JS:".length) == "__JS:") {
                eval(text.substring("__JS:".length));
                skipNewline = true;
            } else {
                if(skipNewline && text === "\n") {
                    skipNewline = false;
                } else {
                    document.getElementById("output").innerHTML += text;
                }
            }
        },
        read: function(x) {
            if(Sk.builtinFiles === undefined || Sk.builtinFiles["files"][x] === undefined)
                throw "File not found: '" + x + "'";
            return Sk.builtinFiles["files"][x];
        }
    });

    window.location.hash = "#" + encodeURI(editor.getValue());
    document.getElementById("spinner").style.visibility = "visible";

    window.setTimeout(function () {
        Sk.misceval.asyncToPromise(function() {
            return Sk.importMainWithBody("<stdin>", false, prog, true);
        })
        .then(function(mod) {
            document.getElementById("spinner").style.visibility = "hidden";
        }, function(err) {
            document.getElementById("spinner").style.visibility = "hidden";
           alert(err.toString());
        });
    }, 50);
}

function histogram(name, bins) {
    var average = 0;
    var maximum = 0;
    var numEntries = 0;
    for(var k in bins) {
        average += bins[k].x * bins[k].y;
        numEntries += bins[k].y;
        if(bins[k].x > maximum && bins[k].y > 0) maximum = bins[k].x;
    }
    average /= numEntries;

    var margin = {top: 10, right: 20, bottom: 20, left: 60},
        width  = 500 - margin.left - margin.right,
        height = 300 - margin.top - margin.bottom;

    var svg = d3.select("#plots").append("svg")
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
        .text("Durchschnitt: " + average.toFixed(2));
    svg.append("text")
        .attr("x", width)
        .attr("y", "2.4em")
        .attr("text-anchor", "end")
        .text("Maximum: " + maximum);

    var x = d3.scale.linear().range([0, width]);

    var y = d3.scale.linear().range([height, 0]);

    var smartMin = d3.min(bins.map(function(d) { return d.x; }));
    if(smartMin > 0) smartMin = 0;
    x.domain([smartMin, d3.max(bins.map(function(d) { return d.x; }))]).nice();
    y.domain([0, d3.max(bins.map(function(d) { return d.y; }))]).nice();

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

$(window).load(function(){
    if(window.location.hash) {
        editor.setValue(decodeURI(window.location.hash).substring(1));
    } else {
        loadExample('sum');
    }

    // Source: http://stackoverflow.com/a/32883919/4533618
    var i = 0;
    var dragging = false;
    $('#dragbar').mousedown(function(e) {
        e.preventDefault();

        dragging = true;
        var main = $('#output-pane');
        var ghostbar = $('<div>', {
            id: 'ghostbar',
            css: {
                height: main.outerHeight(),
                top: main.offset().top,
                left: main.offset().left - 3
            }
        }).appendTo('body');

        $(document).mousemove(function(e) {
            ghostbar.css("left", e.pageX);
        });
    });

    $(document).mouseup(function(e) {
        if(dragging) {
            var percentage = ((e.pageX + 3) / window.innerWidth) * 100;
            var mainPercentage = 100-percentage;

            $('#editor-pane').css("width",percentage + "%");
            $('#output-pane').css("width",mainPercentage + "%");
            $('#ghostbar').remove();
            $(document).unbind('mousemove');
            dragging = false;
        }
    });
});

function loadExample(name) {
    var examples = {
        sum: "\
#zufall\n\
\n\
x = roll()\n\
y = roll()\n\
summe = x + y",
        coupon: "\
#zufall\n\
\n\
# Bis wir etwas anderes sagen, ...\n\
while True:\n\
    # ... würfeln und würfeln wir immer wieder.\n\
    roll()\n\
\n\
    # Haben wir insgesamt sechs verschiedene Augenzahlen gesehen?\n\
    if geseheneAugenzahlen == 6:\n\
        # Ja! Dann hören wir auf.\n\
        break",
        till6: "\
#zufall\n\
\n\
# Bis wir etwas anderes sagen, ...\n\
while True:\n\
    # ... würfeln und würfeln wir immer wieder.\n\
    roll()\n\
\n\
    # Ist die Augenzahl eine Sechs?\n\
    if augenzahl == 6:\n\
        # Ja! Dann hören wir auf.\n\
        break",
        triplets: "\
#zufall\n\
\n\
letzter, vorletzter, vorvorletzter = None, None, None\n\
\n\
while True:\n\
    vorvorletzter = vorletzter\n\
    vorletzter    = letzter\n\
    letzter       = roll()\n\
\n\
    if letzter == vorletzter and vorletzter == vorvorletzter:\n\
        break",
        "sum#": "\
#zufall\n\
\n\
x = roll()\n\
y = roll()\n\
summe = x + y",
        "coupon#": "\
#zufall\n\
\n\
while True:\n\
    roll()\n\
\n\
    if geseheneAugenzahlen == 6:\n\
        break",
        "till6#": "\
#zufall\n\
\n\
while True:\n\
    roll()\n\
\n\
    if augenzahl == 6:\n\
        break",
        "triplets#": "\
#zufall\n\
\n\
letzter, vorletzter, vorvorletzter = None, None, None\n\
\n\
while True:\n\
    vorvorletzter = vorletzter\n\
    vorletzter    = letzter\n\
    letzter       = roll()\n\
\n\
    if letzter == vorletzter and vorletzter == vorvorletzter:\n\
        break"
    }

    editor.setValue(examples[name]);
}
