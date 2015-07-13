RailsBackboneDurak.Views.Messages ||= {}

class RailsBackboneDurak.Views.Messages.Message extends Backbone.View

  initialize: (@options) =>
    @options.eventer.bind("update_message", @update_message)
    @options.messages.bind('reset', @render)

  addAll: () =>
    @options.messages.each(@addOne)

  addOne: (message) =>
    $(@el).append(message.get("message"))

  render: =>
    $(@el).html("")
    $(@el).attr("id", "message")
    @addAll()
    return this

  update_message: =>
    @options.messages.fetch(reset: true)