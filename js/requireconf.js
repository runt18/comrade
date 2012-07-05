require.config({
    baseUrl: 'js',
    
    paths: {
        'jquery': 'vendor/jquery-1.7.2.min',

        'entitiy': 'entitiy',

        'plugins': 'plugins',
    },

    shim: {
        // 'underscore': {
        //     exports: '_'
        // },

        // 'backbone': {
        //     deps: ['underscore', 'jquery'],
        //     exports: 'Backbone'
        // },

        // 'layoutmanager': ['jquery', 'underscore', 'backbone'],

        // 'jquery-ui': ['jquery'],
        // 'jquery-ui-timepicker': ['jquery-ui', 'jquery']

    }
});
