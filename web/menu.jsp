<%@ page import="managers.SimpleDataManager" %>
<%@ page import="model.*" %>
<%@ page import="util.PizzaKitConstants" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %> <%-- jsp directives --%>
<%@ page errorPage="error.jsp" %>
<%--
  This is JSP commentaries block. It never renders in response output (but html commentaries block passes to output).
--%>
<%-- Declaration block. Remember - it maps to elements of servlet class! Don't forget servlet's are used by different Threads.
     So try to create servlets without user-level state.  --%>
<%!
    //JspPage interface declare two lifecycle methods jspInit() & jspDestroy(), both called by container
    public void jspInit(){
        try {
            Class.forName("managers.SimpleDataManager"); //load SimpleDataManager to init it's static members
        } catch (ClassNotFoundException e) {
            //it won't happen =))))
        }
    }
    private SimpleDataManager getDataManager() {
         return SimpleDataManager.getInstance();
    }
    private Item constructItem(SimpleDataManager manager, Map<String, String[]> parameters){
        try {
            int amount = Integer.parseInt(parameters.get(PizzaKitConstants.AMOUNT_REQUEST_PARAMETER_NAME)[0]);
            UUID pizzaid = BaseUUIDEntity.generateUuid(parameters.get(PizzaKitConstants.SUBMIT_BUTTON_REQUEST_PARAMETER_NAME)[0]);
            Pizza.Sizes size = Pizza.Sizes.valueOf(parameters.get(PizzaKitConstants.SIZE_REQUEST_PARAMETER_NAME)[0]);
            return Item.CreateNewItem(manager.getPizza(pizzaid), amount, size);
        } catch (Exception e) {
            throw new IllegalArgumentException(e);
        }
    }
%>
<%-- Scriptlet block. The code from scriplets passes to realisation of doGet() and\or doPost() methods of servlet --%>
<%
    /* init logic, we are using standard objects - session and request.
       Standard objects are placed as properties of "pageContext" standard object=))*/
    Order order;
    SimpleDataManager dataManager;
    //check if user gets access to the page first time
    if (session.isNew()) {
        order = new Order();
        session.setAttribute(PizzaKitConstants.ORDER_SESSION_ATTRIBUTE, order);
        dataManager = getDataManager();
        session.setAttribute(PizzaKitConstants.DATA_MANAGER_SESSION_ATTRIBUTE, dataManager);
    } else {
        order = (Order) session.getAttribute(PizzaKitConstants.ORDER_SESSION_ATTRIBUTE);
        dataManager = (SimpleDataManager) session.getAttribute(PizzaKitConstants.DATA_MANAGER_SESSION_ATTRIBUTE);
        //check if user have pressed add button
        if (session.getAttribute(PizzaKitConstants.SUBMIT_BUTTON_REQUEST_PARAMETER_NAME) != null) {
            //construct item from request attributes
            Item item = constructItem(dataManager, request.getParameterMap());
            order.increaseAmountOrAdd(item);
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
    <p id="cart-text">Товаров: <span id="cart-items-count"><%= order.size() %></span></p> <%-- you can see an expression here --%>
</div>
<div id="items-ist" class="items-list">
    <%-- The main problem of JSP is that you have to mix scriplets and static markup.
         When we talk about huge projects - it's a real pain --%>
    <%
        int pizzaCounter = 1;
        for (Pizza pizza : dataManager.getPizzas()) { %>
    <form class="item"
          id="<%= "pizza-" + pizzaCounter %>"  <%-- you can use expressions to create tag content and attribute content as well--%>
          name="<%= "pizza-form-" + pizzaCounter %>"
          enctype="application/x-www-form-urlencoded"
          action="menu.jsp"
          method="get">
        <img class="pizza_img_small"
             alt="Picture with the pizza"
             src="<%= pizza.getImageUrl() %>"/>
        <div style="overflow: auto; margin: 0 0 1em 0">
            <h2 class="pizza_name_h2"><%= pizza.getName() %></h2>
            <p class="description"><%= pizza.getDescription() %></p>
            <p class="ingredients"><b>Состав:</b> <%= pizza.getIngredients()%></p>
            <div class="controls-pane">
                <select
                        name="<%= PizzaKitConstants.SIZE_REQUEST_PARAMETER_NAME %>"
                        class="size control"
                        id="<%= "size-" + pizzaCounter %>">
                    <% List<Pizza.Sizes> sizes = new ArrayList<>(pizza.getCostsMap().keySet());
                        Collections.sort(sizes);
                        for (Pizza.Sizes size : sizes) { %>
                        <option value="<%= size.name() %>" class="size-option"><%= size.getDiameter() + "см." %></option>
                    <% } %>
                </select>
                <input
                        type="number"
                        name="<%= PizzaKitConstants.AMOUNT_REQUEST_PARAMETER_NAME %>"
                        class="amount-chooser control"
                        value="1"
                        min="0"
                        id="<%= "amount" + pizzaCounter %>"/>
                <button
                        type="submit"
                        name="<%= PizzaKitConstants.SUBMIT_BUTTON_REQUEST_PARAMETER_NAME %>"
                        class="button-add control"
                        value="<%= pizza.getUuid().toString() %>">
                    +
                </button>
            </div>
        </div>
    </form>
    <% pizzaCounter++;
        } %>
</div>

<footer class="footer">
    <p>&copy; Copyright 2010 - 2018. Pizza Italiano. Все права защищены.</p>
</footer>
</body>
</html>