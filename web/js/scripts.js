var order = [];
var requestString = '';

function addToCart(pizzaID, sizeNodeName, quantityNodeName) {
    var select = document.getElementById(sizeNodeName);
    var number = document.getElementById(quantityNodeName);

    var pizza = {
        name: pizzaID,
        quantity: Number(number.value),
        size: select.options[select.selectedIndex].value
    };

    for (var i = 0; i < order.length; i++) {
        if (pizza.name == order[i].name && pizza.size == order[i].size) {
            order[i].quantity += pizza.quantity;
            return;
        }
    }
    order[order.length] = pizza;
    document.getElementById('cart-items-count').innerText = String(order.length);
}

function formRequest() {
    requestString = '';
    for (var i = 0; i < order.length; i++) {
        if (i != 0) requestString += '&';
        requestString += order[i].name + '=' + order[i].size + '#' + order[i].quantity;
    }
}

function sendRequest() {
    formRequest()
    alert(requestString);
    //  var form = document.getElementById('submitform');
    //  form.firstElementChild.setAttribute('value', requestString);
    //  form.submit();

    //window.location.replace('order.jsp?' + requestString);
}