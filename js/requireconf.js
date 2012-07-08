require.config({
    baseUrl: 'js',
    
    paths: {
        'jquery': 'vendor/jquery-1.7.2.min',

        'entity': 'entity',
        'player': 'player',
        'creature': 'creature',
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
        }
        // 'backbone': {
        //     deps: ['underscore', 'jquery'],
        //     exports: 'Backbone'
        // },

        // 'layoutmanager': ['jquery', 'underscore', 'backbone'],
    }
});
