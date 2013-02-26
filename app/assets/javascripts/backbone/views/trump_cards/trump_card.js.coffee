RailsBackboneDurak.Views.TrumpCards ||= {}

class RailsBackboneDurak.Views.TrumpCards.TrumpCard extends Backbone.View
  initialize: () ->
    @options.eventer.bind("update_trump", @update_trump)
    @options.trumpCards.bind('reset', @render)

  addAll: () =>
    @options.trumpCards.each(@addOne)

  addOne: (trumpCard) =>
    $(@el).append("<div class='trump card-#{trumpCard.get("rank") + trumpCard.get("suit_char")}'></div>")

  render: =>
    $(@el).html("")
    $(@el).attr("id", "trump-card")
    @addAll()
    return this
    
  update_trump: =>
    @options.trumpCards.fetch()