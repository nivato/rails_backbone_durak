RailsBackboneDurak.Views.GameMessages ||= {}

class RailsBackboneDurak.Views.GameMessages.Index extends Backbone.View
  template: JST["backbone/templates/game_messages/index"]
  
  initialize: () ->
    @options.gameMessages.bind('reset', @render)

  addAll: () =>
    @options.gameMessages.each(@addOne)

  addOne: (gameMessage) =>
    view = new RailsBackboneDurak.Views.GameMessages.Message({model : gameMessage})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(gameMessages: @options.gameMessages.toJSON() ))
    @addAll()
    return this