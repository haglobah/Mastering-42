const initApp = () => {
	const hamburgerBtn = document.getElementById('hamburger-button')
	const mobileSidenav = document.getElementById('mobile-sidenav')

	const toggleSidenav = () => {
		mobileSidenav.classList.toggle('hidden')
		// mobileSidenav.classList.toggle('block')
	}

	hamburgerBtn.addEventListener('click', toggleSidenav)
	mobileSidenav.addEventListener('click', toggleSidenav)
}

document.addEventListener('DOMContentLoaded', initApp)