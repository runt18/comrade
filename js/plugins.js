// usage: log('inside coolFunc', this, arguments);
// paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/

window.log = function f() {
    log.history = log.history || [];
    log.history.push(arguments);
    if (this.console) {
        var args = arguments;
        var newarr;

        try {
            args.callee = f.caller;
        } catch(e) {

        }

        newarr = [].slice.call(args);

        if (typeof console.log === 'object') {
            log.apply.call(console.log, console, newarr);
        } else {
            console.log.apply(console, newarr);
        }
    }
};

// make it safe to use console.log always

(function(a) {
    function b() {}
    var c = "assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn";
    var d;
    for (c = c.split(","); !!(d = c.pop());) {
        a[d] = a[d] || b;
    }
})(function() {
    try {
        console.log();
        return window.console;
    } catch(a) {
        return (window.console = {});
    }
}());

(function() {
    // RAF polyfill
    var lastTime = 0;
    var vendors = ['ms', 'moz', 'webkit', 'o'];
    for(var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
        window.requestAnimationFrame = window[vendors[x]+'RequestAnimationFrame'];
        window.cancelAnimationFrame =
          window[vendors[x]+'CancelAnimationFrame'] || window[vendors[x]+'CancelRequestAnimationFrame'];
    }

    if (!window.requestAnimationFrame){
        window.requestAnimationFrame = function(callback, element) {
            var currTime = new Date().getTime();
            var timeToCall = Math.max(0, 16 - (currTime - lastTime));
            var id = window.setTimeout(function() { callback(currTime + timeToCall); },
              timeToCall);
            lastTime = currTime + timeToCall;
            return id;
        };
    }

    if (!window.cancelAnimationFrame){
        window.cancelAnimationFrame = function(id) {
            clearTimeout(id);
        };
    }

    require.config({
        baseUrl: 'js',

        paths: {
            'jquery': 'vendor/jquery/jquery',
            'keymaster': 'vendor/keymaster/keymaster',
            'underscore': 'vendor/underscore/underscore',
            'pathfinding': 'vendor/PathFinding.js/lib/pathfinding-browser',
            'noise': 'vendor/noisejs/index',
            'stats': 'vendor/stats.js/src/Stats'
        },

        shim: {
            keymaster: {
                exports: 'key'
            },
            underscore: {
                exports: '_'
            },
            stats: {
                exports: 'Stats'
            }
        }
    });
}());

