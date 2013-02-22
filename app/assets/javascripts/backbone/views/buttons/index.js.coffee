RailsBackboneDurak.Views.Buttons ||= {}

class RailsBackboneDurak.Views.Buttons.Index extends Backbone.View
  template: JST["backbone/templates/buttons/index"]

  initialize: () ->
    @options.eventer.bind("update_table", @update_buttons)
    @options.buttons.bind('reset', @render)

  addAll: () =>
    @options.buttons.each(@addOne)

  addOne: (button) =>
    view = new RailsBackboneDurak.Views.Buttons.Button({model : button, eventer: @options.eventer})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(buttons: @options.buttons.toJSON() ))
    @addAll()
    return this
  
  update_buttons: =>
    @options.buttons.fetch()