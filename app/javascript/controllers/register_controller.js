import { Controller } from "@hotwired/stimulus"

// Toggles registration buttons from registered to unregistered when clicked
export default class extends Controller {

  static targets = ['button', 'name']
  static values = {
    child: String,
    cost: String,
    id: String,
    type: String
}

  toggle (e) {
    e.preventDefault()

    const child = this.childValue
    const content = this.buttonTarget.innerHTML
    const cost = this.costValue
    const id = this.idValue
    const siblings = getSiblings(this.element)
    const type = this.typeValue

    switch (content) {
        case 'Register':
            this.buttonTarget.classList.add('registered')
            this.buttonTarget.innerHTML = 'Unregister'
            break;
        case 'Unregister':
            this.buttonTarget.classList.remove('registered')
            this.buttonTarget.innerHTML = 'Register'
            break;
        case '✖':
            this.buttonTarget.classList.add('registered')
            this.buttonTarget.innerHTML = '✓'
            break;
        case '✓':
            this.buttonTarget.classList.remove('registered')
            this.buttonTarget.innerHTML = '✖'
            break;
        default:
            break;
    }

    this.dispatch('toggle', { detail: { child: child, content: content, cost: cost, id: id, siblings: siblings, type: type } })
  }
}

// Gets me the other options when a radio button is checked
var getSiblings = function (elem) {

	// Setup siblings array and get the first sibling
	var siblings = [];
	var sibling = elem.parentNode.firstChild;

	// Loop through each sibling and push to the array
	while (sibling) {
		if (sibling.tagName === 'DIV' && sibling !== elem) {
			siblings.push(sibling);
		}
		sibling = sibling.nextSibling
	}

	return siblings;
};