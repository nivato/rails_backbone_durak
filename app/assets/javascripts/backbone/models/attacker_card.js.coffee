class RailsBackboneDurak.Models.AttackerCard extends Backbone.Model
  defaults:
    card: null

class RailsBackboneDurak.Collections.AttackerCardsCollection extends Backbone.Collection
  model: RailsBackboneDurak.Models.AttackerCard
  url: '/attacker'
