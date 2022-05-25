// used from https://github.com/StartBootstrap/startbootstrap-simple-sidebar
export function Sidebar() {
  // replaced with window.DOMContentLoaded so that turbo reloaded pages will attach the listener
  document.documentElement.addEventListener('turbo:load', event => {
    // Toggle the side navigation
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
      // Uncomment Below to persist sidebar toggle between refreshes
      // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
      //     document.body.classList.toggle('sb-sidenav-toggled');
      // }
      sidebarToggle.addEventListener('click', event => {
        event.preventDefault();
        document.body.classList.toggle('sb-sidenav-toggled');
        localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
      });
    }
  });
}

export function Contact() {
  document.documentElement.addEventListener('turbo:load', event => {
    var modal = document.getElementById('wufoo_contact')
    modal.addEventListener('show.bs.modal', function (event) {
      console.log('iframe', modal.dataset.iframeSrc)
      this.querySelector('iframe').src = modal.dataset.iframeSrc
    })
  })
}
