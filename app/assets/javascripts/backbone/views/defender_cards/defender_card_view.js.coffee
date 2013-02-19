RailsBackboneDurak.Views.DefenderCards ||= {}

class RailsBackboneDurak.Views.DefenderCards.DefenderCardView extends Backbone.View
  template: JST["backbone/templates/defender_cards/defender_card"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
