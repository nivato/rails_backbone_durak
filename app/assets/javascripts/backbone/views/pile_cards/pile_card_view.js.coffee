RailsBackboneDurak.Views.PileCards ||= {}

class RailsBackboneDurak.Views.PileCards.PileCardView extends Backbone.View
  template: JST["backbone/templates/pile_cards/pile_card"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
