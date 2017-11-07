// file: fin_algoritms.h 
// author: Bernt Arne Oedegaard
//   defines all routines in the collection of algoritms.
// JAD: created header for Ox program

const decl FNR_ACCURACY=1.0e-6;
const decl FNR_MAXIT   =   500;

///////// cash flow ////////////////////////////////////

cash_flow_pv(const cflow_times, const cflow_amounts, decl r);
cash_flow_pv_discrete(const cflow_times, const cflow_amounts, decl r);
cash_flow_irr(const cflow_times, const cflow_amounts);
cash_flow_unique_irr(const cflow_times, const cflow_amounts);

//// analytical solutions, option pricing (black scholes etc) /////////////////

option_price_call_black_scholes(
    decl S, decl X, decl r, decl sigma, decl time);
option_price_put_black_scholes(
    decl S, decl X, decl r, decl sigma, decl time);
option_price_implied_volatility_call_black_scholes_newton(
    decl S, decl X, decl r, decl time, decl option_price);
option_price_implied_volatility_call_black_scholes_bisections(
    decl S, decl X, decl r, decl time, decl option_price);
option_price_delta_call_black_scholes(
  	decl S, decl X, decl r, decl sigma, decl time);
option_price_delta_put_black_scholes(
  	decl S, decl X, decl r, decl sigma, decl time);
option_price_partials_call_black_scholes(
   	decl S, decl X, decl r, decl sigma, decl time,
   	decl aDelta, decl aGamma, decl aTheta, decl aVega, decl aRho);
option_price_partials_put_black_scholes(
   	decl S, decl X, decl r, decl sigma, decl time,
   	decl aDelta, decl aGamma, decl aTheta, decl aVega, decl aRho);
option_price_european_call_payout(
   	decl S, decl X, decl r, decl q, decl sigma, decl time);
option_price_european_put_payout(
   	decl S, decl X, decl r, decl q, decl sigma, decl time);
option_price_european_call_dividends(
    decl S, decl X, decl r, decl sigma, decl time_to_maturity,
    const dividend_times, const dividend_amounts);
option_price_european_put_dividends(
    decl S, decl X, decl r, decl sigma, decl time_to_maturity,
    const dividend_times, const dividend_amounts);
option_price_american_call_dividend(
   	decl S, decl X, decl r, decl sigma, decl tau,
   	decl D1, decl tau1);

// binomial option pricing ////////////////

option_price_call_european_binomial(
	decl S, decl X, decl r, decl sigma, decl time, decl steps);
option_price_put_european_binomial(
	decl S, decl X, decl r, decl sigma, decl time, decl steps);
option_price_call_american_binomial(
	decl S, decl X, decl r, decl sigma, decl time, decl steps);
option_price_put_american_binomial(
	decl S, decl X, decl r, decl sigma, decl time, decl steps);
option_price_call_american_discrete_dividends_binomial(
    decl S, decl X, decl r, decl sigma, decl time, decl steps,
    const dividend_times, const dividend_amounts);
option_price_put_american_discrete_dividends_binomial(
	decl S, decl X, decl r, decl sigma, decl time, decl steps,
    const dividend_times, const dividend_amounts);
option_price_call_american_proportional_dividends_binomial(
	decl S, decl X, decl r, decl sigma, decl time, decl no_steps,
    const dividend_times, const dividend_yields);
option_price_put_american_proportional_dividends_binomial(
    decl S, decl X, decl r, decl sigma, decl time, decl no_steps,
    const dividend_times, const dividend_yields);
option_price_delta_american_call_binomial(
	decl S, decl X, decl r, decl sigma, decl time, decl no_steps);
option_price_delta_american_put_binomial(
	decl S, decl X, decl r, decl sigma, decl time, decl no_steps);
option_price_partials_american_call_binomial(
	decl S, decl X, decl r, decl sigma, decl time, decl no_steps,
	decl aDelta, decl aGamma, decl aTheta, decl aVega, decl aRho);
option_price_partials_american_put_binomial(
	decl S,  decl X, decl r, decl sigma, decl time, decl no_steps,
	decl aDelta, decl aGamma, decl aTheta, decl aVega, decl aRho);

//////////////////// finite differences //////////////////

