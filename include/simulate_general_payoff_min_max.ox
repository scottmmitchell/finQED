// file simulate_general_payoff_min_max

#include <oxstd.h>

payoff_max(const prices) {
   decl m = max(prices);
   return m-prices[sizerc(prices)-1]; // max is always larger or equal.
}

payoff_min(const prices) {
   decl m = min(prices); 
   return prices[sizerc(prices)-1]-m; // always positive or zero
}

