$ = require 'jquery'
_ = require 'underscore'
Backbone = require("backbone")
LifeStore = require './life.coffee'
Handlebars = require 'handlebars'

Backbone.$ = $

console.log 'Handlebars'
console.log Handlebars
window.Handlebars = Handlebars

LifeCell = Backbone.View.extend
    className: 'cell alive-false'
    initialize: (first) ->
        model = new Backbone.Model
          alive: false
        @model = model

        if first
            @$el.addClass 'cell-first'
        this.listenTo model, 'change:alive', (alive) ->
            @$el.toggleClass('alive-true', alive)
            @$el.toggleClass('alive-false', !alive)

LifeBackbone = Backbone.View.extend 
    el: '#content'

    initialize: () ->
        @x = 100
        @y = 100

        LifeStore.config
          x: @x
          y: @y

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

        @board = []

        for i in [0..@x - 1]
            @board[i] = []
            for j in [0..@y - 1]
                cell = @board[i][j] = new LifeCell
                if j is 0
                    cell.$el.addClass('cell-first')
                @$el.append(cell.el)

    _onChange: () ->
        @state = LifeStore.getState()
        for i in [0..@x - 1]
            for j in [0..@y - 1]
                @board[i][j].model.set 'alive', @state.board[i][j]


module.exports = LifeBackbone
