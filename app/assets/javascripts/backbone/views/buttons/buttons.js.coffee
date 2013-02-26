RailsBackboneDurak.Views.Buttons ||= {}

class RailsBackboneDurak.Views.Buttons.Buttons extends Backbone.View
  
  initialize: () ->
    @options.eventer.bind("update_table", @update_buttons)
    @options.buttons.bind('reset', @render)

  addAll: () =>
    @options.buttons.each(@addOne)

  addOne: (button) =>
    view = new RailsBackboneDurak.Views.Buttons.Button({model : button, eventer: @options.eventer})
    $(@el).append(view.render().el)

  render: =>
    $(@el).html("")
    $(@el).attr("id", "buttons")
    @addAll()
    return this
  
  update_buttons: =>
    @options.buttons.fetch()