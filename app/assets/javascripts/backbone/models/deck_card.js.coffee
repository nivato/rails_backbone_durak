class RailsBackboneDurak.Models.DeckCard extends Backbone.Model
  defaults:
    card: null

class RailsBackboneDurak.Collections.DeckCardsCollection extends Backbone.Collection
  model: RailsBackboneDurak.Models.DeckCard
  url: '/deck'
