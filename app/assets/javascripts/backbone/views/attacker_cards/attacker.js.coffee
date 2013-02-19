RailsBackboneDurak.Views.AttackerCards ||= {}

class RailsBackboneDurak.Views.AttackerCards.Attacker extends Backbone.View
  template: JST["backbone/templates/attacker_cards/attacker"]
  
  initialize: () ->
    @options.attackerCards.bind('reset', @addAll)

  addAll: () =>
    @options.attackerCards.each(@addOne)

  addOne: (attackerCard) =>
    view = new RailsBackboneDurak.Views.AttackerCards.AttackerCardView({model : attackerCard})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(attackerCards: @options.attackerCards.toJSON() ))
    @addAll()
    return this
