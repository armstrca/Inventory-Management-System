// ...
//= require rails-ujs
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require sb-admin-2
document.addEventListener("DOMContentLoaded", function() {
  // Function to update the left position of the fixed-topbar
  function updateTopbarPosition() {
    // const sidebar = document.querySelector(".sidebar");
    const sidebarWidth = document.querySelector(".sidebar").clientWidth;
    const topbar = document.querySelector(".fixed-topbar");
    topbar.style.left = sidebarWidth + "px";
  }
  // Function to update the topbar width and text fade
  function updateTopbarWidth() {
    const sidebarWidth = sidebar.clientWidth;
    const isSidebarCollapsed = sidebar.classList.contains("collapsed");
    
    // Update the topbar width based on the sidebar width
    topbar.style.width = isSidebarCollapsed ? "0" : sidebarWidth + "px";

  }
  
  // Initial call to set the position
  updateTopbarPosition();
  
  // Listen for window resize events to update the position when the sidebar width changes
  window.addEventListener("resize", updateTopbarPosition);
  
});


