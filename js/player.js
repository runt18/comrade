// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  define(['underscore', 'entity', 'game', 'scene'], function(_, Entity, g, s) {
    var Fish, Item, Log, Player, Rock;
    Item = (function() {

      function Item() {
        this.set_stats();
      }

      return Item;

    })();
    Log = (function(_super) {

      __extends(Log, _super);

      function Log() {
        return Log.__super__.constructor.apply(this, arguments);
      }

      Log.prototype.set_stats = function() {
        this.name = 'log';
        this.id = 5;
        return this.value = 3;
      };

      return Log;

    })(Item);
    Fish = (function(_super) {

      __extends(Fish, _super);

      function Fish() {
        return Fish.__super__.constructor.apply(this, arguments);
      }

      Fish.prototype.set_stats = function() {
        this.name = 'fish';
        this.id = 2;
        return this.value = 3;
      };

      return Fish;

    })(Item);
    Rock = (function(_super) {

      __extends(Rock, _super);

      function Rock() {
        return Rock.__super__.constructor.apply(this, arguments);
      }

      Rock.prototype.set_stats = function() {
        this.name = 'rock';
        this.id = 3;
        return this.value = 3;
      };

      return Rock;

    })(Item);
    Player = (function(_super) {

      __extends(Player, _super);

      function Player() {
        return Player.__super__.constructor.apply(this, arguments);
      }

      Player.prototype.move_scene = function() {
        var axis, dimension, new_scene, _ref;
        new_scene = false;
        _ref = {
          x: g.width,
          y: g.height
        };
        for (axis in _ref) {
          dimension = _ref[axis];
          if (this.pos[axis] === 0 && this.axis === axis && this.direction === -1) {
            this.pos[axis] = dimension;
            s.pos[axis] -= 1;
            new_scene = true;
          }
          if (this.pos[axis] === dimension - 1 && this.axis === axis && this.direction === 1) {
            this.pos[axis] = -1;
            s.pos[axis] += 1;
            new_scene = true;
          }
        }
        if (new_scene) {
          return s.set();
        }
      };

      Player.prototype.create_images = function() {
        return this.images = {
          up: {
            x: 1,
            y: 2
          },
          left: {
            x: 3,
            y: 2
          },
          down: {
            x: 2,
            y: 2
          },
          right: {
            x: 4,
            y: 2
          }
        };
      };

      Player.prototype.set_stats = function() {
        this.max_health = 10;
        this.health = this.max_health - 5;
        this.attack = 2;
        return this.coins = 0;
      };

      Player.prototype.attack_creature = function() {
        var creature, _i, _len, _ref;
        _ref = s.current.creatures;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          creature = _ref[_i];
          if (this.in_front.x === creature.pos.x && this.in_front.y === creature.pos.y) {
            creature.health -= this.attack;
            if (creature.health <= 0) {
              creature.remove();
            }
            return true;
          }
        }
      };

      Player.prototype.gather_resource = function() {
        var already_present, free_slots, slot, tile, _i, _j, _len, _len1, _ref, _ref1, _ref2;
        tile = (_ref = this.next_object, __indexOf.call(g.resource_ids, _ref) >= 0) ? this.next_object : this.next_tile;
        if (__indexOf.call(g.resource_ids, tile) < 0) {
          return;
        }
        already_present = false;
        _ref1 = this.inventory;
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          slot = _ref1[_i];
          if (slot.item.id === tile) {
            already_present = true;
            slot.count += 1;
            break;
          }
        }
        if (!already_present) {
          free_slots = false;
          _ref2 = this.inventory;
          for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
            slot = _ref2[_j];
            if (slot.count === 0) {
              slot.count = 1;
              free_slots = true;
              switch (tile) {
                case 5:
                  slot.item = new Log;
                  break;
                case 2:
                  slot.item = new Fish;
                  break;
                case 3:
                  slot.item = new Rock;
              }
              break;
            }
          }
          if (!free_slots) {
            return log('inventory full');
          }
        }
      };

      Player.prototype.interact = function(tick) {
        var npc, _i, _len, _ref;
        if (tick % 20 === 0) {
          if (s.current.npcs) {
            _ref = s.current.npcs;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              npc = _ref[_i];
              if (this.in_front.x === npc.pos.x && this.in_front.y === npc.pos.y) {
                npc.interact();
                return;
              }
            }
          }
        }
        if (this.attack_creature()) {
          return;
        }
        if (tick % 50 === 0) {
          return this.gather_resource();
        }
      };

      return Player;

    })(Entity);
    return new Player;
  });

}).call(this);
