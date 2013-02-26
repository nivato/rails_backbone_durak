RailsBackboneDurak.Views.Game ||= {}

class RailsBackboneDurak.Views.Game.IndexView extends Backbone.View
  constructor: () ->
    super
  
  addAll: () =>
    messages_view = new RailsBackboneDurak.Views.Messages.Message(eventer: @options.eventer, messages: @options.messages)
    buttons_view = new RailsBackboneDurak.Views.Buttons.Buttons(eventer: @options.eventer, buttons: @options.buttons)
    deck_view = new RailsBackboneDurak.Views.DeckCards.Deck(eventer: @options.eventer, deckCards: @options.deck_cards)
    player_view = new RailsBackboneDurak.Views.PlayerCards.PlayerCards(eventer: @options.eventer, playerCards: @options.player_cards)
    computer_view = new RailsBackboneDurak.Views.ComputerCards.ComputerCards(eventer: @options.eventer, computerCards: @options.computer_cards)
    pile_view = new RailsBackboneDurak.Views.PileCards.Pile(eventer: @options.eventer, pileCards: @options.pile_cards)
    table_view = new RailsBackboneDurak.Views.Table.TableView(eventer: @options.eventer, attacker_cards: @options.attacker_cards, defender_cards: @options.defender_cards)
    $(@el).append(computer_view.render().el)
    $(@el).append("<div id='deck-pile-wrapper'></div>")
    @$("#deck-pile-wrapper").append(deck_view.render().el)
    @$("#deck-pile-wrapper").append(pile_view.render().el)
    $(@el).append(table_view.render().el)
    $(@el).append(messages_view.render().el)
    $(@el).append(buttons_view.render().el)
    $(@el).append(player_view.render().el)

  render: =>
    $(@el).attr("id", "game")
    @addAll()
    return this
