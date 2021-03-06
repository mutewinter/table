sysPath = require 'path'

environment = process.env.BRUNCH_ENV ? 'development'

console.log "Running Brunch in #{environment} environment"

exports.config =
  paths:
    watched: ['app', 'test', 'vendor', 'config']
  files:
    javascripts:
      joinTo:
        'scripts/app.js':
          new RegExp("^(app|config/environments/#{environment}\.coffee)")
        'scripts/vendor.js':
          new RegExp("^(vendor/(scripts|ember/#{environment})|bower_components)")
      order:
        before: [
          'vendor/scripts/console-polyfill.js'
          'vendor/scripts/jquery.js'
          'vendor/scripts/handlebars.js'
          "vendor/scripts/moment.js"
          "vendor/scripts/ember_config.js"
          "vendor/ember/#{environment}/ember.js"
          "vendor/ember/#{environment}/ember-data.js"
          "vendor/ember/#{environment}/ember-model.js"
          # Anything else that depends on Ember
          "vendor/scripts/ember-inflector.js"
          "vendor/scripts/firebase.js"
          "vendor/scripts/fireplace.min.js"
          "vendor/scripts/firebase-simple-login.js"
          "bower_components/fastclick/lib/fastclick.js"
        ]

    stylesheets:
      joinTo:
        'styles/app.css': /^(app|vendor)/
      order:
        before: ['vendor/styles/normalize.css']

    templates:
      precompile: true
      root: 'templates'
      joinTo: 'scripts/app.js' : /^app/

  # allow _ prefixed templates so partials work
  conventions:
    ignored: (path) ->
      startsWith = (string, substring) ->
        string.indexOf(substring, 0) is 0
      sep = sysPath.sep
      if path.indexOf("app#{sep}templates#{sep}") is 0
        false
      else
        startsWith sysPath.basename(path), '_'

  overrides:
    production:
      optimize: true
      sourceMaps: false
      plugins: autoReload: enabled: false
