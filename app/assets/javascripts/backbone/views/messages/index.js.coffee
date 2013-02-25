RailsBackboneDurak.Views.Messages ||= {}

class RailsBackboneDurak.Views.Messages.Index extends Backbone.View
  template: JST["backbone/templates/messages/index"]

  initialize: () ->
    @options.eventer.bind("update_message", @update_message)
    @options.messages.bind('reset', @render)

  addAll: () =>
    @options.messages.each(@addOne)

  addOne: (message) =>
    view = new RailsBackboneDurak.Views.Messages.Message({model : message})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).attr("id", "message")
    $(@el).html(@template(messages: @options.messages.toJSON() ))
    @addAll()
    return this
    
  update_message: =>
    @options.messages.fetch()