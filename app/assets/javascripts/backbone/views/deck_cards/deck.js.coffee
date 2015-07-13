RailsBackboneDurak.Views.DeckCards ||= {}

class RailsBackboneDurak.Views.DeckCards.Deck extends Backbone.View
  initialize: (@options) =>
    @options.eventer.bind("update_deck", @update_deck)
    @options.deckCards.bind('reset', @render)

  addAll: () =>
    @options.deckCards.each(@addOne)

  addOne: (deck) =>
    if deck.get("size") > 2
      $(@el).append("<div class='trump #{deck.get("trump_class")}'></div>")
      for i in [1..deck.get("size") - 2]
        $(@el).append("<div class='deck-inside card-back-a'></div>")
      $(@el).append('<div class="deck-top card-back-a"></div>')
    else
      if deck.get("size") == 2
        $(@el).append("<div class='trump #{deck.get("trump_class")}'></div>")
        $(@el).append('<div class="deck-top card-back-a"></div>')
      if deck.get("size") == 1
        $(@el).append("<div class='trump #{deck.get("trump_class")}'></div>")
      if deck.get("size") == 0
        $(@el).append("<div class='trump disabled #{deck.get("trump_class")}'></div>")

  render: =>
    $(@el).html("")
    $(@el).attr("id", "deck-cards")
    @addAll()
    return this

  update_deck: =>
    @options.deckCards.fetch(reset: true)
