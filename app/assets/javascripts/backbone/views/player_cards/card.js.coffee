RailsBackboneDurak.Views.PlayerCards ||= {}

class RailsBackboneDurak.Views.PlayerCards.Card extends Backbone.View
  events:
    "click .playable" : "play_card"
  
  render: ->
    if @model.get("playable")
      state = "playable"
      $(@el).css("cursor","pointer");
    else
      state = "disabled"
    if @model.get("size") > 6
      width = Math.round(680/@model.get("size"))
      $(@el).css("width", width)
    $(@el).attr("class", "card")
    $(@el).append("<div class='#{state} #{@model.get("card_class")}'></div>")
    return this

  play_card: ->
    @model.destroy({success: @update_table_callback})
    this.remove()
    return false
  
  update_table_callback: =>
    @options.eventer.trigger("update_table")
    @options.eventer.trigger("update_message")