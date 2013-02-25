RailsBackboneDurak.Views.DeckCards ||= {}

class RailsBackboneDurak.Views.DeckCards.DeckCardView extends Backbone.View

  render: ->
    $(@el).attr("id", "card")
    $(@el).html(@model.get("rank") + @model.get("suit"))
    return this
