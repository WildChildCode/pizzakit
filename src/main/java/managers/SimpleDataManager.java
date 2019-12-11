package managers;

import model.Item;
import model.Order;
import model.Pizza;
import util.PizzaKitConstants;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.sql.Date;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
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
            Context env = (Context) initContext.lookup("java:/comp/env/");
            ds = (DataSource) env.lookup(PizzaKitConstants.DATA_SOURCE_JNDI_NAME);
            Connection connection = ds.getConnection();
            Statement selectPizzasInfoStatement = connection.createStatement();
            ResultSet rs = selectPizzasInfoStatement.executeQuery("SELECT * FROM pizzakit_pizzas");
            while (rs.next()) {
                pizzaId = Pizza.generateUuid(rs.getString("id"));
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
                    connection.prepareStatement("SELECT size, cost FROM PIZZAKIT_PIZZA_SIZES_COSTS WHERE pizza_id = ?");
            for (UUID id : pizzasMap.keySet()) {
                selectPizzaSizesAndCosts.setObject(1, id);
                rs = selectPizzaSizesAndCosts.executeQuery();
                costsMap = new HashMap<>();
                while (rs.next()) {
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

    public boolean isInitialized() {
        return initialized;
    }

    public synchronized void reInit() {
        init();
    }

    public Pizza getPizza(UUID id) {
        return pizzas.get(id);
    }

    public Collection<Pizza> getPizzas() {
        return pizzas.values();
    }

    public void persistOrder(Order order) {
        DataSource ds;
        try {
            InitialContext initContext = new InitialContext();
            Context env = (Context) initContext.lookup("java:/comp/env/");
            ds = (DataSource) env.lookup(PizzaKitConstants.DATA_SOURCE_JNDI_NAME);
            Connection connection = ds.getConnection();
            insertOrder(order, connection);
            PreparedStatement statement;
            Object pizzaSizesCostsId;
            int insertedItemsCount = 0;
            for (Item item : order) {
                pizzaSizesCostsId = getSizesCostsUuid(item, connection);
                statement = connection.prepareStatement("INSERT INTO pizzakit_order_item (id, order_id, size_cost_id, amount) values (?,?,?,?)");
                statement.setObject(1, item.getUuid());
                statement.setObject(2, order.getUuid());
                statement.setObject(3, pizzaSizesCostsId);
                statement.setInt(4, item.getAmount());
                insertedItemsCount += statement.executeUpdate();
            }
        } catch (NamingException | SQLException e) {
            //We will show message to user about this exception
            throw new RuntimeException("There is a problem with DataBase", e);
        }

    }

    private void insertOrder(Order order, Connection connection) throws SQLException {
        final String inserOrderUqery = "INSERT INTO pizzakit_orders (id, date_time, shiped, paid) VALUES (?,?,?,?)";
        PreparedStatement statement = connection.prepareStatement(inserOrderUqery);
        statement.setObject(1, order.getUuid());
        statement.setDate(2, new java.sql.Date(LocalDateTime.now().toEpochSecond(ZoneOffset.of(ZoneOffset.systemDefault().getId()))));
        statement.setBoolean(3, false);
        statement.setBoolean(4, false);
        statement.executeUpdate();
        //int rowsInsertedCount = statement.executeUpdate();
        /*
        if (rowsInsertedCount == 0)
            throw new FuckBuHourseException()
         */
    }

    private Object getSizesCostsUuid(Item item, Connection connection) throws SQLException {
        final String sizeCostUuidQuery = "SELECT id from pizzakit_pizza_sizes_costs where pizza_id = ? and size = ?";
        PreparedStatement statement = connection.prepareStatement(sizeCostUuidQuery);
        statement.setObject(1, item.getPizza().getUuid());
        statement.setString(2, item.getSize().name());
        ResultSet rs = statement.executeQuery();
        Object pizzaSizesCostsId;
        if (rs.next()) {
            pizzaSizesCostsId = rs.getObject(1);
        }
        else
            throw new IllegalArgumentException("There is no pizza with the given size in menu");
        rs.close();
        statement.close();
        return pizzaSizesCostsId;
    }
}
