drop table kc_house_data;
drop table kc_house_train_data;
drop table kc_house_test_data;

create table kc_house_data (
  id text,
  "date" text,
  price float,
  bedrooms float,
  bathrooms float,
  sqft_living float,
  sqft_lot int,
  floors text,
  waterfront int,
  "view" int,
  condition int,
  grade int,
  sqft_above int,
  sqft_basement int,
  yr_built int,
  yr_renovated int,
  zipcode text,
  lat float,
  long float,
  sqft_living15 float,
  sqft_lot15 float
);

create table kc_house_train_data (
) inherits (kc_house_data);

create table kc_house_test_data (
) inherits (kc_house_data);

\copy kc_house_data from 'kc_house_data.csv' with (header true, format csv);
\copy kc_house_train_data from 'kc_house_train_data.csv' with (header true, format csv);
\copy kc_house_test_data from 'kc_house_test_data.csv' with (header true, format csv);
