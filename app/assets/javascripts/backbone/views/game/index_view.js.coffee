RailsBackboneDurak.Views.Game ||= {}

class RailsBackboneDurak.Views.Game.IndexView extends Backbone.View
  constructor: () ->
    super
  
  addAll: () =>
    messages_view = new RailsBackboneDurak.Views.Messages.Index(eventer: @options.eventer, messages: @options.messages)
    buttons_view = new RailsBackboneDurak.Views.Buttons.Index(eventer: @options.eventer, buttons: @options.buttons)
    trump_view = new RailsBackboneDurak.Views.TrumpCards.Index(eventer: @options.eventer, trumpCards: @options.trump_cards)
    deck_view = new RailsBackboneDurak.Views.DeckCards.View(eventer: @options.eventer, deckCards: @options.deck_cards)
    player_view = new RailsBackboneDurak.Views.PlayerCards.View(eventer: @options.eventer, playerCards: @options.player_cards)
    computer_view = new RailsBackboneDurak.Views.ComputerCards.View(eventer: @options.eventer, computerCards: @options.computer_cards)
    pile_view = new RailsBackboneDurak.Views.PileCards.View(eventer: @options.eventer, pileCards: @options.pile_cards)
    table_view = new RailsBackboneDurak.Views.Table.TableView(eventer: @options.eventer, attacker_cards: @options.attacker_cards, defender_cards: @options.defender_cards)
    $(@el).append(messages_view.render().el)
    $(@el).append(trump_view.render().el)
    $(@el).append(deck_view.render().el)
    $(@el).append(player_view.render().el)
    $(@el).append(computer_view.render().el)
    $(@el).append(table_view.render().el)
    $(@el).append(buttons_view.render().el)
    $(@el).append(pile_view.render().el)

  render: =>
    $(@el).attr("id", "game")
    @addAll()
    return this
