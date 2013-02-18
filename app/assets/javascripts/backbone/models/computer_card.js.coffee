class RailsBackboneDurak.Models.ComputerCard extends Backbone.Model
  defaults:
    card: null

class RailsBackboneDurak.Collections.ComputerCardsCollection extends Backbone.Collection
  model: RailsBackboneDurak.Models.ComputerCard
  url: '/computer'
