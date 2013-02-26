class RailsBackboneDurak.Routers.GameRouter extends Backbone.Router

  routes:
    ""    : "index"

  index: ->
    messages = new RailsBackboneDurak.Collections.MessagesCollection()
    buttons = new RailsBackboneDurak.Collections.ButtonsCollection()
    deck_cards = new RailsBackboneDurak.Collections.DeckCardsCollection()
    player_cards = new RailsBackboneDurak.Collections.PlayerCardsCollection()
    computer_cards = new RailsBackboneDurak.Collections.ComputerCardsCollection()
    attacker_cards = new RailsBackboneDurak.Collections.AttackerCardsCollection()
    defender_cards = new RailsBackboneDurak.Collections.DefenderCardsCollection()
    @eventer = new RailsBackboneDurak.EventAggregators.Eventer()
    @view = new RailsBackboneDurak.Views.Game.IndexView(eventer: @eventer, messages: messages, buttons: buttons, deck_cards: deck_cards, player_cards: player_cards, computer_cards: computer_cards, attacker_cards: attacker_cards, defender_cards: defender_cards)
    $("body").html(@view.render().el)
    messages.fetch()
    buttons.fetch()
    deck_cards.fetch()
    player_cards.fetch()
    computer_cards.fetch()
    attacker_cards.fetch()
    defender_cards.fetch()
