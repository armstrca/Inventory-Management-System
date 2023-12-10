// ...
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require sb-admin-2
//= require dataTables/jquery.dataTables
//= require rails_datatables.js
//= require_tree 

document.addEventListener("DOMContentLoaded", function() {
  // Function to update the left position of the fixed-topbar
  function updateTopbarPosition() {
    const sidebar = document.querySelector(".sidebar");
    const topbar = document.querySelector(".fixed-topbar");

    // Get the current width of the sidebar
    const sidebarWidth = sidebar.clientWidth;

    // Check if the sidebar is collapsed
    const isSidebarCollapsed = sidebar.classList.contains("collapsed");

    // Calculate the left position for the topbar
    const topbarLeft = isSidebarCollapsed ? 0 : sidebarWidth;

    // Set the left position of the topbar
    topbar.style.left = topbarLeft + "px";
  }

  // Initial call to set the position
  updateTopbarPosition();

  // Listen for window resize events to update the position when the sidebar width changes
  window.addEventListener("resize", updateTopbarPosition);

  // Listen for sidebar toggle events to update the position when the sidebar is toggled
  const sidebarToggle = document.getElementById("sidebarToggleTop");
  if (sidebarToggle) {
    sidebarToggle.addEventListener("click", updateTopbarPosition);
  }
});
