
function toggle_finalists() {
	Element.toggle('finalists');
  if (Element.visible('finalists')) {
		Element.update('toggle_finalists','hide');
		Element.writeAttribute('toggle_finalist_flag', 'value', 'hide')
	}
	else {
		Element.update('toggle_finalists','show');
		Element.writeAttribute('toggle_finalist_flag', 'value', 'show')
	}
}

function set_finalists() {
	var toggle_text = Element.readAttribute('toggle_finalist_flag', 'value')
	if (toggle_text == "hide") {
		Element.toggle('finalists')
	}
}