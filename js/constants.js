// Generated by CoffeeScript 1.3.3
(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  define(['perlin'], function(PerlinNoise) {
    var block_type, matrix_sub_area, num_creatures, perlin_size, scenes, world, x, y, _i, _ref;
    num_creatures = 10;
    scenes = 2;
    perlin_size = 5;
    matrix_sub_area = function(matrix, x, y, width, height) {
      var row, _i, _len, _ref, _results;
      _ref = matrix.slice(y, (y + height) + 1 || 9e9);
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        row = _ref[_i];
        _results.push(row.slice(x, (x + width) + 1 || 9e9));
      }
      return _results;
    };
    block_type = function(height) {
      if (height <= .35) {
        return 2;
      }
      if ((.35 < height && height < .6)) {
        return 1;
      }
      return 3;
    };
    window.load_scene = function() {
      var cell, row, x, y, _i, _j, _len, _len1, _ref;
      window.scene = matrix_sub_area(world, current_scene.x * width, current_scene.y * height, width, height);
      _ref = window.scene;
      for (y = _i = 0, _len = _ref.length; _i < _len; y = ++_i) {
        row = _ref[y];
        for (x = _j = 0, _len1 = row.length; _j < _len1; x = ++_j) {
          cell = row[x];
          if (__indexOf.call(window.solid_tiles, cell) < 0) {
            window.empty_tiles.push({
              x: x,
              y: y
            });
          }
        }
      }
      return window.creatures = (function() {
        var _k, _results;
        _results = [];
        for (x = _k = 1; 1 <= num_creatures ? _k <= num_creatures : _k >= num_creatures; x = 1 <= num_creatures ? ++_k : --_k) {
          _results.push(new window.Creature);
        }
        return _results;
      })();
    };
    window.width = 30;
    window.height = 20;
    window.creatures = [];
    window.current_scene = {
      x: 0,
      y: 0
    };
    window.world_width = width * scenes;
    window.world_height = height * scenes;
    window.tile_size = 30;
    window.screen_width = width * tile_size;
    window.screen_height = height * tile_size;
    window.ctx = null;
    window.solid_tiles = [2, 3];
    window.scene = [];
    window.empty_tiles = [];
    world = (function() {
      var _i, _ref, _results;
      _results = [];
      for (y = _i = 0, _ref = world_height - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; y = 0 <= _ref ? ++_i : --_i) {
        _results.push((function() {
          var _j, _ref1, _results1;
          _results1 = [];
          for (x = _j = 0, _ref1 = world_width - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; x = 0 <= _ref1 ? ++_j : --_j) {
            _results1.push(block_type(PerlinNoise(perlin_size * x / world_width, perlin_size * y / world_height, .8)));
          }
          return _results1;
        })());
      }
      return _results;
    })();
    world[world_height - 1] = world[0] = (function() {
      var _i, _ref, _results;
      _results = [];
      for (x = _i = 0, _ref = world_width - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; x = 0 <= _ref ? ++_i : --_i) {
        _results.push(3);
      }
      return _results;
    })();
    for (x = _i = 0, _ref = world_height - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; x = 0 <= _ref ? ++_i : --_i) {
      world[x][world_width - 1] = world[x][0] = 3;
    }
    return window.world = world;
  });

}).call(this);
