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
        'pass'
        _.bind(@_onChange, @)
        LifeStore.addChangeListener(@sillyRender)

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
        # @$('div')
        # 'hmmmm'
        source = $('#LifeTemplate').html()
        template = Handlebars.compile(source)
        html = template(@board.toJSON())
        @$el.html(html)

    _onChange: () ->
        # @setState getLifeState()
        # console.log "LifeBackbone: _onChange"
        @board = LifeStore.getState()
        @render()

    sillyRender: () ->
        # console.log "silly render"
        $container = $('#content')
        board = {
            board: LifeStore.getState()
        }
        source = $('#LifeTemplate').html()
        template = Handlebars.compile(source)
        html = template(board)
        # console.log html
        $container.html(html)






module.exports = LifeBackbone
