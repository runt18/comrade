// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['npc'], function(NPC) {
    var Fisherman;
    return Fisherman = (function(_super) {

      __extends(Fisherman, _super);

      function Fisherman() {
        return Fisherman.__super__.constructor.apply(this, arguments);
      }

      Fisherman.prototype.move_scene = function() {};

      Fisherman.prototype.create_images = function() {
        return this.images = {
          up: {
            x: 1,
            y: 0
          },
          left: {
            x: 3,
            y: 0
          },
          down: {
            x: 2,
            y: 0
          },
          right: {
            x: 4,
            y: 0
          }
        };
      };

      Fisherman.prototype.set_stats = function() {
        this.name = 'Fisherman';
        this.phrases = ["My family's fished these waters for 4 generations"];
        this.phrase_index = 0;
        this.selling = false;
        return this.item_id = 2;
      };

      return Fisherman;

    })(NPC);
  });

}).call(this);