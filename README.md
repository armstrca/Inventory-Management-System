# Invy is an app that helps small retail companies keep track of shipping, product inventory, sales, and purchasing

Depending on their assigned roles, users have CRUD abilities for inventory products, orders, supplier profiles, category & subcategory management, and user profiles. Admins have full CRUD permissions, Managers have slightly fewer, and Staff have the least.

The app will eventually be able to accept barcode scanning inputs to further automate inventory management processes like sales, restocks, and audits.

More features to come:
- Ingestion of external transaction/shipping information
- Connectivity with Stripe payments
- Analytics for financial and inventory information, including restock alerts
- Specialization for perishable products - will alert you when food is about to expire/has already expired
- Possible automated tracking/notifications for recalled products

!Important!
- A note about orders#edit:
 'Delete' functionality will be added to the orders#edit page for individual order_products, but for now that should be done from the order#show page.
  If you intend to update the information for a pre-existing order_product, for now you should delete it from the #show view first, then re-add it with the correct information as a new order_product.
