RailsBackboneDurak.Views.Buttons ||= {}

class RailsBackboneDurak.Views.Buttons.Button extends Backbone.View
  template: JST["backbone/templates/buttons/button"]

  tagName: "tr"
  
  events:
    "click #next"           : "end_of_turn"
    "click #take_cards"     : "end_of_turn"
    "click #new_game"       : "end_of_turn"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
  
  end_of_turn: =>
    @model.destroy({success: @end_of_turn_callback})
    this.remove()
    return false
  
  end_of_turn_callback: =>
    @options.eventer.trigger("update_table")
    @options.eventer.trigger("update_deck")
