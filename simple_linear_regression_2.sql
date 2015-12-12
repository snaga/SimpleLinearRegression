select sqft_living,
       price,
       round(-47116.0791388 + 281.958839662 * sqft_living) as price_predicted,
       round((((-47116.0791388 + 281.958839662 * sqft_living) - price) / price)::numeric, 2) as error
  from kc_house_test_data;
