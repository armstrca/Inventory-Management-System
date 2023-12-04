# To Do
-----------------------------------------------------------------------
IMPORTANT
-----------------------------------------------------------------------

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
    Suppliers
    Possible integration of hypothetical supplier_shipments table
-----------------------------------------------------------------------


Post-deployment thoughts:

DataTables for Suppliers#index and Users#index do not match styling for those of Products and Orders
  - That's because they render from smaller tables, so DataTables client-side pagination ain't so bad



Styling/formatting/nifty features for orders tables
Make table visuals consistent across app (Products)
  - paging refinement for categories/subcategories?


Mobile responsiveness
Table margins!!!
