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


// Assuming the IDs for the sidebar toggle button and content wrapper are 'sidebarToggle' and 'content-wrapper', respectively.

document.addEventListener('DOMContentLoaded', function() {
  const sidebarToggle = document.getElementById('sidebarToggle');
  const contentWrapper = document.getElementById('content-wrapper');
  const expandedPadding = '250px'; // The padding when the sidebar is expanded
  const collapsedPadding = '70px'; // The padding when the sidebar is collapsed

  // Function to set dynamic padding
  function setDynamicPadding() {
    if (document.body.classList.contains('sidebar-toggled')) {
      contentWrapper.style.paddingLeft = collapsedPadding;
    } else {
      contentWrapper.style.paddingLeft = expandedPadding;
    }
  }

  // Event listener for the sidebar toggle
  sidebarToggle.addEventListener('click', function() {
    // Wait for the sidebar transition to complete before applying padding
    setTimeout(setDynamicPadding, 350); // Adjust timing to match CSS animation
  });

  // Initial padding setup
  setDynamicPadding();
});
