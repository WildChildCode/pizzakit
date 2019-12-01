package model;

import java.io.Serializable;
import java.util.Objects;
import java.util.UUID;

public class Item extends BaseUUIDEntity{
    private Pizza pizza;
    private int quantity;
    private Pizza.Sizes size;

    protected Item(Pizza pizza, int quantity, Pizza.Sizes size) {
        this(generateUuid(), pizza, quantity, size);
    }

    protected Item(UUID uuid, Pizza pizza, int quantity, Pizza.Sizes size) {
        super(uuid);
        this.pizza = pizza;
        this.quantity = quantity;
        this.size = size;
    }

    public Pizza getPizza() {
        return pizza;
    }

    public void setPizza(Pizza pizza) {
        this.pizza = pizza;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Pizza.Sizes getSize() {
        return size;
    }

    public void setSize(Pizza.Sizes size) {
        this.size = size;
    }

    public boolean equalsContent(Item item) {
        if (this == item) return true;
        return item != null &&
                quantity == item.quantity &&
                size == item.size &&
                Objects.equals(pizza, item.pizza);
    }

    public static Item CreateItem(UUID uuid, Pizza pizza, int quantity, Pizza.Sizes size) {
        return new Item(uuid, pizza, quantity, size);
    }

    public static Item CreateNewItem(Pizza pizza, int quantity, Pizza.Sizes size){
        return new Item(pizza, quantity, size);
    }
}
