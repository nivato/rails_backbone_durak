class RailsBackboneDurak.Models.PileCard extends Backbone.Model
  defaults:
    card: null

class RailsBackboneDurak.Collections.PileCardsCollection extends Backbone.Collection
  model: RailsBackboneDurak.Models.PileCard
  url: '/pile'
