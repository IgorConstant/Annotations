document.addEventListener('DOMContentLoaded', function () {
  var toggle = document.getElementById('darkModeToggle');
  var icon = document.getElementById('darkModeIcon');

  function updateIcon(theme) {
    if (theme === 'dark') {
      icon.classList.remove('bi-moon-fill');
      icon.classList.add('bi-sun-fill');
    } else {
      icon.classList.remove('bi-sun-fill');
      icon.classList.add('bi-moon-fill');
    }
  }

  updateIcon(document.documentElement.getAttribute('data-bs-theme'));

  toggle.addEventListener('click', function () {
    var current = document.documentElement.getAttribute('data-bs-theme');
    var next = current === 'dark' ? 'light' : 'dark';
    document.documentElement.setAttribute('data-bs-theme', next);
    localStorage.setItem('theme', next);
    updateIcon(next);
  });
});
