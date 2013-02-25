RailsBackboneDurak.Views.DeckCards ||= {}

class RailsBackboneDurak.Views.DeckCards.DeckCardView extends Backbone.View

  render: ->
    $(@el).attr("class", "card-#{@model.get('rank')+ @model.get('suit_char')}")
    return this
