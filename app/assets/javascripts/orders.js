///workspaces/Inventory-Management-System/app/assets/javascripts/orders.js
// orders.js

jQuery(document).ready(function() {
  $('#orders-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": {
      "url": $('#orders-datatable').data('source')
    },
    "pagingType": "full_numbers",
    "columns": [
      {"data": "id"},
      {"data": "expected_delivery"},
      {"data": "status"},
      {"data": "receiving_address"},
      {"data": "sending_address"},
      {"data": "description"},
      {
        "data": "products",
        "render": function(data, type, row) {
          if (type === 'display' && data && Array.isArray(data)) {
            return data.map(function(product) {
              return product.id;
            }).join(', ');
          }
          return '';
        }
      },
      {
        "data": null,
        "render": function(data, type, row) {
          if (type === 'display' && row.order_products) {
            return row.order_products.reduce(function(sum, orderProduct) {
              return sum + orderProduct.quantity_ordered;
            }, 0);
          }
          return '';
        }
      },
      {
        "data": null,
        "render": function(data, type, row) {
          if (type === 'display' && row.order_products) {
            return '$' + row.order_products.reduce(function(sum, orderProduct) {
              return sum + orderProduct.shipping_cost;
            }, 0).toFixed(2);
          }
          return '';
        }
      }
    ]
  });
});

// pagingType is optional, if you want full pagination controls.
// Check dataTables documentation to learn more about
// available options.
