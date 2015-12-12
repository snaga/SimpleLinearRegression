DROP AGGREGATE simple_linear_regression (float8, float8);
DROP FUNCTION simple_linear_regression_state (s float8[], y float8, x float8);
DROP FUNCTION simple_linear_regression_final (s float8[]);

CREATE FUNCTION simple_linear_regression_state (
                 s float8[], y float8, x float8)
  RETURNS float8[]
AS $$
    global s

    if x is not None and y is not None:
        if s is None:
            # count, y.sum, x.sum, xx.sum, yx.sum
            s = [0,0,0,0,0]
        s[0] = s[0] + 1
        s[1] = s[1] + y
        s[2] = s[2] + x
        s[3] = s[3] + x*x
        s[4] = s[4] + y*x
    return s
$$ LANGUAGE plpython2u;

CREATE FUNCTION simple_linear_regression_final (
                           s float8[])
  RETURNS float8[]
AS $$
    global s

    # count, y.sum, x.sum, xx.sum, yx.sum
    N      = s[0]
    y_sum  = s[1]
    x_sum  = s[2]
    xx_sum = s[3]
    yx_sum = s[4]

    slope     = (yx_sum - y_sum * x_sum / N) / ( xx_sum - x_sum * x_sum / N)
    intercept = (y_sum/N)- slope * (x_sum/N)
    coeff = [ intercept, slope ]

    return coeff
$$ LANGUAGE plpython2u;

CREATE AGGREGATE simple_linear_regression (float8, float8)
(
    sfunc = simple_linear_regression_state,
    stype = float8[],
    finalfunc = simple_linear_regression_final
);

select simple_linear_regression(price, sqft_living)
  from kc_house_train_data;
