RailsBackboneDurak.Views.PlayerCards ||= {}

class RailsBackboneDurak.Views.PlayerCards.View extends Backbone.View
  template: JST["backbone/templates/player_cards/view"]

  initialize: () ->
    @options.eventer.bind("update_table", @update_cards)
    @options.playerCards.bind('reset', @render)

  addAll: () =>
    @options.playerCards.each(@addOne)

  addOne: (playerCard) =>
    view = new RailsBackboneDurak.Views.PlayerCards.PlayerCardView({model : playerCard, eventer: @options.eventer})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).attr("id", "player-cards")
    $(@el).html(@template(playerCards: @options.playerCards.toJSON() ))
    @addAll()
    return this
    
  update_cards: =>
    @options.playerCards.fetch()
