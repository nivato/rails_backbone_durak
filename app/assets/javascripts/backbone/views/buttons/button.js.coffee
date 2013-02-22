RailsBackboneDurak.Views.Buttons ||= {}

class RailsBackboneDurak.Views.Buttons.Button extends Backbone.View
  template: JST["backbone/templates/buttons/button"]

  tagName: "tr"
  
  events:
    "click #next"       : "next_action"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
  
  next_action: =>
    @model.destroy({success: @end_of_turn_callback})
    this.remove()
    return false
  
  end_of_turn_callback: =>
    @options.eventer.trigger("update_table")
