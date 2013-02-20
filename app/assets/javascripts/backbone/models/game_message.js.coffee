class RailsBackboneDurak.Models.GameMessage extends Backbone.Model
  defaults:
    card: null

class RailsBackboneDurak.Collections.GameMessagesCollection extends Backbone.Collection
  model: RailsBackboneDurak.Models.GameMessage
  url: '/game'
