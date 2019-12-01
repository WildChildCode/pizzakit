<%@ page import="managers.SimpleDataManager" %>
<%@ page import="model.*" %>
<%@ page import="util.PizzaKitConstants" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %> <%-- jsp directives --%>
<%@ page errorPage="error.jsp" %>
<%--
  This is JSP commentaries block. It never renders in response output (but html commentaries block passes to output).
--%>
<%-- Declaration block. Remember - it maps to elements of servlet class! So its elements will be used by different Threads.
     So try to create servlets without user-level state.  --%>
<%!
    private SimpleDataManager getDataManager() {
         return SimpleDataManager.getInstance();
    }
    private Item constructItem(){

        return Item.CreateNewItem();
    }
%>
<%-- Scriptlet block. The code from scriplets passes to realisation of doGet() and\or doPost() methods of servlet --%>
<%
    //init logic, we are using standard object - session
    Order order;
    //check if user gets access to the page first time
    if (session.isNew()) {
        order = new Order();
        session.setAttribute(PizzaKitConstants.ORDER_SESSION_ATTRIBUTE, order);
    } else {
        order = (Order) session.getAttribute(PizzaKitConstants.ORDER_SESSION_ATTRIBUTE);
        //check if user have pressed add button
        if (session.getAttribute(PizzaKitConstants.SUBMIT_BUTTON_REQUEST_PARAMETER_NAME) != null) {
            //restore pizza-object from request attributes

        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Заказ пиццы on-line</title>
    <script src="js/scripts.js" type="text/javascript"></script>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
<header>
    <h1>
        Pizza Italiano
    </h1>
    <aside>
        Заказ пиццы on-line. (8-846) 000-00-01
    </aside>
</header>
<div id="cart">
    <a href="cart.jsp" target="_blank">
        <img src="resources/img/shopping_cart.png" alt="cart" width="50"/>
    </a>
    <p id="cart-text">Товаров: <span id="cart-items-count">0</span></p>
</div>
<div id="items-ist" class="items-list">
    <form class="item" id="pizza-1" name="pizza-form-1" action="" method="get">
        <img class="pizza_img_small" alt="Picture with the pizza" src="resources/img/pizzas/pizza1.jpg"/>
        <div style="overflow: auto; margin: 0 0 1em 0">
            <h2 class="pizza_name_h2">Маргарита</h2>
            <p class="description">Идеальное сочетание расплавленного сыра, свежих помидоров и фирменного томатного
                соуса. Насладитесь чистым вкусом этой классической пиццы.</p>
            <p class="ingredients"><b>Состав:</b> фирменный томатный соус, сыр моцарелла,
                помидоры, орегано</p>
            <div class="controls-pane">
                <select name="size-select" class="size control" id="size-1">
                    <option value="M" class="size-option">25см</option>
                    <option value="L" class="size-option">30см</option>
                    <option value="XL" class="size-option">35см</option>
                    <option value="XXL" class="size-option">40см</option>
                </select>
                <input type="number" name="amount" class="amount-chooser control" value="1" min="0" id="amount-1">
                <input type="submit" name="add" class="button-add control" value="+"/>
            </div>
        </div>
    </form>
</div>

<footer class="footer">
    <p>&copy; Copyright 2010 - 2018. Pizza Italiano. Все права защищены.</p>
</footer>
</body>
</html>