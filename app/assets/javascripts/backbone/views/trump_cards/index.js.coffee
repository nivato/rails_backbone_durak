RailsBackboneDurak.Views.TrumpCards ||= {}

class RailsBackboneDurak.Views.TrumpCards.Index extends Backbone.View
  template: JST["backbone/templates/trump_cards/index"]

  initialize: () ->
    @options.trumpCards.bind('reset', @render)

  addAll: () =>
    @options.trumpCards.each(@addOne)

  addOne: (trumpCard) =>
    view = new RailsBackboneDurak.Views.TrumpCards.TrumpCard({model : trumpCard})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(trumpCards: @options.trumpCards.toJSON() ))
    @addAll()
    return this