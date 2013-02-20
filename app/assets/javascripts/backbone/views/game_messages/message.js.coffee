RailsBackboneDurak.Views.GameMessages ||= {}

class RailsBackboneDurak.Views.GameMessages.Message extends Backbone.View
  template: JST["backbone/templates/game_messages/message"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
