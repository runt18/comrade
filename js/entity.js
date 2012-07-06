// Generated by CoffeeScript 1.3.3
(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  define(['constants'], function() {
    var Entity;
    Entity = (function() {

      function Entity(pos) {
        var direction, _i, _len, _ref;
        this.pos = pos;
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

      Entity.prototype.set_position = function() {
        return this.pos = this.pos || empty_tiles[Math.round(Math.random() * empty_tiles.length)];
      };

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
        }
        return this.draw();
      };

      Entity.prototype.move = function(axis, direction) {
        var next_tile;
        if (this.frames_left > 0) {
          return;
        }
        this.pos.x = Math.round(this.pos.x);
        this.pos.y = Math.round(this.pos.y);
        this.axis = axis;
        this.direction = direction;
        this.set_image();
        this.move_scene();
        this.set_in_front();
        if (axis === 'x') {
          next_tile = scene[this.pos.y][this.pos.x + direction];
        }
        if (axis === 'y') {
          next_tile = scene[this.pos.y + direction][this.pos.x];
        }
        if (__indexOf.call(solid_tiles, next_tile) < 0) {
          return this.frames_left = 10;
        }
      };

      return Entity;

    })();
    return Entity;
  });

}).call(this);
