class RailsBackboneDurak.Models.DefenderCard extends Backbone.Model
  defaults:
    card: null

class RailsBackboneDurak.Collections.DefenderCardsCollection extends Backbone.Collection
  model: RailsBackboneDurak.Models.DefenderCard
  url: '/defender'
