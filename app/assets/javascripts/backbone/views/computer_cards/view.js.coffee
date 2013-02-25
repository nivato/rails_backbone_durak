RailsBackboneDurak.Views.ComputerCards ||= {}

class RailsBackboneDurak.Views.ComputerCards.View extends Backbone.View
  template: JST["backbone/templates/computer_cards/view"]

  initialize: () ->
    @options.eventer.bind("update_table", @update_cards)
    @options.computerCards.bind('reset', @render)

  addAll: () =>
    @options.computerCards.each(@addOne)

  addOne: (computerCard) =>
    view = new RailsBackboneDurak.Views.ComputerCards.ComputerCardView({model : computerCard})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).attr("id", "computer-cards")
    $(@el).html(@template(computerCards: @options.computerCards.toJSON() ))
    @addAll()
    return this

  update_cards: =>
    @options.computerCards.fetch()