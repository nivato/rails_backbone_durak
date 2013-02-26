RailsBackboneDurak.Views.Buttons ||= {}

class RailsBackboneDurak.Views.Buttons.Button extends Backbone.View

  tagName: "a"
  
  events:
    "click #next"           : "end_of_turn"
    "click #take_cards"     : "end_of_turn"
    "click #new_game"       : "end_of_game"

  render: ->
    if @model.get("next")
      $(@el).css("cursor","pointer");
      $(@el).append("<div class='button-black' id='next' onmousedown=\"this.className='button-red';\" onmouseup=\"this.className='button-black';\">Next</div>")
    if @model.get("take_cards")
      $(@el).css("cursor","pointer");
      $(@el).append("<div class='button-black' id='take_cards' onmousedown=\"this.className='button-red';\" onmouseup=\"this.className='button-black';\">Take Cards</div>")
    if @model.get("new_game")
      $(@el).css("cursor","pointer");
      $(@el).append("<div class='button-black' id='new_game' onmousedown=\"this.className='button-red';\" onmouseup=\"this.className='button-black';\">New Game</div>")
    return this
  
  end_of_turn: =>
    @model.destroy({success: @end_of_turn_callback})
    _.delay(@remove_me, 1000)
    return false
  
  remove_me: =>
    this.remove()
  
  end_of_game: =>
    @model.destroy({success: @end_of_game_callback})
    this.remove()
    return false
  
  end_of_turn_callback: =>
    @options.eventer.trigger("update_table")
    @options.eventer.trigger("update_deck")
    @options.eventer.trigger("update_message")
    
  end_of_game_callback: =>
    @options.eventer.trigger("update_table")
    @options.eventer.trigger("update_deck")
    @options.eventer.trigger("update_trump")
    @options.eventer.trigger("update_message")
