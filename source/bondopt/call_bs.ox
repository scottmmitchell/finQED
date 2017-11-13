// file bondopt_call_bs.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>

bond_option_price_call_zero_black_scholes(
    decl B, decl X, decl r, decl sigma, decl time)
{  
    decl time_sqrt = sqrt(time);
    decl d1 = (log(B/X)+r*time)/(sigma*time_sqrt) + 0.5*sigma*time_sqrt; 
    decl d2 = d1-(sigma*time_sqrt);
    decl c = B * probn(d1) - X * exp(-r*time) * probn(d2);
    return c;
}
