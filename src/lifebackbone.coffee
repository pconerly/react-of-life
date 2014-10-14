$ = require 'jquery'
_ = require 'underscore'
Backbone = require("backbone")
LifeStore = require './life.coffee'
Handlebars = require 'handlebars'

Backbone.$ = $

console.log 'Handlebars'
console.log Handlebars
window.Handlebars = Handlebars

LifeBackbone = Backbone.View.extend 
    el: '#content'

    initialize: () ->
        source = $('#LifeTemplate').html()
        @template = Handlebars.compile(source)

        LifeStore.config
          x: 100
          y: 100

        LifeStore.seed([
          # acorn
          [40, 40]
          [42, 41]
          [39, 42]
          [40, 42]
          [43, 42]
          [44, 42]
          [45, 42]
          ])

        LifeStore.start()


    render: ->
        html = @template(@state)
        @$el.html(html)

    _onChange: () ->
        @state = LifeStore.getState()
        @render()


module.exports = LifeBackbone
