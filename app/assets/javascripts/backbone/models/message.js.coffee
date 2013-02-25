class RailsBackboneDurak.Models.Message extends Backbone.Model
  defaults:
    message: null

class RailsBackboneDurak.Collections.MessagesCollection extends Backbone.Collection
  model: RailsBackboneDurak.Models.Message
  url: '/game'
