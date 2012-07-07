// Generated by CoffeeScript 1.3.3
(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  define(['game'], function(g) {
    var Entity;
    return Entity = (function() {

      function Entity(pos) {
        this.pos = pos;
        this.create_images();
        this.image = this.images.down;
        this.frames_left = 0;
        this.set_position();
        this.axis = 'x';
        this.direction = 1;
        this.set_in_front();
        this.set_stats();
        this.inventory = [];
      }

      Entity.prototype.set_position = function() {
        return this.pos = this.pos || g.empty_tiles[Math.round(Math.random() * g.empty_tiles.length)];
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

      Entity.prototype.snap_to_grid = function() {
        this.pos.x = Math.round(this.pos.x);
        return this.pos.y = Math.round(this.pos.y);
      };

      Entity.prototype.draw = function() {
        return g.draw_texture(this.image.x, this.image.y, this.pos.x, this.pos.y);
      };

      Entity.prototype.animate = function() {
        if (this.frames_left > 0) {
          this.pos[this.axis] += this.direction * 0.1;
          this.frames_left -= 1;
        } else {
          this.snap_to_grid();
        }
        return this.draw();
      };

      Entity.prototype.move = function(axis, direction) {
        var next_tile;
        if (this.frames_left > 0) {
          return;
        }
        this.snap_to_grid();
        this.axis = axis;
        this.direction = direction;
        this.set_image();
        this.move_scene();
        this.set_in_front();
        try {
          if (axis === 'x') {
            next_tile = g.scene[this.pos.y][this.pos.x + direction];
          }
          if (axis === 'y') {
            next_tile = g.scene[this.pos.y + direction][this.pos.x];
          }
          if (__indexOf.call(g.solid_tiles, next_tile) < 0) {
            return this.frames_left = 10;
          }
        } catch (TypeError) {

        }
      };

      return Entity;

    })();
  });

}).call(this);
