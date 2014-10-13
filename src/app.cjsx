$ = require 'jquery'
_ = require 'underscore'
Backbone = require("backbone")
React = require("react")
LifeView = require './lifeview.cjsx'
LifeBackbone = require './lifebackbone.coffee'

Backbone.$ = $

WelcomePage = React.createClass(
  render: ->
    <span className="MyComponent">
      <p>Welcome to the Conways Game of Life showdown between React and Backbone.
      <br/>Click <a href="#react">here for React</a> and <a href="#backbone">here for backbone.</a>
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
      <LifeView />,
      document.getElementById('content')
      )

  backbone: ->
    console.log "backbone"
    $(document).attr('title', 'backbone-of-life')
    lifebackbone = new LifeBackbone()



new Router()


Backbone.history.start()