option_price_call_american_finite_diff_explicit(
   decl S, decl X, decl r, decl sigma, decl time,
   decl no_S_steps, decl no_t_steps);

option_price_put_american_finite_diff_explicit(
   decl S, decl X, decl r, decl sigma, decl time,
   decl no_S_steps, decl no_t_steps);

option_price_call_european_finite_diff_explicit(
   decl S, decl X, decl r, decl sigma, decl time,
   decl no_S_steps, decl no_t_steps);

option_price_put_european_finite_diff_explicit(
   decl S, decl X, decl r, decl sigma, decl time,
   decl no_S_steps, decl no_t_steps);

option_price_call_american_finite_diff_implicit(
   decl S, decl X, decl r, decl sigma, decl time,
   decl no_S_steps, decl no_t_steps);

option_price_put_american_finite_diff_implicit(
   decl S, decl X, decl r, decl sigma, decl time,
   decl no_S_steps, decl no_t_steps);

option_price_call_european_finite_diff_implicit(
   decl S, decl X, decl r, decl sigma, decl time,
   decl no_S_steps, decl no_t_steps);

option_price_put_european_finite_diff_implicit(
   decl S, decl X, decl r, decl sigma, decl time,
   decl no_S_steps, decl no_t_steps);

///////////////////////// simulated option prices //////////////////////////////////////

option_price_call_european_simulated(
   decl S, decl X, decl r, decl sigma, decl time, decl no_sims);

option_price_put_european_simulated(
   decl S, decl X, decl r, decl sigma, decl time, decl no_sims);

option_price_delta_call_european_simulated(
   decl S, decl X, decl r, decl sigma, decl time, decl no_sims);

option_price_delta_put_european_simulated(
   decl S, decl X, decl r, decl sigma, decl time, decl no_sims);

/////////// approximated option prices ////////////////////////

option_price_american_call_approximated_baw(
 decl S, decl X, decl r, decl b, decl sigma, decl time);

option_price_american_put_approximated_baw(
 decl S, decl X, decl r, decl b, decl sigma, decl time);

//////////////////////////////  futures ///////////////////

futures_price(decl S, decl r, decl time_to_maturity);

futures_option_price_call_european_black(
    decl F, decl X, decl r, decl sigma, decl time);

futures_option_price_put_european_black(
    decl F, decl X, decl r, decl sigma, decl time);

futures_option_price_call_american_binomial(
    decl F, decl X, decl r, decl sigma, decl time, decl no_steps);

futures_option_price_put_american_binomial(
    decl F, decl X, decl r, decl sigma, decl time, decl no_steps);

//////////////// currency ////////////////////

currency_option_price_call_european(
   decl S, decl X, decl r, decl r_f, decl sigma, decl time);

currency_option_price_put_european(
    decl S, decl X, decl r, decl r_f, decl sigma, decl time);

currency_option_price_call_american_binomial(
   decl S, decl X, decl r, decl r_f, decl sigma, decl t, decl n);

currency_option_price_put_american_binomial(
   decl S, decl X, decl r, decl r_f, decl sigma, decl t, decl n);

////////////// exotic options ////////////////////////////////

exotics_lookback_european_call(
	decl S, decl Smin, decl r, decl q, decl sigma, decl time);

exotics_lookback_european_put(
	decl S, decl Smin, decl r, decl q, decl sigma, decl time);
	
///////////////////////// general simulation ////////////////////////

derivative_price_european_simulated2(
	decl S, decl X, decl r, decl sigma, decl time,
 	decl payoff/*(const price, const X)*/, decl no_sims);

derivative_price_european_simulated1(
	decl S, decl r, decl sigma, decl time,
	decl payoff/*(const prices)*/, decl no_steps, decl no_sims);

derivative_price_european_simulated3(
	decl S, decl X, decl r, decl sigma, decl time,
	decl payoff/*(const price, const X)*/, decl no_steps, decl no_sims);

derivative_price_european_simulated_control_variate(
	decl S, decl r, decl sigma, decl time,
	decl payoff/*(const prices)*/, decl no_steps, decl no_sims);

simulate_terminal_price(decl S, decl r, decl sigma, decl time);

