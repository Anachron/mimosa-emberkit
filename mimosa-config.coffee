# All of the below are mimosa defaults and only need to be uncommented in the event you want
# to override them.
#
# IMPORTANT: Be sure to comment out all of the nodes from the base to the option you want to
# override. If you want to turn change the source directory you would need to uncomment watch
# and sourceDir. Also be sure to respect coffeescript indentation rules.  2 spaces per level
# please!

exports.config = {
  modules: ['jshint', 'csslint', 'server', 'require', 'minify-js', 'minify-css', 'live-reload', 'bower', 'server-reload']
  serverReload:
    watch: ["server.coffee", "views", "routes"]
}