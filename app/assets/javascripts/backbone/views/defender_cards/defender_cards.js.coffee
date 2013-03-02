RailsBackboneDurak.Views.DefenderCards ||= {}

class RailsBackboneDurak.Views.DefenderCards.DefenderCards extends Backbone.View
  
  initialize: () ->
    @options.eventer.bind("update_table", @update_cards)
    @options.defenderCards.bind('reset', @render)

  addAll: () =>
    @options.defenderCards.each(@addOne)

  addOne: (defenderCard) =>
    $(@el).append("<div class='#{defenderCard.get("card_class")}'></div>")

  render: =>
    $(@el).html("")
    $(@el).attr("id", "defender-cards")
    @addAll()
    return this

  update_cards: =>
    @options.defenderCards.fetch()