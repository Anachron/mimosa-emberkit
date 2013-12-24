express = require 'express'
engines = require 'consolidate'

exports.startServer = (config, callback) ->

  port = process.env.PORT or config.server.port

  app = express()
  server = app.listen port, ->
    console.log "Express server listening on port %d in %s mode", server.address().port, app.settings.env

  app.configure ->
    app.set 'port', port
    app.set 'views', config.server.views.path
    app.locals.basedir = config.server.views.path
    app.engine config.server.views.extension, engines[config.server.views.compileWith]
    app.set 'view engine', config.server.views.extension
    app.use express.favicon()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.compress()
    app.use config.server.base, app.router
    app.use express.static(config.watch.compiledDir)

  app.configure 'development', ->
    app.use express.errorHandler()

  options =
    reload:    config.liveReload.enabled
    optimize:  config.isOptimize ? false
    cachebust: if process.env.NODE_ENV isnt "production" then "?b=#{(new Date()).getTime()}" else ''

  app.get '/', (req, res) ->
    options.page = 'index'
    options.appType = false
    res.render options.page, options

  app.get '/todos', (req, res) ->
    options.page = 'todos'
    options.appType = 'todos'
    res.render options.page, options

  app.get '/:page', (req, res) ->
    options.page = req.params.page
    options.appType = false
    res.render options.page, options

  callback(server)
