RailsBackboneDurak.Views.PlayerCards ||= {}

class RailsBackboneDurak.Views.PlayerCards.Card extends Backbone.View
  events:
    "click .playable" : "play_card"
  
  tagName: "a"
  
  render: ->
    if @model.get("playable")
      state = "playable"
      $(@el).css("cursor","pointer");
    else
      state = "disabled"
    $(@el).append("<img class='#{state} card-#{@model.get("rank") + @model.get("suit_char")}' />")
    return this

  play_card: ->
    @model.destroy({success: @update_table_callback})
    this.remove()
    return false
  
  update_table_callback: =>
    @options.eventer.trigger("update_table")
    @options.eventer.trigger("update_message")