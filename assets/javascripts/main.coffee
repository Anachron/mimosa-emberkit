require
  urlArgs: "b=#{(new Date()).getTime()}"
  paths:
    jquery: 'vendor/jquery/2.0.3/jquery'
  , ['app/example-view']
  , (ExampleView) ->
    view = new ExampleView()
    view.render('body')