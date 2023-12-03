# To Do
-----------------------------------------------------------------------
IMPORTANT
-----------------------------------------------------------------------

----Inventory_transaction stuff
-----------------------------------------------------------------------

  Returns?
  Refunds?
  Figure it out
  Join table with products/orders
  Error handling
  An inventory transaction would include incoming orders from suppliers, outgoing orders to customers, return/refund orders from customers
  
  Orders should calculate the total cost of the products in the order

----Storage_location stuff
-----------------------------------------------------------------------

  Join table with products?
  Products#show should show where each batch of products is stored & how many are in each location
  Allow CRUD of storage_location

-----------------------------------------------------------------------
-----------------------------------------------------------------------

    Miscellaneous
-----------------------------------------------------------------------

    Need controllers/routes for this stuff:
    Error handling for new orders, new suppliers, new categories, fix existing error handling for new products, inventory_transactions
    New join table...supplier_shipments?


-----------------------------------------------------------------------
-----------------------------------------------------------------------

LESS IMPORTANT
-----------------------------------------------------------------------


    -----------------------------------------------------------------------

    Orders
      Orders#show table font/display, linkiness and orders#index
      Require at least one product for each order
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------

    Suppliers
    Possible integration of hypothetical supplier_shipments table
-----------------------------------------------------------------------


Post-deployment thoughts:

DataTables for Suppliers#index and Users#index do not match styling for those of Products and Orders
  - That's because they render from smaller tables, so DataTables client-side pagination ain't so bad

Ostensibly DataTables is supposed to be able to do server-side pagination, but I have yet to see any proof of this in my app

New orders need to require products be in them and specify how many of each product
  - any time a product is added to an order its stock_quantity should be updated accordingly

Inventory transactions really are eventually necessary because a business would need to handle returns/refunds, and maybe even lost/destroyed stock





