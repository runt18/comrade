require.config({
    baseUrl: 'js',
    
    paths: {
        'jquery': 'vendor/jquery-1.7.2.min',

        'entity': 'entity',
        'constants': 'constants',

        'plugins': 'plugins',
        'keymaster': 'vendor/keymaster',
        'perlin': 'vendor/perlin'
    },

    shim: {
        'keymaster': {
            exports: 'key'
        },
        'perlin': {
            exports: 'PerlinNoise'
        }
        // 'backbone': {
        //     deps: ['underscore', 'jquery'],
        //     exports: 'Backbone'
        // },

        // 'layoutmanager': ['jquery', 'underscore', 'backbone'],
    }
});
