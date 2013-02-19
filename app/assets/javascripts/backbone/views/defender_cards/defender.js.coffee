RailsBackboneDurak.Views.DefenderCards ||= {}

class RailsBackboneDurak.Views.DefenderCards.Defender extends Backbone.View
  template: JST["backbone/templates/defender_cards/defender"]
  
  tagName: "td"
  
  initialize: () ->
    @options.defenderCards.bind('reset', @render)

  addAll: () =>
    @options.defenderCards.each(@addOne)

  addOne: (defenderCard) =>
    view = new RailsBackboneDurak.Views.DefenderCards.DefenderCardView({model : defenderCard})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(attackerCards: @options.defenderCards.toJSON() ))
    @addAll()
    return this
