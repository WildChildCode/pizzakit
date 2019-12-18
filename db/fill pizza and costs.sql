-- drop tables
DROP TABLE IF EXISTS pizzakit_order_item;
DROP TABLE IF EXISTS pizzakit_orders;
DROP TABLE IF EXISTS pizzakit_users;
DROP TABLE IF EXISTS pizzakit_pizza_sizes_costs;
DROP TABLE IF EXISTS pizzakit_pizzas;
-- end drop tables

-- create schema
CREATE TABLE pizzakit_pizzas
(
    description character varying(2000),
    id          uuid NOT NULL,
    image_url   character varying(1000),
    name        character varying(100),
    ingredients character varying(1000)
);
CREATE TABLE pizzakit_pizza_sizes_costs
(
    id       uuid NOT NULL,
    pizza_id uuid,
    cost     integer,
    size     character varying(5)
);
CREATE TABLE pizzakit_users
(
    id    uuid NOT NULL,
    name  character varying(300),
    email character varying(200),
    phone character varying(13)
);
CREATE TABLE pizzakit_order_item
(
    id           uuid NOT NULL,
    order_id     uuid,
    size_cost_id uuid,
    amount       integer
);
CREATE TABLE pizzakit_orders
(
    id        uuid NOT NULL,
    date_time timestamp without time zone,
    shiped    boolean,
    paid      boolean
);
-- end create schema

-- fill pizzakit_pizzas
insert into pizzakit_pizzas (id, name, ingredients, description, image_url)
values ('b4d84c59-28f8-45c9-ad69-0fb8dd02707a',
        'Маргарита',
        'фирменный томатный соус, сыр моцарелла, помидоры, орегано',
        'Идеальное сочетание расплавленного сыра, свежих помидоров и фирменного томатного соуса. Насладитесь чистым вкусом этой классической пиццы.',
        'resources/img/pizzas/pizza1.jpg');
insert into pizzakit_pizzas (id, name, ingredients, description, image_url)
values ('9b634278-7901-4b71-9ac4-e7952c98c247',
        'Сырная',
        'фирменный томатный соус, сыр моцарелла',
        'Попробуйте истинную классику вкуса c самыми вкусными ингредиентами!',
        'resources/img/pizzas/pizza2.jpg');
insert into pizzakit_pizzas (id, name, ingredients, description, image_url)
values ('354f1a5f-ea67-4b63-a6fc-d0fd02ac894f',
        'Мексиканская',
        'фирменный томатный соус, цыпленок гриль, сладкий зеленый перец, лук, шампиньоны, томаты, перец халапеньо, сыр моцарелла',
        'Своим острым вкусом эта пицца обязана зеленому перчику халапеньо.',
        'resources/img/pizzas/pizza3.jpg');
insert into pizzakit_pizzas (id, name, ingredients, description, image_url)
values ('5055a3fe-1cca-4149-bab5-3fd99e3bb47c',
        'Мясная',
        'фирменный томатный соус, пепперони, ветчина, бекон, итальянские колбаски, говядина, сыр моцарелла',
        'В эту «протеиновую» пиццу входит целых четыре вида мяса!',
        'resources/img/pizzas/pizza4.jpg');
insert into pizzakit_pizzas (id, name, ingredients, description, image_url)
values ('02a54c5d-efe5-487e-8590-38f559495e60',
        'Гавайская',
        'фирменный томатный соус, ветчина, ананасы. сыр моцарелла',
        'Оригинальный вкусовой букет для настоящих гурманов - попробуй гавайскую пиццу!',
        'resources/img/pizzas/pizza5.jpg');
-- end fill pizzakit_pizzas

