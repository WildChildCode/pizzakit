package managers;

import model.Pizza;
import util.PizzaKitConstants;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.*;

/**
 * Pizzas data manager Singleton
 * We work in paradigm - no changes in Pizzas
 */
public class SimpleDataManager {
    private static final SimpleDataManager INSTANCE = new SimpleDataManager();
    private volatile Map<UUID, Pizza> pizzas;
    private volatile boolean initialized = false;

    private SimpleDataManager() {
        init();
    }

    public static synchronized SimpleDataManager getInstance() {
        return INSTANCE;
    }
    private synchronized void init() {
        initialized = false;
        HashMap<UUID, Pizza> pizzasMap = new HashMap<>();
        Map<Pizza.Sizes, Integer> costsMap = Collections.<Pizza.Sizes, Integer>emptyMap();
        Pizza pizza;
        DataSource ds;
        UUID pizzaId;
        try {
            InitialContext initContext = new InitialContext();
            ds = (DataSource) initContext.lookup(PizzaKitConstants.DATA_SOURCE_JNDI_NAME);
            Connection connection = ds.getConnection();
            Statement selectPizzasInfoStatement = connection.createStatement();
            ResultSet rs = selectPizzasInfoStatement.executeQuery("SELECT * FROM pizzakit_pizzas");
            while (rs.next()) {
                pizzaId=Pizza.generateUuid(rs.getString("id"));
                pizza = Pizza.createPizza(pizzaId,
                                          costsMap,
                                          rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("ingredients"),
                        rs.getString("image_url"));
                pizzasMap.put(pizzaId, pizza);
            }
            rs.close();
            selectPizzasInfoStatement.close();
            PreparedStatement selectPizzaSizesAndCosts =
                    connection.prepareStatement("SELECT size, cost FROM PIZZAKIT_PIZZA_SIZES_COSTS WHERE pizza_id=?");
            for (UUID id : pizzasMap.keySet()) {
                selectPizzaSizesAndCosts.setString(1, id.toString());
                rs = selectPizzaSizesAndCosts.executeQuery();
                costsMap = new HashMap<>();
                while (rs.next()){
                    costsMap.put(Pizza.Sizes.valueOf(rs.getString("size")), rs.getInt("cost"));
                }
                rs.close();
                pizzasMap.put(id, pizzasMap.get(id).changeCostsMap(costsMap));
            }
            selectPizzaSizesAndCosts.close();
            connection.close();
            pizzas = Collections.unmodifiableMap(pizzasMap);
            initialized = true;
        } catch (NamingException | SQLException e) {
            //We will show message to user about this exception
            throw new RuntimeException("There is a problem with getting data from DataBase", e);
        }
    }

    public Pizza getPizza(UUID id) {
        return pizzas.get(id);
    }

    public Collection<Pizza> getPizzas() {
        return pizzas.values();
    }

    public boolean isInitialized() {
        return initialized;
    }

    public synchronized void reInit(){
        init();
    }
}
