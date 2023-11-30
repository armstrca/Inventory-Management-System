///workspaces/Inventory-Management-System/app/assets/javascripts/sidebar-toggle.js
// sidebar-toggle.js
$(document).ready(function () {
  function toggleSidebar() {
    var viewportWidth = $(window).width();
    var sidebar = $('.sidebar');

    if (viewportWidth <= 1668 && !sidebar.hasClass('toggled')) {
      sidebar.addClass('toggled');
    } else if (viewportWidth > 1668 && sidebar.hasClass('toggled')) {
      sidebar.removeClass('toggled');
    }
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
  });
});
