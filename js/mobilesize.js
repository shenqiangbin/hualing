(function() {
	var docEl = document.documentElement;
	var setRem = function() {
		var screenWidth = docEl.clientWidth || window.screen.width || 360;
		docEl.style.fontSize = (100 * screenWidth / 640) + 'px';
		$(document.body).show();
		document.body.style.visibility = 'visible';
	};
	window.addEventListener('resize', setRem, false);
	setRem();
})();