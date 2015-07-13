RailsBackboneDurak.Views.PlayerCards ||= {}

class RailsBackboneDurak.Views.PlayerCards.PlayerCards extends Backbone.View
  initialize: (@options) =>
    @options.eventer.bind("update_table", @update_cards)
    @options.playerCards.bind('reset', @render)

  addAll: () =>
    @options.playerCards.each(@addOne)

  addOne: (playerCard) =>
    view = new RailsBackboneDurak.Views.PlayerCards.Card({model : playerCard, eventer: @options.eventer})
    $(@el).append(view.render().el)

  render: =>
    $(@el).html("")
    $(@el).attr("id", "player-cards")
    @addAll()
    return this

  update_cards: =>
    @options.playerCards.fetch(reset: true)
