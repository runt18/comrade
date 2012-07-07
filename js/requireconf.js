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
        'perlin': 'vendor/perlin'
    },

    shim: {
        'keymaster': {
            exports: 'key'
        }
        // 'backbone': {
        //     deps: ['underscore', 'jquery'],
        //     exports: 'Backbone'
        // },

        // 'layoutmanager': ['jquery', 'underscore', 'backbone'],
    }
});
