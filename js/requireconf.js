require.config({
    baseUrl: 'js',

    paths: {
        'jquery': 'vendor/jquery-1.7.2.min',

        'entity': 'entity',
        'npc': 'npc',

        'player': 'player',
        'creature': 'creature',
        'lumberjack': 'lumberjack',

        'game': 'game',
        'scene': 'scene',
        'renderer': 'renderer',

        'plugins': 'plugins',
        'keymaster': 'vendor/keymaster',
        'underscore': 'vendor/underscore',
        'perlin': 'vendor/perlin',
        'stats': 'vendor/stats'
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
