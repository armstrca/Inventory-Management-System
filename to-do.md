# To Do
-----------------------------------------------------------------------
IMPORTANT
-----------------------------------------------------------------------

-----------------------------------------------------------------------
    ######### Inventory_transaction stuff
-----------------------------------------------------------------------

  Returns?
  Refunds?
  Figure it out
  Join table with products/orders
  Error handling
  An inventory transaction would include incoming orders from suppliers, outgoing orders to customers, return/refund orders from customers
  
  Orders should calculate the total cost of the products in the order

-----------------------------------------------------------------------
    ######### Storage_location stuff
-----------------------------------------------------------------------

  Join table with products?
  Products#show should show where each batch of products is stored & how many are in each location
  Allow CRUD of storage_location

-----------------------------------------------------------------------

-----------------------------------------------------------------------

    ######### Miscellaneous
-----------------------------------------------------------------------

    Need controllers/routes for this stuff:
    Login/404/Register/Forgot password stuff
    Error handling for new orders, new suppliers, new categories, fix existing error handling for new products, inventory_transactions
    New join table...supplier_shipments?


-----------------------------------------------------------------------
-----------------------------------------------------------------------

LESS IMPORTANT
-----------------------------------------------------------------------

    -----------------------------------------------------------------------

    -----------------------------------------------------------------------

    ######### Categories
      Fix title header for Categories#show so they display on one line, maybe switch all such headers to h2 or smaller
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------

    ######### Orders
      Orders#show table font/display, linkiness and orders#index
      Orders#show buttons
      Require at least one product for each order
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------

    ######### Suppliers
    Think about suppliers#show layout, possible integration of hypothetical supplier_shipments table
-----------------------------------------------------------------------


Orders#index is just so dang slow what the heck
  okay look into making the datatable one of those ones that only loads one a new page within the table
