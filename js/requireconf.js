require.config({
    baseUrl: 'js',

    paths: {
        'jquery': 'vendor/jquery/jquery',

        'entity': 'entity',
        'npc': 'npc',

        'player': 'player',
        'creature': 'creature',
        'lumberjack': 'lumberjack',

        'game': 'game',
        'scene': 'scene',
        'renderer': 'renderer',

        'plugins': 'plugins',
        'keymaster': 'vendor/keymaster/keymaster',

        'underscore': 'vendor/underscore/underscore',
        'pathfinding': 'vendor/PathFinding.js/lib/pathfinding-browser',
        'perlin': 'vendor/perlin',

        'stats': 'vendor/stats.js/src/Stats'
    },

    shim: {
        'keymaster': {
            exports: 'key'
        },

        'underscore': {
            exports: '_'
        },

        'stats': {
            exports: 'Stats'
        }

        // 'backbone': {
        //     deps: ['underscore', 'jquery'],
        //     exports: 'Backbone'
        // },

        // 'layoutmanager': ['jquery', 'underscore', 'backbone'],
    }
});
