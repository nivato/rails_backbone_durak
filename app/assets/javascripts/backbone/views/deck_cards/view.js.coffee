RailsBackboneDurak.Views.DeckCards ||= {}

class RailsBackboneDurak.Views.DeckCards.View extends Backbone.View
  initialize: () ->
    @options.eventer.bind("update_deck", @update_deck)
    @options.deckCards.bind('reset', @render)

  addAll: () =>
    @options.deckCards.each(@addOne)

  addOne: (deckCard) =>
    view = new RailsBackboneDurak.Views.DeckCards.DeckCardView({model : deckCard})
    $(@el).append(view.render().el)

  render: =>
    $(@el).html("")
    $(@el).attr("id", "deck-cards")
    @addAll()
    $(@el).append('<div class="card-back-a"></div>')
    return this
  
  update_deck: =>
    @options.deckCards.fetch()
