Polymer

  is: 'grapp-websocket-rails-subscribe'

  properties:
    channel: {type: String}
    websocket: {type: Object, observer: '_websocketChanged'}

  _websocketChanged: ->
    channel = @websocket.subscribe @channel
    bindEvent = (channel, event, elem) ->
      channel.bind event, (data) -> elem.fire 'data', data
    for bind in Polymer.dom(@).querySelectorAll 'grapp-websocket-rails-bind'
      bindEvent channel, bind.event, bind