-- fill pizzakit_pizza_sizes_costs
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('1e1ca857-2f4c-4070-9dc9-830ae805fa87',
        'b4d84c59-28f8-45c9-ad69-0fb8dd02707a',
        'S',
        '200');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('03c77c49-1413-499f-a307-64b9963ee974',
        'b4d84c59-28f8-45c9-ad69-0fb8dd02707a',
        'M',
        '250');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('c149ee81-821b-4b70-a88b-14dfe9cfb1ce',
        'b4d84c59-28f8-45c9-ad69-0fb8dd02707a',
        'L',
        '300');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('b110894c-a3c2-4a35-b56a-e0570b98efbd',
        'b4d84c59-28f8-45c9-ad69-0fb8dd02707a',
        'XL',
        '350');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('b686821f-2cd4-48f3-a905-acc827a895b6',
        'b4d84c59-28f8-45c9-ad69-0fb8dd02707a',
        'XXL',
        '400');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('e2244276-1c78-49ae-8b06-e9f5c55b8ed8',
        '9b634278-7901-4b71-9ac4-e7952c98c247',
        'M',
        '350');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('89d8dbe6-d725-4f30-985e-b11927bb94b9',
        '9b634278-7901-4b71-9ac4-e7952c98c247',
        'L',
        '400');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('a0528ff6-1e43-49a4-b75f-a933cf05daac',
        '9b634278-7901-4b71-9ac4-e7952c98c247',
        'XL',
        '475');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('fbcef1a1-6272-4c07-9ca2-40806a9167a3',
        '9b634278-7901-4b71-9ac4-e7952c98c247',
        'XXL',
        '550');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('59d39f29-223a-45b1-b488-f2a29470782a',
        '354f1a5f-ea67-4b63-a6fc-d0fd02ac894f',
        'M',
        '300');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('b693ca0e-3e9a-4ec6-8e0f-5d3c9f98f1e8',
        '354f1a5f-ea67-4b63-a6fc-d0fd02ac894f',
        'L',
        '400');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('714f61dd-4219-4b70-82a2-5a0a5c590935',
        '354f1a5f-ea67-4b63-a6fc-d0fd02ac894f',
        'XL',
        '450');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('2da509e7-3f24-4110-8158-f8242bd8fd14',
        '5055a3fe-1cca-4149-bab5-3fd99e3bb47c',
        'S',
        '300');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('426fddd2-2db3-4991-ba72-ea0db3481fb7',
        '5055a3fe-1cca-4149-bab5-3fd99e3bb47c',
        'M',
        '400');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('ce13baa9-26e1-4412-821b-91c73a4678a3',
        '5055a3fe-1cca-4149-bab5-3fd99e3bb47c',
        'L',
        '500');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('45924cf1-2841-480a-8c5b-8a65e4e3cafb',
        '5055a3fe-1cca-4149-bab5-3fd99e3bb47c',
        'XL',
        '575');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('4a1a0fbe-970f-4f23-826c-795ebde49c88',
        '5055a3fe-1cca-4149-bab5-3fd99e3bb47c',
        'XXL',
        '650');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('b1bbad5e-b236-4c00-a6d3-f04af96b52ff',
        '02a54c5d-efe5-487e-8590-38f559495e60',
        'M',
        '350');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('5eb30bf2-659e-4ae8-82c9-f863e31f4e21',
        '02a54c5d-efe5-487e-8590-38f559495e60',
        'L',
        '400');
insert into PIZZAKIT_PIZZA_SIZES_COSTS (id, pizza_id, size, cost)
values ('0b9b68f7-8301-4687-8e34-e637d0796ae5',
        '02a54c5d-efe5-487e-8590-38f559495e60',
        'XL',
        '500');
-- end fill pizzakit_pizza_sizes_costs
commit;

-- add constraints
/* for future using
ALTER TABLE ONLY pizzakit_order_item
    ADD CONSTRAINT pizzakit_order_item_pkey PRIMARY KEY (id);
ALTER TABLE ONLY pizzakit_orders
    ADD CONSTRAINT pizzakit_orders_pkey PRIMARY KEY (id);
ALTER TABLE ONLY pizzakit_users
    ADD CONSTRAINT pizzakit_users_pkey PRIMARY KEY (id);
 */
ALTER TABLE ONLY pizzakit_pizza_sizes_costs
    ADD CONSTRAINT pk_pizzakit_pizza_sizes_costs_id PRIMARY KEY (id);
ALTER TABLE ONLY pizzakit_pizzas
    ADD CONSTRAINT pk_pizzakit_pizzas_id PRIMARY KEY (id);
/* for future using
ALTER TABLE ONLY pizzakit_order_item
    ADD CONSTRAINT fk_order_item_order_id_to_orders_id FOREIGN KEY (order_id) REFERENCES pizzakit_orders(id);
ALTER TABLE ONLY pizzakit_order_item
    ADD CONSTRAINT fk_order_item_size_cost_id_to_sizes_costs_id FOREIGN KEY (size_cost_id) REFERENCES pizzakit_pizza_sizes_costs(id);
 */
ALTER TABLE ONLY pizzakit_pizza_sizes_costs
    ADD CONSTRAINT fk_pizzakit_pizza_sizes_costs_pizza_id_to_pizzas_id FOREIGN KEY (pizza_id) REFERENCES pizzakit_pizzas(id);

-- end add constraints
