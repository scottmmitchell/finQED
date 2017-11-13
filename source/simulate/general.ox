// file simulate_general.cc
// author: Bernt A Oedegaard
// estimation of an option price by simulation.
// This is a general routine, the payoff is defined by the user as a function
//       payoff(vector<decl>&) or
//       payoff(vector<decl>&,X),
// depending on whether there are other arguments beside the prices of the underlying needed.

#include <oxstd.h>
#include "financialNR.h"

derivative_price_european_simulated2 ( decl S,  decl X,  decl r,  decl sigma, decl time,
					     decl payoff, // function
					     decl no_sims) {
    decl sum_payoffs=0;
    for (decl n=0; n<no_sims; n++) {
       decl S_T = simulate_terminal_price(S,r,sigma,time);
       sum_payoffs += payoff(S_T,X);
    }
    return  exp(-r*time) * (sum_payoffs/no_sims);
}

derivative_price_european_simulated1 ( decl S, decl r, decl sigma, decl time,
					     decl payoff, // function
					     decl no_steps, decl no_sims) {
   decl sum_payoffs=0;
   decl prices;
   for (decl n=0; n<no_sims; n++) {
      prices = simulate_price_sequence(S,r,sigma,time,no_steps);
      sum_payoffs += payoff(prices);
   }
   return  exp(-r*time) * (sum_payoffs/no_sims);
}

derivative_price_european_simulated3 ( decl S, decl X, decl r, decl sigma, decl time,
					     decl payoff, // function
					     decl no_steps, decl no_sims) {
   decl sum_payoffs=0;
   decl prices;
   for (decl n=0; n<no_sims; n++) {
      prices = simulate_price_sequence(S,r,sigma,time,no_steps);
      sum_payoffs += payoff(prices,X);
   }
   return  exp(-r*time) * (sum_payoffs/no_sims);
}
