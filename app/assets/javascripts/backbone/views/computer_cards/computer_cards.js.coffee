RailsBackboneDurak.Views.ComputerCards ||= {}

class RailsBackboneDurak.Views.ComputerCards.ComputerCards extends Backbone.View
  initialize: () ->
    @options.eventer.bind("update_table", @update_cards)
    @options.computerCards.bind('reset', @render)

  addAll: () =>
    @options.computerCards.each(@addOne)

  addOne: (computer_cards) =>
    if computer_cards.get("size") >= 1
      if computer_cards.get("size") > 6
        width = Math.round(680/computer_cards.get("size"))
        for i in [1..computer_cards.get("size")]
          $(@el).append("<div class='card' style='width: #{width}px;'><img class='card-back-a' /></div>")
      else
        for i in [1..computer_cards.get("size")]
          $(@el).append('<div class="card"><img class="card-back-a" /></div>')

  render: =>
    $(@el).html("")
    $(@el).attr("id", "computer-cards")
    @addAll()
    return this

  update_cards: =>
    @options.computerCards.fetch()