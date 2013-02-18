RailsBackboneDurak.Views.PlayerCards ||= {}

class RailsBackboneDurak.Views.PlayerCards.View extends Backbone.View
  template: JST["backbone/templates/player_cards/view"]

  initialize: () ->
    @options.playerCards.bind('reset', @addAll)

  addAll: () =>
    @options.playerCards.each(@addOne)

  addOne: (playerCard) =>
    view = new RailsBackboneDurak.Views.PlayerCards.PlayerCardView({model : playerCard})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(playerCards: @options.playerCards.toJSON() ))
    @addAll()
    return this
