var examples = {};
var editor;
var pinningTable = {};

function clearConsole() {
    document.getElementById("output").innerHTML = "";
}

function clearPlots() {
    d3.selectAll("#plots > *").remove();
}

function loadCode() {
    if(window.location.hash) {
        editor.setValue(decodeURI(window.location.hash).substring(1));
    } else {
        loadExample("01-sum");
    }
}

function loadExample(name) {
    // Hack to hide the menu after click
    document.getElementById("examples-menu").style.display = "none";
    window.setTimeout(function () {
        document.getElementById("examples-menu").style.display = "block";
    }, 500);

    editor.setValue(examples[name].code);
    pinningTable = {};
}

function setupExamplesMenu() {
    var list  = document.getElementById("examples-menu");
    var names = Object.keys(examples).sort();

    for(var i = 0; i < names.length; i++) {
        var elem = document.createElement("li");
        elem.className = "button";
        elem.onclick = (function (i) { return function() { loadExample(names[i]); }; })(i);
        elem.appendChild(document.createTextNode(examples[names[i]].description));

        list.appendChild(elem);
    }
}

function setupEditor() {
    editor = CodeMirror.fromTextArea(document.getElementById("code"), {
        lineNumbers: true,
        mode: "python",
        indentUnit: 4,
        scrollbarStyle: "simple",
        matchBrackets: true,
    });
}

// Source: http://stackoverflow.com/a/32883919/4533618
function setupDragbar() {
    var dragging = false;
    $("#dragbar").mousedown(function(e) {
        e.preventDefault();

        dragging = true;
        var main = $("#output-pane");
        var ghostbar = $("<div>", {
            id: "ghostbar",
            css: {
                height: main.outerHeight(),
                top: main.offset().top,
                left: main.offset().left - 3
            }
        }).appendTo("body");

        $(document).mousemove(function(e) {
            ghostbar.css("left", e.pageX);
        });
    });

    $(document).mouseup(function(e) {
        if(dragging) {
            var percentage = ((e.pageX + 9) / window.innerWidth) * 100;
            var mainPercentage = 100 - percentage;

            $("#editor-pane").css("width", percentage + "%");
            $("#output-pane").css("width", mainPercentage + "%");
            $("#ghostbar").remove();
            $(document).unbind("mousemove");
            dragging = false;
        }
    });
}

function setupButtons() {
    document.getElementById("run-button").onclick = function() {
        run(
            document.getElementById("output"),
            document.getElementById("spinner"),
            editor.getValue(),
            +document.getElementById("repetitions").value
        );
    };

    document.getElementById("repetitions").onchange = function() {
        pinningTable = {};
        return true;
    };

    document.getElementById("help-button").onclick = function() {
        document.getElementById("help").style.display =
            document.getElementById("help").style.display === "block"
                ? "none"
                : "block";
    }

    document.getElementById("close-button").onclick = function() {
        document.getElementById("help").style.display = "none";
    };
}

function setup() {
    setupEditor();
    loadCode();
    setupButtons();
    setupExamplesMenu();
    setupDragbar();
}
