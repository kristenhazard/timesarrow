
function toggle_finalists() {
	Element.toggle('finalists');
  if (Element.visible('finalists')) Element.update('toggle_finalists','hide');
	else Element.update('toggle_finalists','show');
}

function set_finalists() {
	Element.update('toggle_finalists','show')
}