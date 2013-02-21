class RailsBackboneDurak.Models.Button extends Backbone.Model
  defaults:
    card: null

class RailsBackboneDurak.Collections.ButtonsCollection extends Backbone.Collection
  model: RailsBackboneDurak.Models.Button
  url: '/button'
