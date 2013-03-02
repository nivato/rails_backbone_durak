RailsBackboneDurak.Views.AttackerCards ||= {}

class RailsBackboneDurak.Views.AttackerCards.AttackerCards extends Backbone.View
  
  initialize: () ->
    @options.eventer.bind("update_table", @update_cards)
    @options.attackerCards.bind('reset', @render)

  addAll: () =>
    @options.attackerCards.each(@addOne)

  addOne: (attackerCard) =>
    $(@el).append("<div class='#{attackerCard.get("card_class")}'></div>")

  render: =>
    $(@el).html("")
    $(@el).attr("id", "attacker-cards")
    @addAll()
    return this

  update_cards: =>
    @options.attackerCards.fetch()