class RailsBackboneDurak.Routers.GameRouter extends Backbone.Router

  routes:
    ""    : "index"

  index: ->
    deck_cards = new RailsBackboneDurak.Collections.DeckCardsCollection()
    player_cards = new RailsBackboneDurak.Collections.PlayerCardsCollection()
    computer_cards = new RailsBackboneDurak.Collections.ComputerCardsCollection()
    @view = new RailsBackboneDurak.Views.Game.IndexView(deck_cards: deck_cards, player_cards: player_cards, computer_cards: computer_cards)
    $("#game").html(@view.render().el)
    deck_cards.fetch()
    player_cards.fetch()
    computer_cards.fetch()
