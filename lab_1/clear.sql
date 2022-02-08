truncate addresses cascade;
truncate customers cascade;
truncate employees cascade;
truncate faxes cascade;
truncate items cascade;
truncate orders cascade;
truncate parts cascade;
truncate phone cascade;
truncate vendors cascade;

alter sequence addresses_id_seq restart with 1;
alter sequence customers_id_seq restart with 1;
alter sequence employees_id_seq restart with 1;
alter sequence faxes_id_seq restart with 1;
alter sequence items_id_seq restart with 1;
alter sequence orders_id_seq restart with 1;
alter sequence parts_id_seq restart with 1;
alter sequence phones_id_seq restart with 1;
alter sequence vendors_id_seq restart with 1;
