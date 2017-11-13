// file: black_scholes_delta_put.cc
// author: Bernt A Oedegaard
// The delta of the Black - Scholes formula

#include <oxstd.h>

option_price_delta_put_black_scholes(
					decl S, // spot price
				    decl X, // Strike (exercise) price,
				    decl r,  // interest rate
				    decl sigma,
				    decl time)
{
    decl time_sqrt = sqrt(time);
    decl d1 = (log(S/X)+r*time)/(sigma*time_sqrt) + 0.5*sigma*time_sqrt; 
    decl delta = -probn(-d1);
    return delta;
}
