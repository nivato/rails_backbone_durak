RailsBackboneDurak.Views.Table ||= {}

class RailsBackboneDurak.Views.Table.TableView extends Backbone.View
  template: JST["backbone/templates/table/table"]
  
  addAll: () =>
    attacker_view = new RailsBackboneDurak.Views.AttackerCards.Attacker(eventer: @options.eventer, attackerCards: @options.attacker_cards)
    defender_view = new RailsBackboneDurak.Views.DefenderCards.Defender(eventer: @options.eventer, defenderCards: @options.defender_cards)
    @$("#attacker").append(attacker_view.render().el)
    @$("#defender").append(defender_view.render().el)

  render: =>
    $(@el).html(@template)
    @addAll()
    return this
