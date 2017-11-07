// file: black_scholes_price_payout_put.cc
// author: Bernt A Oedegaard
//    Calculation of the Black Scholes option price formula, 
//    special case where the underlying is paying out a yield of b.

#include <oxstd.h>
 
option_price_european_put_payout( decl S, // spot price
					 decl X, // Strike (exercise) price,
					 decl r,  // interest rate
					 decl q,  // yield on underlying
					 decl sigma,
					 decl time) {  
    decl sigma_sqr = pow(sigma,2);
    decl time_sqrt = sqrt(time);
    decl d1 = (log(S/X) + (r-q + 0.5*sigma_sqr)*time)/(sigma*time_sqrt);
    decl d2 = d1-(sigma*time_sqrt);
    decl put_price = X * exp(-r*time)*probn(-d2)-S*exp(-q*time)*probn(-d1);
    return put_price;
}
