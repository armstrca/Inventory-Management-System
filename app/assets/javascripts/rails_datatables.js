///workspaces/Inventory-Management-System/app/assets/javascripts/rails_datatables.js
var root = typeof exports !== 'undefined' ? exports : this;

root.railsDatatables = function (sSource, aoData, fnCallback) {
  var columns = [];
  var searchcolumns = [];
  var sortcolumns = [];

  var sEcho = 1;
  var sSearch = '';
  var bRegex = false;
  var iDisplayStart = 0;
  var iDisplayLength = 0;
  var data = [];

  aoData.forEach(function (dataObj) {
    switch (dataObj.name) {
      case 'sColumns':
        columns = dataObj.value.split(',');
        break;
      case 'sEcho':
        sEcho = dataObj.value;
        break;
      case 'sSearch':
        sSearch = dataObj.value;
        break;
      case 'bRegex':
        bRegex = dataObj.value;
        break;
      case 'iDisplayStart':
        iDisplayStart = dataObj.value;
        break;
      case 'iDisplayLength':
        iDisplayLength = dataObj.value;
        break;
      case 'iSortCol_0':
        console.log('yobanarot!');
        iSortCol = dataObj.value;
        break;
      case 'sSortDir_0':
        sSortDir = dataObj.value;
        break;
      default:
        break;
    }
  });

  aoData.forEach(function (dataObj) {
    var search_regexp = /sSearch_([0-9]+)/;
    if ((col = dataObj.name.match(search_regexp)) && dataObj.value) {
      var search_method = columns[col[1]].split('--');
      data.push({ name: 'search[' + search_method[0] + '_' + search_method[1] + ']', value: dataObj.value });
    }

    var searchable_regexp = /bSearchable_([0-9]+)/;
    if ((col = dataObj.name.match(searchable_regexp)) && dataObj.value) {
      var search_method = columns[col[1]].split('--');
      searchcolumns.push(search_method[0]);
    }

    var sortcol_regexp = /iSortCol_([0-9]+)/;
    if ((col = dataObj.name.match(sortcol_regexp))) {
      var sort_method = columns[parseInt(dataObj.value)].split('--');
      sortcolumns[parseInt(col[1])] = sort_method[0];
    }

    var sortdir_regexp = /sSortDir_([0-9]+)/;
    if ((col = dataObj.name.match(sortdir_regexp)) && dataObj.value) {
      sortcolumns[col[1]] = sortcolumns[col[1]] + '.' + dataObj.value;
    }
  });

  data.push({ name: 'sEcho', value: sEcho });
  data.push({ name: 'page', value: iDisplayStart / iDisplayLength + 1 });
  data.push({ name: 'per_page', value: iDisplayLength });
  data.push({ name: 'search[meta_sort]', value: sortcolumns[0] });

  columns.forEach(function (val, index) {
    data.push({ name: 'columns[' + index + ']', value: val });
  });

  if (sSearch) {
    var op = bRegex ? '_contains' : '_sw';
    data.push({ name: 'search[' + searchcolumns.join('_or_') + op + ']', value: sSearch });
  }

  $.ajax({
    dataType: 'json',
    type: 'GET',
    url: sSource,
    data: data,
    success: fnCallback,
  });
};
