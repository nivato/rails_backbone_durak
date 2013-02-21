RailsBackboneDurak.Views.TrumpCards ||= {}

class RailsBackboneDurak.Views.TrumpCards.TrumpCard extends Backbone.View
  template: JST["backbone/templates/trump_cards/trump_card"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
