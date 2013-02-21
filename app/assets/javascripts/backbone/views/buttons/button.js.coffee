RailsBackboneDurak.Views.Buttons ||= {}

class RailsBackboneDurak.Views.Buttons.Button extends Backbone.View
  template: JST["backbone/templates/buttons/button"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
