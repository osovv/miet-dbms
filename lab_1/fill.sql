-- phones
INSERT INTO phones (phone) 
VALUES 
  ('+1(720)641-92-98'), 
  ('+1(865)256-56-20'), 
  ('+7(952)471-46-90'), 
  ('+7(915)423-12-22');

-- faxes
INSERT INTO faxes (fax) 
VALUES 
  ('+44 161 999 8888'), 
  ('+1 212 999 8888'),
  ('+1 212 222 8888'); 

-- addresses
INSERT INTO addresses (
  billing_address, 
  shipping_address, 
  city,
  zip,
  country
) VALUES (
  '721 Modoc Alley',
  '721 Modoc Alley',
  'Moscow',
  '83843',
  'ru'
), (
  '372 Blackwell Street',
  '2489 Blackwell Street',
  'Fairbanks',
  '99701', 
  'us'
), (
  '4566 Anmoore Road',
  '4566 Anmoore Road',
  'New York',
  '10011',
  'us'
);

-- vendors
INSERT INTO vendors (
  address_id,
  phone_id,
  fax_id,
  name,
  preferred
) VALUES (
  1, 3, 1,
  'Moscow Shop',
  'true'
), (
  2, 2, 2,
  'Fairbanks Shop',
  'false'
), (
  3, 1, 3,
  'NY Shop',
  'true'
);

-- parts
INSERT INTO parts (
  vendor_id, 
  description, 
  on_hand,
  on_order,
  cost,
  list_price
) VALUES (
  3, 
  'some object', 
  100, 20,
  1000, 1500
), (
  3,
  'new part',
  200, 10,
  572, 899
);

-- customers
INSERT INTO customers (
  address_id,
  phone_id,
  fax_id,
  tax_rate,
  contact,
  last_invoice_date
) VALUES (
  1, 4, 1,
  20, 
  '{"msg": "None"}'::jsonb,
  '08/02/2022'
);

-- employee
INSERT INTO employees (
  first_name,
  last_name,
  hire_date,
  salary
) VALUES (
  'Glenn', 'Johnson',
  '20/05/2020', 4000
), (
  'Julia', 'Lemelin',
  '12/12/2021', 3500
);

-- orders
INSERT INTO orders (
  customer_id, 
  address_id, 
  employee_id, 
  payment_method, 
  items_total, 
  tax_rate, 
  freight, 
  amount_paid, 
  created_at, 
  shipped_at
) VALUES (
  1, 1, 1,
  '{"method": "card", "card_type": "visa", "status": "done"}'::jsonb,
  1, 5,
  '{"expected delivery time": "40 days"}'::jsonb,
  10000, '10/08/2021', '01/10/2021'
), (
  1, 1, 2,
  '{"method": "bank transh", "status": "pending"}'::jsonb,
  2, 3,
  '{"expected delivery time": "28 days"}'::jsonb,
  30000, '08/02/2022', null
);

--items
INSERT INTO items (
  order_id,
  part_id,
  quantity,
  discount
) VALUES (
  1, 1,
  10, null
), (
  2, 1,
  20, '{"for cooperation": "20"}'::jsonb
), (
  2, 2,
  15, '{"for cooperation": "3"}'::jsonb
);
