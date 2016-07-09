var examples = {};
var editor;
var pinningTable = {};

function clearOutputs() {
    d3.selectAll("#plots > *").remove();
    document.getElementById("output").innerHTML = "";
}

function loadCode() {
    if(window.location.hash) {
        editor.setValue(decodeURI(window.location.hash).substring(1));
    } else {
        loadExample('sum');
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

// Source: http://stackoverflow.com/a/32883919/4533618
function setupDragbar() {
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
}
