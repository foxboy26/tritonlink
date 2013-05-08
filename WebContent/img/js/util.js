function addItem(itemId, listId) {
    var lastItem = $('#' + itemId + ':last');
    if (lastItem.css('display') == 'none')
        lastItem.css('display', 'block');
    else
        $('#' + listId).append(lastItem.clone());
}
