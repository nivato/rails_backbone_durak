class RailsBackboneDurak.Models.PlayerCard extends Backbone.Model
  defaults:
    card: null

class RailsBackboneDurak.Collections.PlayerCardsCollection extends Backbone.Collection
  model: RailsBackboneDurak.Models.PlayerCard
  url: '/player'
