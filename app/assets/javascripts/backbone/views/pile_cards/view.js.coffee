RailsBackboneDurak.Views.PileCards ||= {}

class RailsBackboneDurak.Views.PileCards.View extends Backbone.View
  template: JST["backbone/templates/pile_cards/view"]

  initialize: () ->
    @options.eventer.bind("update_table", @update_cards)
    @options.pileCards.bind('reset', @render)

  addAll: () =>
    @options.pileCards.each(@addOne)

  addOne: (pileCard) =>
    view = new RailsBackboneDurak.Views.PileCards.PileCardView({model : pileCard})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).attr("id", "pile-cards")
    $(@el).html(@template(pileCards: @options.pileCards.toJSON() ))
    @addAll()
    return this

  update_cards: =>
    @options.pileCards.fetch()