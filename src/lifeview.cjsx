
React = require 'react'
LifeStore = require './life.coffee'


LifeStore.config
  x: 100
  y: 100

LifeStore.seed(LifeStore.R_PENTOMINO)


getLifeState = ->
  return LifeStore.getState()

LifeView = React.createClass(

  getInitialState: =>
    return getLifeState()

  componentDidMount: () ->
    LifeStore.addChangeListener(@_onChange)
    LifeStore.start()

  componentWillUnmount: () ->
    LifeStore.removeChangeListener(@_onChange)


  _onChange: () ->
    @setState getLifeState()

  render: ->
    cells = []
    key = 0
    for col in @state.board
      cells.push []
      for i in [0..col.length-1]
        className = "cell alive-#{col[i]} "
        if i == 0
          className += "cell-first" 

        cells[cells.length - 1].push <div key={key} className={className}></div>
        key += 1

    <div className="board">
      {cells}
    </div>

)


module.exports = LifeView
