RailsBackboneDurak.Views.AttackerCards ||= {}

class RailsBackboneDurak.Views.AttackerCards.AttackerCardView extends Backbone.View
  template: JST["backbone/templates/attacker_cards/attacker_card"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
