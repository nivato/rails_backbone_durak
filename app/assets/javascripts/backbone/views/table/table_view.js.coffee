RailsBackboneDurak.Views.Table ||= {}

class RailsBackboneDurak.Views.Table.TableView extends Backbone.View
  
  addAll: () =>
    attacker_view = new RailsBackboneDurak.Views.AttackerCards.AttackerCards(eventer: @options.eventer, attackerCards: @options.attacker_cards)
    defender_view = new RailsBackboneDurak.Views.DefenderCards.DefenderCards(eventer: @options.eventer, defenderCards: @options.defender_cards)
    $(@el).append(attacker_view.render().el)
    $(@el).append(defender_view.render().el)

  render: =>
    $(@el).attr("id", "table-cards")
    @addAll()
    return this
