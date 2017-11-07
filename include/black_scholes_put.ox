// file: black_scholes_put
// author: Bernt A Oedegaard
//    Calculation of the Black Scholes option price formula.

#include <oxstd.h>
 

option_price_put_black_scholes( decl S,      // spot price
				       decl X,      // Strike (exercise) price,
				       decl r,      // interest rate
				       decl sigma,  // volatility
				       decl time) {  
    decl time_sqrt = sqrt(time);
    decl d1 = (log(S/X)+r*time)/(sigma*time_sqrt) + 0.5*sigma*time_sqrt;
    decl d2 = d1-(sigma*time_sqrt);
    decl p =  X * exp(-r*time) * probn(-d2) - S * probn(-d1); 
    return p;
}
