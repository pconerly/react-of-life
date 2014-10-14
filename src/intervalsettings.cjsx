
React = require 'react'
LifeStore = require './life.coffee'


getLifeState = ->
  return LifeStore.getState()


IntervalSettings = React.createClass(

  getInitialState: =>
    return getLifeState()

  componentDidMount: () ->
    LifeStore.addChangeListener(@_onChange)

  componentWillUnmount: () ->
    LifeStore.removeChangeListener(@_onChange)

  _onChange: () ->
    # set time since last tick here?
    @setState getLifeState()

  intervalChange: (e) ->
    LifeStore.updateInterval e.target.value

  render: ->
    <div className="settings">
      <div>
        <span>Time since last tick: {this.state.timeSinceLastTick}  </span>
        <label>Interval speed</label>
        <input type="text" name="interval" 
          className="intervalSpeed" 
          value={this.state.interval}
          onChange={this.intervalChange} />
      </div>
    </div>

)


module.exports = IntervalSettings
