require.config({
    baseUrl: 'js',
    
    paths: {
        'jquery': 'vendor/jquery-1.7.2.min',

        'entity': 'entity',
        'player': 'player',
        'creature': 'creature',
        'game': 'game',

        'plugins': 'plugins',
        'keymaster': 'vendor/keymaster',
        'underscore': 'vendor/underscore',
        'perlin': 'vendor/perlin'
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
