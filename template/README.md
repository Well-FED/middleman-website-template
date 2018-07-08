# Middleman Website Template

This static site generator template is written for Middleman. It contains [plenty of rich features every website should have](https://github.com/Well-FED/middleman-website-template/FEATURES.md), such as:

- Performance improvements
- Progressive Web App capabilities
- Opengraph configuration

## Installation

1. Clone this repo into a local directory
1. Change to your new local directory
1. `brew install ImageMagick` (Required for the `middleman-favicon-maker` gem)
1. `bundle install`
1. `npm i`
1. `middleman`

## Development

### Initialising site properties

Update `data/site.json` by supplying your own values for the name, description, etc.

### Updating assets

Create:

- `source/opengraph.jpg` At least 700x700 with a central bias. Larger preferred
- `image_assets/touch-icon-512x512.png` For large screens
- `image_assets/touch-icon-256x256.png` For medium screens
- `image_assets/touch-icon-96x96.png` For smaller screens

### Creating icons

1. Make sure you've created the 3 necessary touch-icons above.
1. Then edit `data/site.json` and set `make_icons` to `true`.
1. Uncomment the relevant lines in `config.rb`.
1. Finally, run `middleman build`

If you'd like to skip icon creation in subsequent builds, undo the steps above.

### Building

### Defining JS manifests

To create the link between Webpack bundles and Middleman's HTML, you need to define each manifest or entry as follows:

- Define the Webpack entries in `config/entries.js`
- Create corresonding `<script>` references in in `source/_layouts/layout.erb`

### Defining CSS manifests

- Define the Webpack entries in `config/entries.js`
- Create corresonding `<link>` references in in `source/_layouts/layout.erb`

## Build

### Doing environment-specific builds

All builds default to production mode

    middleman build

If you want a STAGING specific build use the following:

    APP_ENV=staging middleman build

## Building for STAGING:

    git checkout develop
    git pull origin develop
    APP_ENV=staging middleman build

## Building for PRODUCTION:

    git checkout master
    git pull origin master
    APP_ENV=production middleman build

## Deployment

### Deployment options

Try one of the following gems for deployment options:

- `middleman_gh-pages` for Github Pages deployments
- `middleman-s3_sync` for S3 deployments.

Follow up your deployment tasks with the following CDN and cache invalidation options:

- `middleman-cloudfront` for AWS-specific CDNs
- `middleman-cdn` for CloudFlare CDNs

