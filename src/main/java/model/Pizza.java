package model;

import java.util.Collections;
import java.util.Map;
import java.util.UUID;

/**
 * Unmodifiable Entity - Pizza
 */
public final class Pizza extends BaseUUIDEntity {
    public enum Sizes {
        S(20), M(25), L(30), XL(35), XXL(40);
        /** diameter in cm */
        private int diameter;
        private Sizes(int diameter) {
            this.diameter = diameter;
        }
        public int getDiameter() {
            return diameter;
        }
    }
    private final Map<Sizes, Integer> costsMap;
    private final String name;
    private final String description;
    private final String ingredients;
    private final String imageUrl;

    protected Pizza(Map<Sizes, Integer> costsMap, String name, String description, String ingredients, String imageUrl) {
        this(generateUuid(), costsMap, name, description, ingredients, imageUrl);
    }

    protected Pizza(UUID uuid, Map<Sizes, Integer> costsMap, String name, String description, String ingredients, String imageUrl) {
        super(uuid);
        this.costsMap = Collections.unmodifiableMap(costsMap);
        this.name = name;
        this.description = description;
        this.ingredients = ingredients;
        this.imageUrl = imageUrl;
    }

    protected Pizza(Map<Sizes, Integer> costsMap, Pizza pizza) {
        this(pizza.getUuid(),
                costsMap,
                pizza.name,
                pizza.description,
                pizza.ingredients,
                pizza.imageUrl);
    }

    public static Pizza createPizza(UUID uuid, Map<Sizes, Integer> costsMap, String name, String description, String components, String imageUrl) {
        return new Pizza(uuid, costsMap, name, description, components, imageUrl);
    }

    public static Pizza createNewPizza(Map<Sizes, Integer> costsMap, String name, String description, String components, String imageUrl) {
        return new Pizza(costsMap, name, description, components, imageUrl);
    }

    public Map<Sizes, Integer> getCostsMap() {
        return costsMap;
    }
    public String getName() {
        return name;
    }
    public String getDescription() {
        return description;
    }
    public String getIngredients() {
        return ingredients;
    }
    public String getImageUrl() {
        return imageUrl;
    }
    public Pizza changeCostsMap (Map<Sizes, Integer> newCostsMap){
        return new Pizza(newCostsMap, this);
    }
}
