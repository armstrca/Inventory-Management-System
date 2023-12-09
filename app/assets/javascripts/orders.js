  $(document).ready(function () {
    var ordersTable = $('#ordersTable').DataTable({
    processing: true,
  serverSide: true,
  paging: true,
  autowidth: true,
  ordering: true,
  searching: true,
  lengthChange: true,
  autoFill: true,
  lengthMenu: [5, 10, 25, 50, 100],
  ajax: {
    url: '<%= orders_index_path(format: :json) %>',
  type: 'GET',
  dataType: 'json',
  data: function (d) {
    // Add additional parameters if needed
    // Example: d.custom_param = 'value';
  }
      },

  columns: [
  {data: 'id' },
  {data: 'expected_delivery' },
  {data: 'status' },
  {data: 'sending_address' },
  {data: 'receiving_address' },
  {data: 'description' },
  {data: 'product_id' },
  {data: 'quantity_ordered' },
  {data: 'shipping_cost' },
  {data: 'order_total' }
  // Add more columns as needed
  ],
  columnDefs: [
  {
    targets: [3, 4], // Column indices (0-based) for sending_address and receiving_address
  render: function (data, type, row, meta) {
            // 'display' type will only affect the display and not sorting or filtering
            if (type === 'display') {
              return '<span style="font-size: 12px;">' + data + '</span>';
            }
  return data;
          },
        },
  {
    targets: [9, 8], // Column index (0-based) for the 'Total' column
  render: function (data, type, row, meta) {
            // 'display' type will only affect the display and not sorting or filtering
            if (type === 'display') {
              return '$' + data;
            }
  return data;
          },
        },
  // Add more columnDefs as needed
  ],
  language: {
    searchPlaceholder: "Search...", // Set a placeholder for the search input
      },
    });

  var incomingTable = $('#incomingTable').DataTable({
    processing: true,
  serverSide: true,
  paging: true,
  autowidth: true,
  ordering: true,
  searching: true,
  lengthChange: true,
  lengthMenu: [5, 10, 25, 50, 100],
  ajax: {
    url: '<%= incoming_orders_path(format: :json) %>',
  type: 'GET',
  dataType: 'json',
  data: function (d) {
    // Add additional parameters if needed
    // Example: d.custom_param = 'value';
  }
      },
  columns: [
  {data: 'id' },
  {data: 'expected_delivery' },
  {data: 'status' },
  {data: 'sending_address' },
  {data: 'receiving_address' },
  {data: 'description' },
  {data: 'product_id' },
  {data: 'quantity_ordered' },
  {data: 'shipping_cost' },
  {data: 'order_total' }
  // Add more columns as needed
  ],
  columnDefs: [
  {
    targets: [3, 4], // Column indices (0-based) for sending_address and receiving_address
  render: function (data, type, row, meta) {
            // 'display' type will only affect the display and not sorting or filtering
            if (type === 'display') {
              return '<span style="font-size: 12px;">' + data + '</span>';
            }
  return data;
          },
        },
  {
    targets: [9, 8], // Column index (0-based) for the 'Total' column
  render: function (data, type, row, meta) {
            // 'display' type will only affect the display and not sorting or filtering
            if (type === 'display') {
              return '$' + data;
            }
  return data;
          },
        },
  // Add more columnDefs as needed
  ],
  language: {
    searchPlaceholder: "Search...", // Set a placeholder for the search input
      },
    });

  var outgoingTable = $('#outgoingTable').DataTable({
    processing: true,
  serverSide: true,
  paging: true,
  autowidth: true,
  ordering: true,
  searching: true,
  lengthChange: true,
  lengthMenu: [5, 10, 25, 50, 100],
  ajax: {
    url: '<%= outgoing_orders_path(format: :json) %>',
  type: 'GET',
  dataType: 'json',
  data: function (d) {
    // Add additional parameters if needed
    // Example: d.custom_param = 'value';
  }
      },
  columns: [
  {data: 'id' },
  {data: 'expected_delivery' },
  {data: 'status' },
  {data: 'sending_address' },
  {data: 'receiving_address' },
  {data: 'description' },
  {data: 'product_id' },
  {data: 'quantity_ordered' },
  {data: 'shipping_cost' },
  {data: 'order_total' },
  // Add more columns as needed
  ],
  columnDefs: [
  {
    targets: [3, 4], // Column indices (0-based) for sending_address and receiving_address
  render: function (data, type, row, meta) {
            // 'display' type will only affect the display and not sorting or filtering
            if (type === 'display') {
              return '<span style="font-size: 12px;">' + data + '</span>';
            }
  return data;
          },
        },
  {
    targets: [9, 8], // Column index (0-based) for the 'Total' column
  render: function (data, type, row, meta) {
            // 'display' type will only affect the display and not sorting or filtering
            if (type === 'display') {
              return '$' + data;
            }
  return data;
          },
        },
  {
    targets: 8, // Column index (0-based) for the 'shipping' column
  render: function (data, type, row, meta) {
            // 'display' type will only affect the display and not sorting or filtering
            if (type === 'display') {
              return '$' + parseFloat(data).toFixed(2);
            }
  return data;
          },
        },
  ],
  language: {
    searchPlaceholder: "Search...", // Set a placeholder for the search input
      },
    });
  $('#ordersTable tbody').on('click', 'tr', function() {
       var data = ordersTable.row(this).data();
  console.log(data); // This will log the data object to the console.
  window.location.href = '/orders/' + data.id;
   });

  $('#incomingTable tbody').on('click', 'tr', function() {
        var data = incomingTable.row(this).data();
  window.location.href = '/orders/' + data.id;
    });

  $('#outgoingTable tbody').on('click', 'tr', function() {
        var data = outgoingTable.row(this).data();
  window.location.href = '/orders/' + data.id;
    });
  });
