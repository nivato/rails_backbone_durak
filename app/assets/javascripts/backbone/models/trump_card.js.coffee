class RailsBackboneDurak.Models.TrumpCard extends Backbone.Model
  defaults:
    card: null

class RailsBackboneDurak.Collections.TrumpCardsCollection extends Backbone.Collection
  model: RailsBackboneDurak.Models.TrumpCard
  url: '/trump'
