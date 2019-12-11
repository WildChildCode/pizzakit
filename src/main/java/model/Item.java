package model;

import java.util.Objects;
import java.util.UUID;

public class Item extends BaseUUIDEntity{
    private Pizza pizza;
    private int amount;
    private Pizza.Sizes size;
    private int cost;

    protected Item(Pizza pizza, int amount, Pizza.Sizes size) {
        this(generateUuid(), pizza, amount, size);
    }

    protected Item(UUID uuid, Pizza pizza, int amount, Pizza.Sizes size) {
        super(uuid);
        this.pizza = pizza;
        this.amount = amount;
        this.size = size;
        this.cost = pizza.getCost(size);
    }

    public Pizza getPizza() {
        return pizza;
    }

    public void setPizza(Pizza pizza) {
        this.pizza = pizza;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Pizza.Sizes getSize() {
        return size;
    }

    public void setSize(Pizza.Sizes size) {
        this.size = size;
    }

    public int getCost() {
        return cost;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }

    public boolean equalsContent(Item item) {
        if (this == item) return true;
        return item != null &&
                size == item.size &&
                Objects.equals(pizza, item.pizza);
    }

    public static Item CreateItem(UUID uuid, Pizza pizza, int amount, Pizza.Sizes size) {
        return new Item(uuid, pizza, amount, size);
    }

    public static Item CreateNewItem(Pizza pizza, int amount, Pizza.Sizes size){
        return new Item(pizza, amount, size);
    }

    @Override
    public String toString() {
        return "Item{" +
                "id=" + getUuid() +
                "pizza=" + pizza +
                ", amount=" + amount +
                ", size=" + size +
                ", cost=" + cost +
                '}';
    }
}
