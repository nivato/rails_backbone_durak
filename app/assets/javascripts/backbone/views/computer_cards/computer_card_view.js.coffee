RailsBackboneDurak.Views.ComputerCards ||= {}

class RailsBackboneDurak.Views.ComputerCards.ComputerCardView extends Backbone.View
  template: JST["backbone/templates/computer_cards/computer_card"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
