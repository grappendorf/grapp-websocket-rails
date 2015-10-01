RECONNECT_DELAY_MILLIS = 10 * 1000

Polymer

  is: 'grapp-websocket-rails',

  properties:
    url: {type: String, observer: '_urlChanged'}
    websocket: {type: Object, value: (-> @), notify: true}
    dispatcher: {type: Object, notify: true}

  subscribe: (channel) ->
    @dispatcher.subscribe channel

  trigger: (event, data) ->
    @dispatcher.trigger event, data

  reconnect: ->
    @dispatcher.reconnect()
    @_installConnectionHandlers()

  _urlChanged: ->
    @_createConnection()

  _createConnection: ->
    @dispatcher = new WebSocketRails @url
    @_installConnectionHandlers()

  _installConnectionHandlers: ->
    @dispatcher._conn.on_close = (e) =>
      @async =>
        @reconnect()
      , null, RECONNECT_DELAY_MILLIS
