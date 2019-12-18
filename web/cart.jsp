<%@ page import="model.Order" %>
<%@ page import="managers.SimpleDataManager" %>
<%@ page import="util.PizzaKitConstants" %>
<%@ page import="model.Pizza" %>
<%@ page import="model.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%!
    private SimpleDataManager getDataManager() {
        return SimpleDataManager.getInstance();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>
        Заказ пиццы on-line
    </title>
    <script src="js/scripts.js" type="text/javascript"></script>
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
<%@include file="resources/header.jspf"%> <%-- reuse of header content --%>
<%
    Order order;
    SimpleDataManager dataManager;
    //check if user gets access to the page first time
    if (session.isNew()) {
        order = new Order();
        session.setAttribute(PizzaKitConstants.ORDER_SESSION_ATTRIBUTE, order);
        dataManager = getDataManager();
        session.setAttribute(PizzaKitConstants.DATA_MANAGER_SESSION_ATTRIBUTE, dataManager);
        request.getRequestDispatcher("/menu.jsp").forward(request, response); //redirect user to menu, if it was his first time
    } else {
        order = (Order) session.getAttribute(PizzaKitConstants.ORDER_SESSION_ATTRIBUTE);
        dataManager = (SimpleDataManager) session.getAttribute(PizzaKitConstants.DATA_MANAGER_SESSION_ATTRIBUTE);
    }
%>
<form id="items-list" class="items-list" action="order.jsp" method="post">
    <h2 id="cart-header" class="cart-header">Ваш заказ</h2>
    <%
        int pizzaCounter = 1;
        String idsSuffix;
        for (Item item : order) {
            idsSuffix = pizzaCounter + "-" + item.getSize().name();%>
        <div
            class="item"
            id="<%= "pizza-" + idsSuffix %>"
            style="padding: 1vh 1vw;">
        <div style="overflow: auto; margin: 0 0 1em 0">
            <h3 class="pizza_name_h3"><%= item.getPizza().getName() %></h3>
            <div class="controls-pane">
                <select
                        name="<%= PizzaKitConstants.SIZE_REQUEST_PARAMETER_NAME %>"
                        class="size control"
                        id="<%= "size-" + idsSuffix %>">
                        <% List<Pizza.Sizes> sizes = new ArrayList<>(item.getPizza().getCostsMap().keySet());
                            Collections.sort(sizes);
                            for (Pizza.Sizes size : sizes) { %>
                                <option value="<%= size.name() %>" class="size-option" <%= size == item.getSize() ? "selected" : "" %>><%= size.getDiameter() + "см." %></option>
                         <% } %>
                </select>
                <label> количество <input type="number"
                                          name=" <%= "amount" + idsSuffix %>"
                                          class="amount-chooser control"
                                          value="<%= item.getAmount() %>"></label>
            </div>
        </div>
        </div>
    <% } %>
    <div>
        <input type="submit" name="order" value="Оформить заказ" class="submit-button control"
               formmethod="post" formaction="order.jsp"/>
        <input type="submit" name="back" value="Продолжить покупки" class="submit-button control"
               formmethod="post" formaction="menu.jsp"/>
    </div>
</form>
<%@include file="resources/footer.jspf"%>
</body>
</html>