function Cont (t, fun) {
    var cb0  = fun.bind(t);
    var cb   = cb0;
    var wait = function (k) {
        cb = function (w, a, x) { return k.bind(t)(x); };
    };
    var abort = function () {
        cb = cb0;
    };
    return function (x) { return cb(wait, abort, x); };
}
