///workspaces/Inventory-Management-System/app/assets/javascripts/sidebar-toggle.js
// sidebar-toggle.js
$(document).ready(function () {
  function updateContentPadding() {
    var sidebarWidth = $('.sidebar').width();
    $('#content-wrapper').css('padding-left', sidebarWidth + 'px');
  }

  function toggleSidebar() {
    var viewportWidth = $(window).width();
    var sidebar = $('.sidebar');

    if (viewportWidth <= 1668 && !sidebar.hasClass('toggled')) {
      sidebar.addClass('toggled');
    } else if (viewportWidth > 1668 && sidebar.hasClass('toggled')) {
      sidebar.removeClass('toggled');
    }

    // Update content padding when sidebar is toggled
    updateContentPadding();
  }

  // Initial toggle check
  toggleSidebar();

  // Toggle sidebar on window resize
  $(window).resize(function () {
    toggleSidebar();
  });

  // You can also toggle the sidebar when a button is clicked or some other event occurs.
  $('#toggleSidebarButton').on('click', function () {
    $('.sidebar').toggleClass('toggled');
    $('#content').toggleClass('with-sidebar'); // Add or remove the class based on the sidebar state
    // Update content padding when sidebar is toggled by button click
    updateContentPadding();
  });
});
