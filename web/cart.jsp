
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<header>
    <h1>
        Pizza Italiano
    </h1>
    <aside>
        Заказ пиццы on-line. (8-846) 000-00-01
    </aside>
</header>
<form id="items-list" class="items-list" action="" method="post">
    <h2 id="cart-header" class="cart-header">Ваш заказ</h2>
    <div class="item" id="pizza-1-XL" style="padding: 1vh 1vw;">
        <div style="overflow: auto; margin: 0 0 1em 0">
            <h3 class="pizza_name_h3">Маргарита</h3>
            <div class="controls-pane">
                <select name="size-1-XL" class="size control">
                    <option value="L">30см</option>
                    <option value="XL" selected>35см</option>
                    <option value="XXL">40см</option>
                </select>
                <label> количество <input type="number" name="amount-1-XL" class="amount-chooser control" value="1"></label>
            </div>
        </div>
    </div>
    <div>
        <input type="submit" name="order" value="Оформить заказ" class="submit-button control"
               formmethod="post" formaction="order.jsp"/>
        <input type="button" name="back" value="Продолжить покупки" class="submit-button control"
               formmethod="post" formaction="menu.jsp"/>
    </div>
</form>
<footer class="footer">
    <p>&copy; Copyright 2010 - 2018. Pizza Italiano. Все права защищены.</p>
</footer>
</body>
</html>