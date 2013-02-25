RailsBackboneDurak.Views.DeckCards ||= {}

class RailsBackboneDurak.Views.DeckCards.View extends Backbone.View
  template: JST["backbone/templates/deck_cards/view"]

  initialize: () ->
    @options.eventer.bind("update_deck", @update_deck)
    @options.deckCards.bind('reset', @render)

  addAll: () =>
    @options.deckCards.each(@addOne)

  addOne: (deckCard) =>
    view = new RailsBackboneDurak.Views.DeckCards.DeckCardView({model : deckCard})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).attr("id", "deck-cards")
    $(@el).html(@template(deckCards: @options.deckCards.toJSON() ))
    @addAll()
    return this
  
  update_deck: =>
    @options.deckCards.fetch()
