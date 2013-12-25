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
        'perlin': 'vendor/perlin',
        'astar': 'vendor/astar',
        'graph': 'vendor/graph',

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
        },

        'astar': {
            exports: 'astar'
        },

        'graph': {
            exports: 'Graph'
        }
        // 'backbone': {
        //     deps: ['underscore', 'jquery'],
        //     exports: 'Backbone'
        // },

        // 'layoutmanager': ['jquery', 'underscore', 'backbone'],
    }
});
