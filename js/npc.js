// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['entity'], function(Entity) {
    var NPC;
    return NPC = (function(_super) {

      __extends(NPC, _super);

      function NPC() {
        return NPC.__super__.constructor.apply(this, arguments);
      }

      NPC.prototype.chat = function() {
        var phrase;
        phrase = this.phrases[this.phrase_index];
        this.say(phrase);
        this.phrase_index += 1;
        if (this.phrase_index === this.phrases.length) {
          return this.phrase_index = 0;
        }
      };

      NPC.prototype.say = function(message) {
        var $dialogue;
        $dialogue = $('#dialogue');
        $dialogue.append($('<p>').text("" + this.name + ": " + message));
        return $dialogue.scrollTop($dialogue[0].scrollHeight);
      };

      NPC.prototype.interact = function() {
        if (!this.trade()) {
          return this.chat();
        }
      };

      return NPC;

    })(Entity);
  });

}).call(this);
