RailsBackboneDurak.Views.DeckCards ||= {}

class RailsBackboneDurak.Views.DeckCards.View extends Backbone.View
  template: JST["backbone/templates/deck_cards/view"]

  initialize: () ->
    @options.deckCards.bind('reset', @addAll)

  addAll: () =>
    @options.deckCards.each(@addOne)

  addOne: (deckCard) =>
    view = new RailsBackboneDurak.Views.DeckCards.DeckCardView({model : deckCard})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(deckCards: @options.deckCards.toJSON() ))
    @addAll()

    return this
