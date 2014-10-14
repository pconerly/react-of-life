$ = require 'jquery'
_ = require 'underscore'
Backbone = require("backbone")
React = require("react")
IntervalSettings = require './intervalsettings.cjsx'
LifeView = require './lifeview.cjsx'
LifeBackbone = require './lifebackbone.coffee'
LifeStore = require './life.coffee'

Backbone.$ = $

WelcomePage = React.createClass(
  render: ->
    <span className="MyComponent">
      <p>Welcome to the Conways Game of Life showdown between React and Backbone.
      <br/>Click <a href="#react">here for React</a> and <a href="#backbone">here for backbone.</a>
      <br/>You should open each of these in new windows.
      </p>
    </span>
)


Router = Backbone.Router.extend 
  routes:
    "": "index"
    "react": "react"
    "backbone": "backbone"

  index: ->
    console.log "index"
    React.renderComponent(
      <WelcomePage />,
      document.getElementById('content')
      )

  react: ->
    console.log "react"
    $(document).attr('title', 'react-of-life')
    React.renderComponent(
      <IntervalSettings />,
      document.getElementById('admin')
      )
    React.renderComponent(
      <LifeView />,
      document.getElementById('content')
      )

  backbone: ->
    console.log "backbone"
    React.renderComponent(
      <IntervalSettings />,
      document.getElementById('admin')
      )
    $(document).attr('title', 'backbone-of-life')
    lifebackbone = new LifeBackbone()

    outer_onchange = () ->
      lifebackbone._onChange()

    LifeStore.addChangeListener(outer_onchange)


new Router()
Backbone.history.start()
