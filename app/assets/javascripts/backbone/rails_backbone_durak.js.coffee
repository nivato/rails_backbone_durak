#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers
#= require_tree ./event_aggregators

window.RailsBackboneDurak =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
    new RailsBackboneDurak.Routers.GameRouter
    Backbone.history.start()

$(document).ready ->
  RailsBackboneDurak.init()