RailsBackboneDurak.Views.Messages ||= {}

class RailsBackboneDurak.Views.Messages.Message extends Backbone.View
  template: JST["backbone/templates/messages/message"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
