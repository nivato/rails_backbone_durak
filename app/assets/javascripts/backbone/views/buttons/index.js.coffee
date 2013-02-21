RailsBackboneDurak.Views.Buttons ||= {}

class RailsBackboneDurak.Views.Buttons.Index extends Backbone.View
  template: JST["backbone/templates/buttons/index"]

  initialize: () ->
    @options.buttons.bind('reset', @render)

  addAll: () =>
    @options.buttons.each(@addOne)

  addOne: (button) =>
    view = new RailsBackboneDurak.Views.Buttons.Button({model : button})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(buttons: @options.buttons.toJSON() ))
    @addAll()
    return this