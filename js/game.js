// Generated by CoffeeScript 1.3.3
(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  define(['perlin'], function(PerlinNoise) {
    var Game;
    Game = (function() {

      function Game() {
        var scenes;
        this.num_creatures = 10;
        this.ui_height = 30;
        scenes = 2;
        this.perlin_size = 5;
        this.width = 30;
        this.height = 20;
        this.creatures = [];
        this.current_scene = {
          x: 0,
          y: 0
        };
        this.world_width = this.width * scenes;
        this.world_height = this.height * scenes;
        this.tile_size = 30;
        this.screen_width = this.width * this.tile_size;
        this.screen_height = this.height * this.tile_size + this.ui_height;
        this.ctx = null;
        this.solid_tiles = [2, 3];
        this.scene = [];
        this.empty_tiles = [];
        this.generate_world();
        this.load_scene();
      }

      Game.prototype.matrix_sub_area = function(matrix, x, y, width, height) {
        var row, _i, _len, _ref, _results;
        _ref = matrix.slice(y, (y + height) + 1 || 9e9);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          row = _ref[_i];
          _results.push(row.slice(x, (x + width) + 1 || 9e9));
        }
        return _results;
      };

      Game.prototype.generate_world = function() {
        var world, x, y, _i, _ref;
        world = (function() {
          var _i, _ref, _results;
          _results = [];
          for (y = _i = 0, _ref = this.world_height - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; y = 0 <= _ref ? ++_i : --_i) {
            _results.push((function() {
              var _j, _ref1, _results1;
              _results1 = [];
              for (x = _j = 0, _ref1 = this.world_width - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; x = 0 <= _ref1 ? ++_j : --_j) {
                _results1.push(this.block_type(PerlinNoise(this.perlin_size * x / this.world_width, this.perlin_size * y / this.world_height, .8)));
              }
              return _results1;
            }).call(this));
          }
          return _results;
        }).call(this);
        world[this.world_height - 1] = world[0] = (function() {
          var _i, _ref, _results;
          _results = [];
          for (x = _i = 0, _ref = this.world_width - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; x = 0 <= _ref ? ++_i : --_i) {
            _results.push(3);
          }
          return _results;
        }).call(this);
        for (x = _i = 0, _ref = this.world_height - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; x = 0 <= _ref ? ++_i : --_i) {
          world[x][this.world_width - 1] = world[x][0] = 3;
        }
        return this.world = world;
      };

      Game.prototype.block_type = function(height) {
        if (height <= .35) {
          return 2;
        }
        if ((.35 < height && height < .6)) {
          return 1;
        }
        return 3;
      };

      Game.prototype.load_scene = function() {
        var cell, row, x, y, _i, _len, _ref, _results;
        this.scene = this.matrix_sub_area(this.world, this.current_scene.x * this.width, this.current_scene.y * this.height, this.width, this.height);
        _ref = this.scene;
        _results = [];
        for (y = _i = 0, _len = _ref.length; _i < _len; y = ++_i) {
          row = _ref[y];
          _results.push((function() {
            var _j, _len1, _results1;
            _results1 = [];
            for (x = _j = 0, _len1 = row.length; _j < _len1; x = ++_j) {
              cell = row[x];
              if (__indexOf.call(this.solid_tiles, cell) < 0) {
                _results1.push(this.empty_tiles.push({
                  x: x,
                  y: y
                }));
              } else {
                _results1.push(void 0);
              }
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };

      return Game;

    })();
    return new Game;
  });

}).call(this);
