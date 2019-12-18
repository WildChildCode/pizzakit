package model;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.UUID;

public class Order extends BaseUUIDEntity implements Iterable<Item> {
    private Set<Item> items;

    public Order() {
        this.items = new HashSet<>();
    }

    public Order(UUID uuid, Set<Item> items) {
        super(uuid);
        this.items = items;
    }

    public Order(String uuid, Set<Item> items) {
        this(generateUuid(uuid), items);
    }

    public void increaseAmountOrAdd(Item itemToAdd) {
        int newAmount = 0;
        boolean found = false;
        for (Item item : items) {
            if (item.equalsContent(itemToAdd)) {
                newAmount = item.getAmount() + itemToAdd.getAmount();
                item.setAmount(newAmount);
                found = true;
                break;
            }
        }
        if (!found)
           items.add(itemToAdd);
    }

    public boolean decreaseAmountOrRemove(Item itemToRemove) {
        int newAmount = 0;
        boolean remove = false;
        boolean isDecrease = false;
        for (Item item : items) {
            if (item.equalsContent(itemToRemove)) {
                newAmount = item.getAmount() + itemToRemove.getAmount();
                if (newAmount <= 0) {
                    remove = true;
                } else {
                    item.setAmount(newAmount);
                    isDecrease = true;
                }
                break;
            }
        }
        if (remove)
            return items.remove(itemToRemove);
        return isDecrease;
    }

    public boolean addPizzaAmount(Pizza pizza, Pizza.Sizes size, int amount) {
        Item removedItem = null;
        boolean remove = false;
        int newAmount = 0;
        for (Item item : items) {
            if (item.getPizza().equals(pizza) &&
                item.getSize() == size) {
                newAmount=item.getAmount() + amount;
                if (newAmount > 0)
                    item.setAmount(newAmount);
                else {
                    remove = true;
                    removedItem = item;
                }
                break;
            }
        }
        if (remove)
            return items.remove(removedItem);
        return false;
    }

    public int size(){
        return items.size();
    }

    @Override
    public Iterator<Item> iterator() {
        return items.iterator();
    }
}
