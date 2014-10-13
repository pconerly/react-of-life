
React = require 'react'
LifeStore = require './life.coffee'


LifeStore.config
  x: 100
  y: 100

LifeStore.seed([
  # [2,2],
  # [2,3],
  # [2,4],
  # [4,3],
  # [4,4],
  # [5,3],
  # [5,4],
  # [7,5],
  # [7,4],
  # [4,7],

  # R-pentomino
  # [50, 49]
  # [51, 49]
  # [50, 50]
  # [50, 51]
  # [49, 50]

  # acorn
  [40, 40]
  [42, 41]
  [39, 42]
  [40, 42]
  [43, 42]
  [44, 42]
  [45, 42]

  ])


getLifeState = ->
  return {
    board: LifeStore.getState()
  }

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
    # return <span className="LifeView">Hello, react life view!</span>
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
