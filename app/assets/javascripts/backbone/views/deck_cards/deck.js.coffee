RailsBackboneDurak.Views.DeckCards ||= {}

class RailsBackboneDurak.Views.DeckCards.Deck extends Backbone.View
  initialize: () ->
    @options.eventer.bind("update_deck", @update_deck)
    @options.deckCards.bind('reset', @render)

  addAll: () =>
    @options.deckCards.each(@addOne)

  addOne: (deck) =>
    if deck.get("size") > 2
      for i in [1..deck.get("size") - 2]
        $(@el).append("<div class='deck card-back-a'></div>")
      $(@el).append('<div class="card-back-a"></div>')
      $(@el).append("<div class='card-#{deck.get("trump")}'></div>")
    else
      if deck.get("size") == 2
        $(@el).append('<div class="card-back-a"></div>')
        $(@el).append("<div class='card-#{deck.get("trump")}'></div>")
      if deck.get("size") == 1
        $(@el).append("<div class='card-#{deck.get("trump")}'></div>")
      if deck.get("size") == 0
        $(@el).append("<div class='disabled card-#{deck.get("trump")}'></div>")

  render: =>
    $(@el).html("")
    $(@el).attr("id", "deck-cards")
    @addAll()
    return this
  
  update_deck: =>
    @options.deckCards.fetch()
