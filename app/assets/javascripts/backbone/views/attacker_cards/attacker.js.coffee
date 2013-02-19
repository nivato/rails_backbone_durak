RailsBackboneDurak.Views.AttackerCards ||= {}

class RailsBackboneDurak.Views.AttackerCards.Attacker extends Backbone.View
  template: JST["backbone/templates/attacker_cards/attacker"]
  
  tagName: "td"
  
  initialize: () ->
    @options.eventer.bind("update_table", @update_cards)
    @options.attackerCards.bind('reset', @render)

  addAll: () =>
    @options.attackerCards.each(@addOne)

  addOne: (attackerCard) =>
    view = new RailsBackboneDurak.Views.AttackerCards.AttackerCardView({model : attackerCard})
    @$("tbody").append(view.render().el)
    #@view.setElement(@$("tbody")).render()               http://ianstormtaylor.com/rendering-views-in-backbonejs-isnt-always-simple/     invastigate deeper!!!

  render: =>
    $(@el).html(@template(attackerCards: @options.attackerCards.toJSON() ))
    @addAll()
    return this

  update_cards: =>
    @options.attackerCards.fetch()