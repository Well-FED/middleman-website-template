set :env, ENV['APP_ENV'] || 'development'
activate :dotenv, env: ".env.#{ENV['APP_ENV'] || 'development'}"

# Configuration
# =================================================================================

# Dependencies
# See ./helpers

# Path settings
set :css_dir, 'css'
set :fonts_dir, 'fonts'
set :images_dir, 'img'
set :js_dir, 'js'

activate :directory_indexes
activate :relative_assets
set :relative_links, true

# Layout settings
# =================================================================================

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Server config (Development by default)
# =================================================================================

configure :server {

  activate :external_pipeline,
    name: :webpack,
    command: 'npm run webpack:server',
    source: '.tmp/dist',
    latency: 1

  activate :livereload,
    no_swf: true,
    livereload_css_target: 'css/style.main.css'

}

# Build config (Production by default)
# =================================================================================

configure :build {

  ignore '**/.keep'
  ignore 'templates/*'
  ignore '**/style.*.js'
  ignore '**/style.*.js.*'

  activate :external_pipeline,
    name: :webpack,
    command: 'npm run webpack:build',
    source: '.tmp/dist',
    latency: 1

  if data.site.make_icons == true
  # activate :favicon_maker do |f|
  #   # Requires ImageMagick. `brew install ImageMagick`
  #   f.template_dir  = 'image_assets'
  #   f.output_dir  = 'source'
  #   f.icons = {
  #     'touch-icon-512x512.png' => [
  #       { icon: "touch-icon-512x512.png", size: "512x512" },
  #       { icon: "mstile-310x310.png",     size: "310x310" }
  #     ],
  #     'touch-icon-256x256.png' => [
  #       { icon: "touch-icon-256x256.png",                   size: "256x256" },
  #       { icon: "touch-icon-192x192.png",                   size: "192x192" },
  #       { icon: "apple-touch-icon-180x180-precomposed.png", size: "180x180" },
  #       { icon: "apple-touch-icon-precomposed.png",         size: "180x180" },
  #       { icon: "apple-touch-icon-152x152-precomposed.png", size: "152x152" },
  #       { icon: "mstile-150x150.png",                       size: "150x150" },
  #       { icon: "apple-touch-icon-144x144-precomposed.png", size: "144x144" },
  #       { icon: "apple-touch-icon-120x120-precomposed.png", size: "120x120" },
  #       { icon: "apple-touch-icon-114x114-precomposed.png", size: "114x114" }
  #     ],
  #     'touch-icon-96x96.png' => [
  #       { icon: "touch-icon-96x96.png",                   size: "96x96" },
  #       { icon: "apple-touch-icon-76x76-precomposed.png", size: "76x76" },
  #       { icon: "apple-touch-icon-72x72-precomposed.png", size: "72x72" },
  #       { icon: "mstile-70x70.png",                       size: "70x70" },
  #       { icon: "apple-touch-icon.png",                   size: "57x57" }
  #     ]
  #   }
  # end
  end

  activate :asset_hash, ignore: %w[
    opengraph.*
    opengraph*.*
    *touch-icon*.*
    *ms-tile*.*
    service-worker.js
    *.xml
    *.txt
    *.json
    favicon.ico
    *.woff
    *.woff2
  ]

  activate :minify_css

  activate :minify_html do |html|
    html.remove_http_protocol    = false
    html.remove_input_attributes = false
    html.remove_quotes           = true
    html.remove_intertag_spaces  = true
  end

  activate :gzip do |gzip|
    gzip.exts = %w[.js .css .html .htm .svg .xml .ico .map .json]
  end

}

# configure :deploy {

# }
