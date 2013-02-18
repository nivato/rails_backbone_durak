RailsBackboneDurak.Views.ComputerCards ||= {}

class RailsBackboneDurak.Views.ComputerCards.View extends Backbone.View
  template: JST["backbone/templates/computer_cards/view"]

  initialize: () ->
    @options.computerCards.bind('reset', @addAll)

  addAll: () =>
    @options.computerCards.each(@addOne)

  addOne: (computerCard) =>
    view = new RailsBackboneDurak.Views.ComputerCards.ComputerCardView({model : computerCard})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(computerCards: @options.computerCards.toJSON() ))
    @addAll()
    return this
