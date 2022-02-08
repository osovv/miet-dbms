-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file.
-- These commands were put in this file only as a convenience.
--
-- object: miet_lab1 | type: DATABASE --
-- DROP DATABASE IF EXISTS miet_lab1;
CREATE DATABASE miet_lab1;
-- ddl-end --


-- object: public.items | type: TABLE --
-- DROP TABLE IF EXISTS public.items CASCADE;
CREATE TABLE public.items (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	order_id bigint,
	part_id bigint,
	quantity bigint NOT NULL,
	discount jsonb,
	CONSTRAINT items_pk_id PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.items OWNER TO postgres;
-- ddl-end --

-- object: public.parts | type: TABLE --
-- DROP TABLE IF EXISTS public.parts CASCADE;
CREATE TABLE public.parts (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	vendor_id bigint,
	description varchar(300) NOT NULL,
	on_hand bigint NOT NULL,
	on_order bigint NOT NULL,
	cost money NOT NULL,
	list_price money NOT NULL,
	CONSTRAINT parts_pk_id PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON COLUMN public.parts.cost IS E'за сколько купили у поставщика';
-- ddl-end --
COMMENT ON COLUMN public.parts.list_price IS E'за сколько продаём';
-- ddl-end --
ALTER TABLE public.parts OWNER TO postgres;
-- ddl-end --

-- object: public.vendors | type: TABLE --
-- DROP TABLE IF EXISTS public.vendors CASCADE;
CREATE TABLE public.vendors (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	address_id bigint,
	phone_id bigint,
	fax_id bigint,
	name character varying(100),
	preferred bool NOT NULL DEFAULT false,
	CONSTRAINT vendors_pk_id PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON COLUMN public.vendors.preferred IS E'если есть опция купить у этого поставщика, покупаем у него';
-- ddl-end --
ALTER TABLE public.vendors OWNER TO postgres;
-- ddl-end --

-- object: public.phones | type: TABLE --
-- DROP TABLE IF EXISTS public.phones CASCADE;
CREATE TABLE public.phones (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	phone varchar(32) NOT NULL,
	CONSTRAINT phones_pk_id PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.phones OWNER TO postgres;
-- ddl-end --

-- object: public.faxes | type: TABLE --
-- DROP TABLE IF EXISTS public.faxes CASCADE;
CREATE TABLE public.faxes (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	fax character varying(100) NOT NULL,
	CONSTRAINT faxes_pk_id PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.faxes OWNER TO postgres;
-- ddl-end --

-- object: public.addresses | type: TABLE --
-- DROP TABLE IF EXISTS public.addresses CASCADE;
CREATE TABLE public.addresses (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	billing_address character varying(200),
	shipping_address character varying(200),
	city character varying(60) NOT NULL,
	zip character varying(20) NOT NULL,
	country character varying(2) NOT NULL,
	CONSTRAINT addresses_pk_id PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON COLUMN public.addresses.country IS E'ISO 3166-1 alpha-2';
-- ddl-end --
ALTER TABLE public.addresses OWNER TO postgres;
-- ddl-end --

-- object: public.customers | type: TABLE --
-- DROP TABLE IF EXISTS public.customers CASCADE;
CREATE TABLE public.customers (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	address_id bigint,
	fax_id bigint,
	phone_id smallint,
	tax_rate float NOT NULL,
	contact jsonb NOT NULL,
	last_invoice_date date,
	CONSTRAINT customers_pk_id PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.customers OWNER TO postgres;
-- ddl-end --

-- object: public.employees | type: TABLE --
-- DROP TABLE IF EXISTS public.employees CASCADE;
CREATE TABLE public.employees (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	first_name character varying(50) NOT NULL,
	last_name character varying(50) NOT NULL,
	hire_date date NOT NULL,
	salary money NOT NULL,
	CONSTRAINT employees_pk_id PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.employees OWNER TO postgres;
-- ddl-end --

-- object: public.orders | type: TABLE --
-- DROP TABLE IF EXISTS public.orders CASCADE;
CREATE TABLE public.orders (
	id bigint NOT NULL,
	customer_id bigint,
	address_id bigint,
	employee_id bigint,
	payment_method jsonb NOT NULL,
	items_total smallint NOT NULL,
	tax_rate float NOT NULL,
	freight jsonb NOT NULL,
	amount_paid money,
	created_at date NOT NULL,
	shipped_at date,
	CONSTRAINT orderds_pk_id PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.orders OWNER TO postgres;
-- ddl-end --

-- object: index_customers_on_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_customers_on_id CASCADE;
CREATE INDEX index_customers_on_id ON public.customers
USING btree
(
	id
);
-- ddl-end --

-- object: index_customers_on_address_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_customers_on_address_id CASCADE;
CREATE INDEX index_customers_on_address_id ON public.customers
USING btree
(
	address_id
);
-- ddl-end --

-- object: index_customers_on_fax_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_customers_on_fax_id CASCADE;
CREATE INDEX index_customers_on_fax_id ON public.customers
USING btree
(
	fax_id
);
-- ddl-end --

-- object: index_customers_on_phone_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_customers_on_phone_id CASCADE;
CREATE INDEX index_customers_on_phone_id ON public.customers
USING btree
(
	phone_id
);
-- ddl-end --

-- object: index_orders_on_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_orders_on_id CASCADE;
CREATE INDEX index_orders_on_id ON public.orders
USING btree
(
	id
);
-- ddl-end --

-- object: index_orders_on_customer_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_orders_on_customer_id CASCADE;
CREATE INDEX index_orders_on_customer_id ON public.orders
USING btree
(
	customer_id
);
-- ddl-end --

-- object: index_orders_on_address_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_orders_on_address_id CASCADE;
CREATE INDEX index_orders_on_address_id ON public.orders
USING btree
(
	address_id
);
-- ddl-end --

-- object: index_orders_on_employee_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_orders_on_employee_id CASCADE;
CREATE INDEX index_orders_on_employee_id ON public.orders
USING btree
(
	employee_id
);
-- ddl-end --

-- object: index_orders_on_created_at | type: INDEX --
-- DROP INDEX IF EXISTS public.index_orders_on_created_at CASCADE;
CREATE INDEX index_orders_on_created_at ON public.orders
USING btree
(
	created_at
);
-- ddl-end --

-- object: index_items_on_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_items_on_id CASCADE;
CREATE INDEX index_items_on_id ON public.items
USING btree
(
	id
);
-- ddl-end --

-- object: index_items_on_order_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_items_on_order_id CASCADE;
CREATE INDEX index_items_on_order_id ON public.items
USING btree
(
	order_id
);
-- ddl-end --

-- object: index_items_on_part_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_items_on_part_id CASCADE;
CREATE INDEX index_items_on_part_id ON public.items
USING btree
(
	part_id
);
-- ddl-end --

-- object: index_employees_on_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_employees_on_id CASCADE;
CREATE INDEX index_employees_on_id ON public.employees
USING btree
(
	id
);
-- ddl-end --

-- object: index_parts_on_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_parts_on_id CASCADE;
CREATE INDEX index_parts_on_id ON public.parts
USING btree
(
	id
);
-- ddl-end --

-- object: index_parts_on_vendor_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_parts_on_vendor_id CASCADE;
CREATE INDEX index_parts_on_vendor_id ON public.parts
USING btree
(
	vendor_id
);
-- ddl-end --

-- object: index_vendors_on_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_vendors_on_id CASCADE;
CREATE INDEX index_vendors_on_id ON public.vendors
USING btree
(
	id
);
-- ddl-end --

-- object: index_vendors_on_address_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_vendors_on_address_id CASCADE;
CREATE INDEX index_vendors_on_address_id ON public.vendors
USING btree
(
	address_id
);
-- ddl-end --

-- object: index_vendors_on_fax_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_vendors_on_fax_id CASCADE;
CREATE INDEX index_vendors_on_fax_id ON public.vendors
USING btree
(
	fax_id
);
-- ddl-end --

-- object: index_vendors_on_phone_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_vendors_on_phone_id CASCADE;
CREATE INDEX index_vendors_on_phone_id ON public.vendors
USING btree
(
	phone_id
);
-- ddl-end --

-- object: index_faxes_on_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_faxes_on_id CASCADE;
CREATE INDEX index_faxes_on_id ON public.faxes
USING btree
(
	id
);
-- ddl-end --

-- object: index_faxes_on_fax | type: INDEX --
-- DROP INDEX IF EXISTS public.index_faxes_on_fax CASCADE;
CREATE INDEX index_faxes_on_fax ON public.faxes
USING hash
(
	fax
);
-- ddl-end --

-- object: index_phones_on_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_phones_on_id CASCADE;
CREATE INDEX index_phones_on_id ON public.phones
USING btree
(
	id
);
-- ddl-end --

-- object: index_phones_on_phone | type: INDEX --
-- DROP INDEX IF EXISTS public.index_phones_on_phone CASCADE;
CREATE INDEX index_phones_on_phone ON public.phones
USING hash
(
	phone
);
-- ddl-end --

-- object: index_addresses_on_id | type: INDEX --
-- DROP INDEX IF EXISTS public.index_addresses_on_id CASCADE;
CREATE INDEX index_addresses_on_id ON public.addresses
USING btree
(
	id
);
-- ddl-end --

-- object: index_addresses_on_country | type: INDEX --
-- DROP INDEX IF EXISTS public.index_addresses_on_country CASCADE;
CREATE INDEX index_addresses_on_country ON public.addresses
USING hash
(
	country
);
-- ddl-end --

-- object: index_addresses_on_shipping_address | type: INDEX --
-- DROP INDEX IF EXISTS public.index_addresses_on_shipping_address CASCADE;
CREATE INDEX index_addresses_on_shipping_address ON public.addresses
USING hash
(
	shipping_address
);
-- ddl-end --

-- object: index_addresses_on_billing_address | type: INDEX --
-- DROP INDEX IF EXISTS public.index_addresses_on_billing_address CASCADE;
CREATE INDEX index_addresses_on_billing_address ON public.addresses
USING hash
(
	billing_address
);
-- ddl-end --

-- object: index_addresses_on_zip | type: INDEX --
-- DROP INDEX IF EXISTS public.index_addresses_on_zip CASCADE;
CREATE INDEX index_addresses_on_zip ON public.addresses
USING hash
(
	zip
);
-- ddl-end --

-- object: items_fk_part_id | type: CONSTRAINT --
-- ALTER TABLE public.items DROP CONSTRAINT IF EXISTS items_fk_part_id CASCADE;
ALTER TABLE public.items ADD CONSTRAINT items_fk_part_id FOREIGN KEY (part_id)
REFERENCES public.parts (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: items_fk_order_id | type: CONSTRAINT --
-- ALTER TABLE public.items DROP CONSTRAINT IF EXISTS items_fk_order_id CASCADE;
ALTER TABLE public.items ADD CONSTRAINT items_fk_order_id FOREIGN KEY (order_id)
REFERENCES public.orders (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: parts_fk_vendor_id | type: CONSTRAINT --
-- ALTER TABLE public.parts DROP CONSTRAINT IF EXISTS parts_fk_vendor_id CASCADE;
ALTER TABLE public.parts ADD CONSTRAINT parts_fk_vendor_id FOREIGN KEY (vendor_id)
REFERENCES public.vendors (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: vendors_fk_phone_id | type: CONSTRAINT --
-- ALTER TABLE public.vendors DROP CONSTRAINT IF EXISTS vendors_fk_phone_id CASCADE;
ALTER TABLE public.vendors ADD CONSTRAINT vendors_fk_phone_id FOREIGN KEY (phone_id)
REFERENCES public.phones (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: vendors_fk_fax_id | type: CONSTRAINT --
-- ALTER TABLE public.vendors DROP CONSTRAINT IF EXISTS vendors_fk_fax_id CASCADE;
ALTER TABLE public.vendors ADD CONSTRAINT vendors_fk_fax_id FOREIGN KEY (fax_id)
REFERENCES public.faxes (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: vendors_fk_address_id | type: CONSTRAINT --
-- ALTER TABLE public.vendors DROP CONSTRAINT IF EXISTS vendors_fk_address_id CASCADE;
ALTER TABLE public.vendors ADD CONSTRAINT vendors_fk_address_id FOREIGN KEY (address_id)
REFERENCES public.addresses (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: customers_fk_address_id | type: CONSTRAINT --
-- ALTER TABLE public.customers DROP CONSTRAINT IF EXISTS customers_fk_address_id CASCADE;
ALTER TABLE public.customers ADD CONSTRAINT customers_fk_address_id FOREIGN KEY (address_id)
REFERENCES public.addresses (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: customers_fk_fax_id | type: CONSTRAINT --
-- ALTER TABLE public.customers DROP CONSTRAINT IF EXISTS customers_fk_fax_id CASCADE;
ALTER TABLE public.customers ADD CONSTRAINT customers_fk_fax_id FOREIGN KEY (fax_id)
REFERENCES public.faxes (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: customers_fk_phone_id | type: CONSTRAINT --
-- ALTER TABLE public.customers DROP CONSTRAINT IF EXISTS customers_fk_phone_id CASCADE;
ALTER TABLE public.customers ADD CONSTRAINT customers_fk_phone_id FOREIGN KEY (phone_id)
REFERENCES public.phones (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: orders_fk_customer_id | type: CONSTRAINT --
-- ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_fk_customer_id CASCADE;
ALTER TABLE public.orders ADD CONSTRAINT orders_fk_customer_id FOREIGN KEY (customer_id)
REFERENCES public.customers (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: orders_fk_address_id | type: CONSTRAINT --
-- ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_fk_address_id CASCADE;
ALTER TABLE public.orders ADD CONSTRAINT orders_fk_address_id FOREIGN KEY (address_id)
REFERENCES public.addresses (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: orders_fk_employee_id | type: CONSTRAINT --
-- ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_fk_employee_id CASCADE;
ALTER TABLE public.orders ADD CONSTRAINT orders_fk_employee_id FOREIGN KEY (employee_id)
REFERENCES public.employees (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
