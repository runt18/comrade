// Generated by CoffeeScript 1.3.3
(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['constants'], function() {
    var Creature, Entity, Player;
    Entity = (function() {

      function Entity(x, y) {
        var direction, _i, _len, _ref;
        this.x = x;
        this.y = y;
        this.images = {
          up: new Image(),
          left: new Image(),
          down: new Image(),
          right: new Image()
        };
        _ref = 'up left down right'.split(' ');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          direction = _ref[_i];
          this.images[direction].src = "img/sprites/player/" + direction + ".png";
        }
        this.image = this.images.down;
        this.frames_left = 0;
        this.set_position();
        this.axis = 'x';
        this.direction = 1;
        this.set_in_front();
      }

      Entity.prototype.set_image = function() {
        var image;
        switch (this.axis) {
          case 'x':
            image = this.direction === 1 ? 'right' : 'left';
            break;
          case 'y':
            image = this.direction === 1 ? 'down' : 'up';
        }
        return this.image = this.images[image];
      };

      Entity.prototype.set_in_front = function() {
        switch (this.axis) {
          case 'x':
            return this.in_front = {
              x: this.pos.x + this.direction * 2,
              y: this.pos.y
            };
          case 'y':
            return this.in_front = {
              x: this.pos.x,
              y: this.pos.y + this.direction * 2
            };
        }
      };

      Entity.prototype.draw = function() {
        return ctx.drawImage(this.image, this.pos.x * tile_size, this.pos.y * tile_size, tile_size, tile_size);
      };

      Entity.prototype.animate = function() {
        if (this.frames_left > 0) {
          this.pos[this.axis] += this.direction * 0.1;
          this.frames_left -= 1;
        } else {
          this.pos.x = Math.round(this.pos.x);
          this.pos.y = Math.round(this.pos.y);
        }
        return this.draw();
      };

      Entity.prototype.move = function(axis, direction) {
        var next_tile;
        if (this.frames_left > 0) {
          return;
        }
        this.axis = axis;
        this.direction = direction;
        this.set_image();
        this.move_scene();
        try {
          next_tile = scene[this.in_front.y][this.in_front.x];
        } catch (TypeError) {

        }
        this.set_in_front();
        debugger;
        this.frames_left = 10;
        if (__indexOf.call(solid_tiles, next_tile) >= 0) {
          return this.frames_left = 0;
        }
      };

      return Entity;

    })();
    Player = (function(_super) {

      __extends(Player, _super);

      function Player() {
        return Player.__super__.constructor.apply(this, arguments);
      }

      Player.prototype.set_position = function() {
        return this.pos = {
          x: width / 2,
          y: height / 2
        };
      };

      Player.prototype.move_scene = function() {
        var item, new_scene, _i, _len, _ref;
        new_scene = false;
        _ref = [
          {
            axis: 'x',
            dimension: width
          }, {
            axis: 'y',
            dimension: height
          }
        ];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          if (this.pos[item.axis] === 0 && this.axis === item.axis && this.direction === -1) {
            this.pos[item.axis] = item.dimension;
            current_scene[item.axis] -= 1;
            new_scene = true;
          }
          if (this.pos[item.axis] === item.dimension - 1 && this.axis === item.axis && this.direction === 1) {
            this.pos[item.axis] = -1;
            current_scene[item.axis] += 1;
            new_scene = true;
          }
        }
        if (new_scene) {
          return load_scene();
        }
      };

      return Player;

    })(Entity);
    Creature = (function(_super) {

      __extends(Creature, _super);

      function Creature() {
        return Creature.__super__.constructor.apply(this, arguments);
      }

      Creature.prototype.set_position = function() {
        return this.pos = {
          x: this.x || Math.floor(Math.random() * width),
          y: this.y || Math.floor(Math.random() * height)
        };
      };

      Creature.prototype.move_scene = function() {};

      return Creature;

    })(Entity);
    return {
      Player: Player,
      Creature: Creature
    };
  });

}).call(this);
