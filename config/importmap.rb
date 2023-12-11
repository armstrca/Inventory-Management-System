#/workspaces/Inventory-Management-System/config/importmap.rb
# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jszip", to: "/workspaces/Inventory-Management-System/node_modules/jszip/dist/jszip.js"
pin "pdfmake", to: "/workspaces/Inventory-Management-System/node_modules/pdfmake/build/pdfmake.js"
pin "datatables.net-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-dt/js/jquery.dataTables.js"
pin "datatables.net-autofill-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-autofill-dt/js/autoFill.dataTables.js"
pin "datatables.net-buttons-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-buttons-dt/js/buttons.dataTables.js"
pin "datatables.net-colreorder-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-colreorder-dt/js/colReorder.dataTables.js"
pin "datatables.net-datetime", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-datetime/js/dataTables.dateTime.js"
pin "datatables.net-fixedcolumns-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-fixedcolumns-dt/js/fixedColumns.dataTables.js"
pin "datatables.net-fixedheader-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-fixedheader-dt/js/fixedHeader.dataTables.js"
pin "datatables.net-keytable-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-keytable-dt/js/keyTable.dataTables.js"
pin "datatables.net-responsive-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-responsive-dt/js/responsive.dataTables.js"
pin "datatables.net-scroller-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-scroller-dt/js/scroller.dataTables.js"
pin "datatables.net-searchbuilder-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-searchbuilder-dt/js/searchBuilder.dataTables.js"
pin "datatables.net-searchpanes-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-searchpanes-dt/js/searchPanes.dataTables.js"
pin "datatables.net-select-dt", to: "/workspaces/Inventory-Management-System/node_modules/datatables.net-select-dt/js/select.dataTables.js"

# ... include paths for other DataTables extensions
