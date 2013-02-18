class RailsBackboneDurak.Routers.GameRouter extends Backbone.Router

  routes:
    ""    : "index"

  index: ->
    deck_cards = new RailsBackboneDurak.Collections.DeckCardsCollection()
    @view = new RailsBackboneDurak.Views.Game.IndexView(deck_cards: deck_cards)
    $("#game").html(@view.render().el)
    deck_cards.fetch()
