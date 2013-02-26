RailsBackboneDurak.Views.PileCards ||= {}

class RailsBackboneDurak.Views.PileCards.Pile extends Backbone.View

  initialize: () ->
    @options.eventer.bind("update_table", @update_cards)
    @options.pileCards.bind('reset', @render)

  addAll: () =>
    @options.pileCards.each(@addOne)

  addOne: (pile) =>
    for i in [1..pile.get("size") - 1]
      $(@el).append("<div class='pile card-back-i'></div>")
    $(@el).append('<div class="card-back-i"></div>')

  render: =>
    $(@el).html("")
    $(@el).attr("id", "pile-cards")
    @addAll()
    return this

  update_cards: =>
    @options.pileCards.fetch()