// Generated by CoffeeScript 1.3.3
(function() {

  require(['jquery', 'game', 'scene', 'player', 'creature'], function($, g, s, player, Creature) {
    var animate, change_keys, draw_block, draw_inventory, draw_object, keys_down, load_music, load_textures, music, render, tick;
    draw_block = function(dx, dy, type) {
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
          break;
        case 5:
          sy = 5;
          sx = 1;
      }
      return g.draw_texture(sx, sy, dx, dy);
    };
    draw_object = function(dx, dy, type) {
      var sx, sy;
      if (type === 0) {
        return;
      }
      sy = 5;
      sx = type;
      return g.draw_texture(sx, sy, dx, dy);
    };
    load_textures = function() {
      var texture_context, textures;
      textures = new Image;
      textures.src = 'img/textures.png';
      window.texture_canvas = $('<canvas>')[0];
      texture_context = texture_canvas.getContext('2d');
      return textures.onload = function() {
        var x;
        texture_canvas.height = textures.height;
        texture_canvas.width = textures.width;
        texture_context.drawImage(textures, 0, 0);
        window.creatures = (function() {
          var _i, _ref, _results;
          _results = [];
          for (x = _i = 1, _ref = g.num_creatures; 1 <= _ref ? _i <= _ref : _i >= _ref; x = 1 <= _ref ? ++_i : --_i) {
            _results.push(new Creature);
          }
          return _results;
        })();
        return animate();
      };
    };
    music = null;
    load_music = function() {
      music = new Audio('audio/main.ogg');
      music.addEventListener('ended', function() {
        this.currentTime = 0;
        return this.play();
      }, false);
      music.muted = false;
      return music.play();
    };
    draw_inventory = function() {
      var slot, sx, sy, ts, x, _i, _len, _ref;
      g.ctx.fillStyle = 'grey';
      g.ctx.fillRect(0, g.screen_height - g.ui_height, g.screen_width, g.screen_height);
      g.ctx.fillStyle = 'white';
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
          g.draw_texture(sx, sy, x, (g.screen_height - g.ui_height) / g.tile_size);
          g.ctx.fillText(slot.count, x * ts + 30, g.screen_height - 10);
        }
      }
      g.draw_texture(4, 3, 29, 20);
      g.ctx.fillText(player.coins, g.screen_width - 40, g.screen_height - 10);
      g.ctx.fillStyle = g.ctx.strokeStyle = 'red';
      g.ctx.strokeRect(g.screen_width - 200, g.screen_height - 25, 100, 20);
      return g.ctx.fillRect(g.screen_width - 200, g.screen_height - 25, 100 * player.health / player.max_health, 20);
    };
    keys_down = {
      w: false,
      a: false,
      s: false,
      d: false,
      l: false,
      k: false
    };
    tick = 0;
    render = function(time) {
      var axis, creature, direction, object, row, tile, x, y, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _m, _ref, _ref1;
      if (keys_down.w) {
        player.move('y', -1);
      }
      if (keys_down.a) {
        player.move('x', -1);
      }
      if (keys_down.s) {
        player.move('y', 1);
      }
      if (keys_down.d) {
        player.move('x', 1);
      }
      if (tick % 200 === 0) {
        if (keys_down.l) {
          creatures.push(new Creature({
            x: player.in_front.x,
            y: player.in_front.y
          }));
        }
        if (keys_down.k) {
          player.interact();
        }
      }
      g.ctx.clearRect(0, 0, g.screen_width, g.screen_height);
      _ref = s.current.tiles;
      for (y = _i = 0, _len = _ref.length; _i < _len; y = ++_i) {
        row = _ref[y];
        for (x = _j = 0, _len1 = row.length; _j < _len1; x = ++_j) {
          tile = row[x];
          draw_block(x, y, tile);
        }
      }
      _ref1 = s.current.objects;
      for (y = _k = 0, _len2 = _ref1.length; _k < _len2; y = ++_k) {
        row = _ref1[y];
        for (x = _l = 0, _len3 = row.length; _l < _len3; x = ++_l) {
          object = row[x];
          draw_object(x, y, object);
        }
      }
      for (_m = 0, _len4 = creatures.length; _m < _len4; _m++) {
        creature = creatures[_m];
        if (tick % 10 === 0) {
          if (Math.random() > 0.9) {
            axis = Math.random() > 0.5 ? 'x' : 'y';
            direction = Math.random() > 0.5 ? 1 : -1;
            creature.move(axis, direction);
          }
        }
        creature.animate();
      }
      player.animate();
      draw_inventory();
      return tick += 1;
    };
    animate = function(time) {
      requestAnimationFrame(animate);
      return render(time);
    };
    change_keys = function(event) {
      var code, is_down, type;
      type = event.type;
      code = event.which;
      is_down = type === 'keydown';
      if (code === 87 || code === 65 || code === 83 || code === 68 || code === 75 || code === 76) {
        event.preventDefault();
        switch (code) {
          case 87:
            keys_down.w = is_down;
            break;
          case 65:
            keys_down.a = is_down;
            break;
          case 83:
            keys_down.s = is_down;
            break;
          case 68:
            keys_down.d = is_down;
            break;
          case 75:
            keys_down.k = is_down;
            break;
          case 76:
            keys_down.l = is_down;
        }
      }
      if (is_down) {
        if (code === 77) {
          return music.muted = !music.muted;
        }
      }
    };
    return $(document).ready(function() {
      var $body, $canvas, canvas;
      $canvas = $('<canvas>');
      $body = $('body');
      $('#game').html($canvas);
      canvas = $canvas[0];
      canvas.width = g.screen_width;
      canvas.height = g.screen_height;
      g.ctx = canvas.getContext('2d');
      $body.keydown(change_keys);
      $body.keyup(change_keys);
      load_textures();
      return load_music();
    });
  });

}).call(this);
