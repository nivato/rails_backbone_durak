RailsBackboneDurak.Views.DeckCards ||= {}

class RailsBackboneDurak.Views.DeckCards.DeckCardView extends Backbone.View

  render: ->
    $(@el).attr("class", "deck card-back-a")
    return this
