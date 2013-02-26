RailsBackboneDurak.Views.ComputerCards ||= {}

class RailsBackboneDurak.Views.ComputerCards.ComputerCards extends Backbone.View
  initialize: () ->
    @options.eventer.bind("update_table", @update_cards)
    @options.computerCards.bind('reset', @render)

  addAll: () =>
    @options.computerCards.each(@addOne)

  addOne: (computer_cards) =>
    for i in [1..computer_cards.get("size")]
      $(@el).append('<div class="card-back-a"></div>')

  render: =>
    $(@el).html("")
    $(@el).attr("id", "computer-cards")
    @addAll()
    return this

  update_cards: =>
    @options.computerCards.fetch()