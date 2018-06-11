function wrap(code, repetitions) {
    if(code.substring(0, "#random\n".length) !== "#random\n")
        return code;

    addendum = "";

    var names = {};
    var re   = /(\w+)\s*=[^=]/g;
    var match;
    while(match = re.exec(code)) {
        var name = match[1];
        names[name] = 1;
    }
    names = Object.keys(names);

    for(var i = 0; i < names.length; i++) {
        addendum += "\n\
try:\n\
    if isinstance(" + names[i] + ", int) or isinstance(" + names[i] + ", float):\n\
        if '" + names[i] + "' in __variables:\n\
            __variables['" + names[i] + "'] = __variables['" + names[i] + "'] + " + names[i] + "\n\
        else:\n\
            __variables['" + names[i] + "'] = " + names[i] + "\n\
except Exception:\n\
    pass"
    }

    code += addendum;

    code = code.replace(/\n/g, "\n ");
    code = code.replace(/^#random/, "def __runSimulation(__variables):");
    code = code + "\n\
import random\n\
import js as __js\n\
__numberOfRolls = 0\n\
__maximalNumberOfRolls = 10000\n\
def roll(sides=6):\n\
    global __numberOfRolls\n\
    __numberOfRolls = __numberOfRolls + 1\n\
    if __numberOfRolls > __maximalNumberOfRolls:\n\
        raise Exception(\"Too many rolls.\\n\")\n\
    return random.randint(1,sides)\n\
N = " + repetitions + "\n\
vars = {}\n\
__js.evaljs(\"clearConsole()\")\n\
for i in range(N):\n\
    __numberOfRolls = 0\n\
    localVars = {}\n\
    __runSimulation(localVars)\n\
    localVars['numberOfDiceRolls'] = __numberOfRolls\n\
    for v in localVars:\n\
        if not v in vars: vars[v] = {}\n\
        if not localVars[v] in vars[v]: vars[v][localVars[v]] = 0\n\
        vars[v][localVars[v]] = vars[v][localVars[v]] + 1\n\
__js.evaljs('clearPlots()')\n\
for k in sorted(vars):\n\
    if len(vars[k]) > 1:\n\
        data = [ { 'x': i, 'y': vars[k][i] } for i in vars[k] ]\n\
        __js.evaljs(\"histogram('plots', pinningTable, '\" + k + \"', \" + str(data) + \")\")\n\
"

    return code;
}

function run(output, spinner, code, repetitions) { 
    // Pressing <Tab> inserts a hard tab character.
    // We expand these to four spaces (the same amount as it looks like),
    // to be compatible with indentation keyed in by <Space>.
    var prog = wrap(code.replace(/\t/g, "    "), repetitions);
    Sk.configure({
        output: function(text) {
            output.innerHTML += text;
        },
        read: function(x) {
            if(x === "./js.js") {
                return '\
                    var $builtinmodule = function(name) { \
                        var mod = {}; \
                        mod.evaljs = new Sk.builtin.func(function (code) { eval(code.v); }); \
                        return mod; \
                    }; \
                ';
            }

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
