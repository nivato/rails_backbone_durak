RailsBackboneDurak.EventAggregators ||= {}
class RailsBackboneDurak.EventAggregators.Eventer
  constructor: ->
    _.extend(this, Backbone.Events)