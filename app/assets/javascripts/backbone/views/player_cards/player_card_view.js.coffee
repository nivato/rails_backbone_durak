RailsBackboneDurak.Views.PlayerCards ||= {}

class RailsBackboneDurak.Views.PlayerCards.PlayerCardView extends Backbone.View
  template: JST["backbone/templates/player_cards/player_card"]

  tagName: "tr"

  events:
    "click .playable"       : "play_card"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

  play_card: ->
    @model.destroy({success: @update_table_callback})
    this.remove()
    return false
  
  update_table_callback: =>
    @options.eventer.trigger("update_table")