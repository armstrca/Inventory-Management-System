#/workspaces/Inventory-Management-System/config/initializers/appdev_support.rb
#/workspaces/Inventory-Management-System/config/initializers/appdev_support.rb
AppdevSupport.config do |config|
  config.action_dispatch = true
  config.active_record   = true
  config.pryrc           = :minimal
end

AppdevSupport.init
