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
