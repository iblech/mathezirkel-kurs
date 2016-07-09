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
        print(\"__JS:histogram('plots', pinningTable, '\" + k + \"', \" + str(data) + \")\")\n\
"

    return code;
}

function run(output, spinner, code, repetitions) { 
    // Pressing <Tab> inserts a hard tab character.
    // We expand these to four spaces (the same amount as it looks like),
    // to be compatible with identation keyed in by <Space>.
    var prog = wrap(code.replace(/\t/g, "    "), repetitions);
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
                    output.innerText += text;
                }
            }
        },
        read: function(x) {
            if(Sk.builtinFiles === undefined || Sk.builtinFiles["files"][x] === undefined)
                throw "File not found: '" + x + "'";
            return Sk.builtinFiles["files"][x];
        }
    });

    window.location.hash = "#" + encodeURI(code);
    spinner.style.visibility = "visible";

    window.setTimeout(function () {
        Sk.misceval.asyncToPromise(function() {
            return Sk.importMainWithBody("<stdin>", false, prog, true);
        })
        .then(function(mod) {
            spinner.style.visibility = "hidden";
        }, function(err) {
            spinner.style.visibility = "hidden";
	    alert(err.toString());
        });
    }, 50);
}
