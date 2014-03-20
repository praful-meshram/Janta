/**
 * Gets all elements inside the given one,
 * that have class "item".
 */
function getItems(listEl) {
	return Zapatec.Utils.getElementsByAttribute("className", "item", listEl, false, true);
}

/**
 * Sets the lastItem class name for the last item in list.
 */
function setLastItem(items) {
	if (items.length === 0) {
		return null;
	}
	for(var i = 0; i < items.length; ++i) {
		Zapatec.Utils.removeClass(items[i], "lastItem");
	}
	Zapatec.Utils.addClass(items[items.length - 1], "lastItem");
}

/**
 * Finds element by its coordinate
 */
function findElementByY(items, inside, posY) {
	if(items.length == 0){
		return null;
	}

	var overItemY = posY - Zapatec.Utils.getElementOffset(inside).y + inside.scrollTop,
	height = items[items.length - 1].offsetHeight,
	itemNr = (Math.floor((overItemY - height / 2) / height) + 1) || 0;
	return items[itemNr];
}

/**
 * Is the draggable element list item.
 */
function isItem(el) {
	if (!el.className || el.className.indexOf("item") == -1) {
		return false;
	}
	return true;
}

/**
 * Deletes "hihghlight" class from first argument,
 * and adds it to second one. Returns newly 
 * highlighted element.
 */
function moveHighlight(from, to, className) {
	if (from == to) {return to;}
	if (Zapatec.isHtmlElement(from)) {
		Zapatec.Utils.removeClass(from, className);
	}
	if (Zapatec.isHtmlElement(to)) {
		Zapatec.Utils.addClass(to, className);
		return to;
	}
	return null;
}

/**
 * Selects one item inthe list, marking it with className.
 */
function selectItem(list, item, className) {
	//item can be selected only if it wasn't selected yet
	if (item.className.indexOf(className) == -1) {
		//adding it to active items
		list.push(item);
		//adding className
		Zapatec.Utils.addClass(item, className);
	}
}

/**
 * Deselects one item in the list, removing className mark.
 */
function deselectItem(list, item, className) {
	//removing item from active ones
	list = activeItems.without(item);
	//removing className
	Zapatec.Utils.removeClass(item, className);
}

/**
 * Deselects all items in the list.
 */
function deselectAll(list, className) {
	//iterating through all items and removing className
	list.each(function(index, item) {
		Zapatec.Utils.removeClass(item, className);
	});
	//clearing the array
	list.clear();
}

/**
 * Selects group of items from start index to end index.
 * Items are put into separate shiftList, but we also 
 * need reference to main list to avoid duplicate selected 
 * items.
 */
function selectItemsGroup(list, shiftList, from, className, listElement) {
	//deselecting previously selected with SHIFT items
	shiftList.each(function(index, item) {
		deselectItem(list, item, className);
	});
	//and clearing the array
	shiftList.clear();
	
	//we need to get indexes of elements in the parent array of child nodes
	var to = parseInt(Zapatec.Utils.getElementPath(list[list.length - 1], listElement));
	from = parseInt(Zapatec.Utils.getElementPath(from, listElement));
	if (from != to) {
		//we calculate direction of selection of items (increasing or decreasing)
		var direction = (to - from) / Math.abs(to - from);
		var items = listElement.childNodes;
		//walking through elements between
		for(var i = from - 1; i != to; i += direction) {
			if (Zapatec.isHtmlElement(items[i]) && items[i].className.indexOf(className) == -1) {
				Zapatec.Utils.addClass(items[i], className);
				shiftList.push(items[i]);
			}
		}
		//adding to item, it can not be selected yet, otherwise we wouldn't get here
		if (Zapatec.isHtmlElement(items[i]) && items[i].className.indexOf(className) == -1) {
			Zapatec.Utils.addClass(items[i], className);
			shiftList.push(items[i]);
		}
	}
}

/**
 * Changes the styles of element to be the
 * item of new list.
 */
function changeParentList(el, from, to) {
	Zapatec.Utils.removeClass(el, from + "Item");
	Zapatec.Utils.addClass(el, to + "Item");
}

/**
 * Adds items from some array to list.
 * Elements supposed to be already selected.
 */
function addItems(arr, list) {
	arr.each(function(index, item) {
		list.push(item);
	});
	arr.clear();
}

/**
 * Gets the target item of event or null
 */
function getTargetItem(ev, list) {
	//getting event target
	var target = Zapatec.Utils.getTargetElement(ev);
	//bubling up to find out if this is item
	while(target.className.indexOf("item") == -1 && target != list) {
		target = target.parentNode;
	}
	//if no item than this must be end of list
	if (target == list) {
		return null;
	}
	//returning item
	return target;
}

/**
 * Shows alert with all items in their order.
 */
function showOrder(items) {
	res = "";
	for(var i = 0; i < items.length; ++i) {
		res += (items[i].innerHTML + "\n");
	}
	alert(res);
}