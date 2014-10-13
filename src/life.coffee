_ = require 'underscore'
EventEmitter = require('events').EventEmitter
merge = require('react/lib/merge')

_life = 
    board: null
    step: 0
    config:
        x: 0
        y: 0
        wallEdges: true
        interval: 500 # half second

window._life = _life

console.log merge
console.log EventEmitter

CHANGE_EVENT = 'changederp'

outer_iterate = ->
    LifeStore.iterate()


LifeStore = merge(EventEmitter::, 

    config: (config) ->
        _life.config = _.extend _life.config, config

    seed: (startPositions) ->
        if _life.board is null
            _life.board = @makeBoard()
        if startPositions
            for pos in startPositions
                # console.log "x: #{pos[0]}, y: #{pos[1]}"
                _life.board[pos[0]][pos[1]] = true

    makeBoard: ->
        board = ((false for j in [0.._life.config.y-1]) for i in [0.._life.config.x-1])
        # console.log "makeboard"
        # console.log board
        return board


    start: () ->
        @iterate()

    iterate: ->
        # console.log "interval #{_life.step}"
        setTimeout outer_iterate, _life.config.interval
        @updateBoard()

    getState: ->
        return _life.board

    updateBoard: ->
        newBoard = @makeBoard()
        for x in [0.._life.board.length-1]
            for y in [0.._life.board[0].length-1]
                newBoard[x][y] = @checkCell(x, y)

        _.extend _life, {
            board: newBoard
            step: _life.step+1
        }
        @emitChange()


    checkCell: (x, y) ->
        neighbors = 0
        for x_offset in [x-1, x, x+1]
            if (x_offset) < 0 or (x_offset) >= _life.config.x
                'continue'
            else
                for y_offset in [y-1, y, y+1]
                    if (y_offset) < 0 or (y_offset) >= _life.config.y
                        'continue'
                    else
                        unless x_offset == x and y_offset == y
                            if _life.board[x_offset][y_offset]
                                neighbors += 1


        if neighbors <= 1
            return false
        else if neighbors == 2 and _life.board[x][y]
            return true
        else if neighbors == 3
            return true
        else # 4 or more
            return false

    emitChange: () ->
        @emit CHANGE_EVENT

    ###*
    @param {function} callback
    ###
    addChangeListener: (callback) ->
        @on CHANGE_EVENT, callback
        return

    ###*
    @param {function} callback
    ###
    removeChangeListener: (callback) ->
        @removeListener CHANGE_EVENT, callback
        return

)

module.exports = LifeStore
