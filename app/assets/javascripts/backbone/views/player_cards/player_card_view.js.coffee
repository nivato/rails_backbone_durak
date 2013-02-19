RailsBackboneDurak.Views.PlayerCards ||= {}

class RailsBackboneDurak.Views.PlayerCards.PlayerCardView extends Backbone.View
  template: JST["backbone/templates/player_cards/player_card"]

  tagName: "tr"

  events:
    "click td"       : "play_card"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

  play_card: ->
    @model.destroy()
    this.remove()
    return false