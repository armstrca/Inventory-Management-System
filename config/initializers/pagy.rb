# Optionally override some pagy default with your own in the pagy initializer
Pagy::DEFAULT[:items] = 10        # items per page
Pagy::DEFAULT[:size]  = [1,2,2,1] # nav bar links
# Better user experience handled automatically
require 'pagy/extras/overflow'
# Pagy::DEFAULT[:overflow] = :last_page
Rails.application.config.assets.paths << Pagy.root.join('javascripts')
require 'pagy/extras/bootstrap'
require 'pagy/extras/bulma'
require 'pagy/extras/foundation'
require 'pagy/extras/materialize'
require 'pagy/extras/navs'
require 'pagy/extras/semantic'
require 'pagy/extras/uikit'
require 'pagy/extras/items' # works without further configuration
# Pagy::VARS[:items_extra] = true
