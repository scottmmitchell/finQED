// file: black_scholes_call_div.cc
// author: Bernt A Oedegaard

#include <oxstd.h>
#include "financialNR.h"          // define the black scholes price

option_price_european_call_dividends(
						decl S,
					    decl X,
					    decl r,
					    decl sigma,
					    decl time_to_maturity,
					    const dividend_times,
					    const dividend_amounts)
{
	// reduce the current stock price by the amount of dividends.
	decl idx = vecindex(dividend_times .<= time_to_maturity);
	if (sizerc(idx))
		S -= double(sumc(vec(dividend_amounts[idx]) .* exp(-r*vec(dividend_times[idx]))));
    return option_price_call_black_scholes(S,X,r,sigma,time_to_maturity);
}
