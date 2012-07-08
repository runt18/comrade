// Generated by CoffeeScript 1.3.3
(function() {

  define(['jquery', 'game'], function($, g) {
    var Renderer;
    Renderer = (function() {

      function Renderer() {}

      Renderer.prototype.init = function() {
        var $canvas, canvas;
        $canvas = $('<canvas>');
        window.$body = $('body');
        $('#game').html($canvas);
        canvas = $canvas[0];
        canvas.width = g.screen_width;
        canvas.height = g.screen_height;
        return this.ctx = canvas.getContext('2d');
      };

      Renderer.prototype.clear = function() {
        return this.ctx.clearRect(0, 0, g.screen_width, g.screen_height);
      };

      Renderer.prototype.draw_texture = function(sx, sy, dx, dy) {
        var ts;
        ts = g.tile_size;
        return this.ctx.drawImage(texture_canvas, sx * ts, sy * ts, ts, ts, dx * ts, dy * ts, ts, ts);
      };

      Renderer.prototype.draw_block = function(dx, dy, type) {
        var sx, sy;
        sy = 1;
        switch (type) {
          case 1:
            sx = 1;
            break;
          case 2:
            sx = 2;
            break;
          case 3:
            sx = 3;
            break;
          case 4:
            sx = 4;
        }
        return this.draw_texture(sx, sy, dx, dy);
      };

      Renderer.prototype.draw_object = function(dx, dy, type) {
        var sx, sy;
        if (type === 0) {
          return;
        }
        sy = 5;
        sx = type;
        return this.draw_texture(sx, sy, dx, dy);
      };

      Renderer.prototype.draw_health_bar = function(value, max) {
        var height;
        height = 20;
        this.ctx.fillStyle = this.ctx.strokeStyle = 'red';
        this.ctx.strokeRect(g.screen_width - 200, g.screen_height - 25, 100, height);
        return this.ctx.fillRect(g.screen_width - 200, g.screen_height - 25, 100 * value / max, height);
      };

      Renderer.prototype.draw_coins = function(num) {
        this.draw_texture(4, 3, 29, 20);
        return this.ctx.fillText(num, g.screen_width - 40, g.screen_height - 10);
      };

      Renderer.prototype.draw_inventory = function(player) {
        var slot, sx, sy, ts, x, _i, _len, _ref;
        this.ctx.fillStyle = 'grey';
        this.ctx.fillRect(0, g.screen_height - g.ui_height, g.screen_width, g.screen_height);
        this.ctx.fillStyle = 'white';
        ts = g.tile_size;
        _ref = player.inventory;
        for (x = _i = 0, _len = _ref.length; _i < _len; x = ++_i) {
          slot = _ref[x];
          sy = 3;
          switch (slot.item.id) {
            case 1:
              sx = 1;
              break;
            case 2:
              sx = 2;
              break;
            case 3:
              sx = 3;
          }
          if (slot.count > 0) {
            this.draw_texture(sx, sy, x, (g.screen_height - g.ui_height) / g.tile_size);
            this.ctx.fillText(slot.count, x * ts + 30, g.screen_height - 10);
          }
        }
        this.draw_coins(player.coins);
        return this.draw_health_bar(player.health, player.max_health);
      };

      return Renderer;

    })();
    return new Renderer;
  });

}).call(this);