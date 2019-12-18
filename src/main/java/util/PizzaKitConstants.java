package util;

public interface PizzaKitConstants {
    String DATA_SOURCE_JNDI_NAME = "jdbc/pizzaDS";

    String PIZZAS_SESSION_ATTRIBUTE = "pizzas";
    String ORDER_SESSION_ATTRIBUTE = "cart";
    String DATA_MANAGER_SESSION_ATTRIBUTE = "dataManager";

    String SUBMIT_BUTTON_REQUEST_PARAMETER_NAME="add";
    String SUBMIT_BUTTON_REQUEST_PARAMETER_VALUE="+";
    String ID_REQUEST_PARAMETER_NAME="pizzaid";
    String SIZE_REQUEST_PARAMETER_NAME="size";
    String AMOUNT_REQUEST_PARAMETER_NAME ="amount";
}
