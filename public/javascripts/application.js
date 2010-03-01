
function toggle_finalists() {
	Element.toggle('finalists');
  if (Element.visible('finalists')) {
		Element.update('toggle_finalists','hide');
		Element.writeAttribute('toggle_finalists', 'flag', 'hide')
	}
	else {
		Element.update('toggle_finalists','show');
		Element.writeAttribute('toggle_finalists', 'flag', 'show')
	}
}

function set_finalists() {
	var toggle_text = Element.readAttribute('toggle_finalists', 'flag')
	if (toggle_text == "hide") {
		Element.toggle('finalists')
	}
}