simulate_price_sequence(
	decl S, decl r, decl sigma, decl time, decl no_steps);

payoff_european_call(const price, const X);
payoff_european_put(const price, const X);
payoff_min(const prices);
payoff_max(const prices);
payoff_geometric_average(const prices);
payoff_arithmetic_average(const prices);

/////////////////// alternative stochastic processes ////////////////

option_price_call_merton_jump_diffusion(
	decl S, decl X, decl r, decl sigma, decl time_to_maturity,
	decl lambda, decl kappa, decl delta);

//////////////////////////////// classical bonds pricing ////////////

bonds_price_both(
	const coupon_times, const coupon_amounts, const principal_times,
	const principal_amounts, const r);

bonds_price(
	const cashflow_times, const cashflows, const r);

bonds_price_discrete(
	const cashflow_times, const cashflows, const r);

bonds_duration(
	const cashflow_times, const cashflows, const r);

bonds_yield_to_maturity(
	const cashflow_times, const cashflow_amounts, const bondprice);

bonds_duration_macaulay(
	const cashflow_times, const cashflows, const bond_price);

bonds_duration_modified(
	const cashflow_times, const cashflow_amounts, const bond_price, const r);

bonds_convexity(
	const cashflow_times, const cashflow_amounts, const y);


//////// mean variance analysis ////////////////////////////////////////////
mv_calculate_mean(const e, const w);
mv_calculate_variance(const V, const w);
mv_calculate_st_dev(const V, const w);
mv_calculate_portfolio_given_mean_no_short_sales(const e, const V, const r);
mv_calculate_portfolio_given_mean_unconstrained(const e, const V, const r);
mv_calculate_portfolio_given_mean_min_max_constraints(
    const e, const V, const min_weights, const max_weights, const r);

//////// term structure ////////////////////////////////////////////////////

term_structure_yield_from_discount_factor(decl dfact, decl t);
term_structure_discount_factor_from_yield(decl r, decl t);
term_structure_forward_rate_from_disc_facts(decl d_t, decl d_T, decl time);
term_structure_forward_rate_from_yields(decl r_t1, decl r_T, decl t1, decl T);

term_structure_discount_factor_cubic_spline(
	decl t, decl b1, decl c1, decl d1, const f, const knots);

term_structure_discount_factor_vasicek(
	decl time, decl r, decl a, decl b, decl sigma);

term_structure_discount_factor_cir(
	decl t, decl r, decl kappa, decl lambda, decl theta, decl sigma);

term_structure_discount_factor_estimated_cir(
    decl t, decl r, decl phi1, decl phi2, decl phi3);

term_structure_yield_linearly_interpolated(
	decl time, const obs_times, const obs_yields);

term_structure_yield_nelson_siegel(
	decl t, decl beta0, decl beta1, decl beta2, decl lambda);

term_structure_yield_bliss(
	decl t, decl gamma0, decl gamma1, decl gamma2, decl lambda1, decl lambda2);

///////////////////////////////////////////////////////////////////////////
// fixed income derivatives,
// Black Scholes bond option

bond_option_price_call_zero_black_scholes(
    decl B, decl X, decl r, decl sigma, decl time);

bond_option_price_put_zero_black_scholes(
    decl B, decl X, decl r, decl sigma, decl time);

bond_option_price_call_coupon_bond_black_scholes(
    decl B, decl X, decl r, decl sigma, decl time,
    const coupon_times, const coupon_amounts);

bond_option_price_put_coupon_bond_black_scholes(
    decl B, decl X, decl r, decl sigma, decl time,
    const coupon_times, const coupon_amounts);

/// rendlemann barterr

bond_option_price_call_zero_american_rendleman_bartter(
    decl X, decl option_maturity, decl S, decl M, decl interest,
	decl bond_maturity, decl maturity_payment, decl no_steps);

/// Vasicek model, explicit call

bond_option_price_call_zero_vasicek(
	decl X, decl r,	decl option_time_to_maturity,
	decl bond_time_to_maturity, decl a, decl b, decl sigma);

bond_option_price_put_zero_vasicek(
	decl X, decl r, decl option_time_to_maturity,
	decl bond_time_to_maturity, decl a, decl b, decl sigma);

