#include <oxstd.h>
#import "financialNR"

test_simulate_pricing()
{
    println("START testing Monte Carlo option pricing");
    decl S        = 100.0;
    decl X        = 100.0;
    decl r        = 0.1;
    decl sigma    = 0.25;
    decl time     = 1.0;
    decl no_sims  = 50000;
    println(" call ");
    println("   black scholes price = ",
		option_price_call_black_scholes(S,X,r,sigma,time));
    println("    simulated = ",
		option_price_call_european_simulated(S,X,r,sigma,time,no_sims));
    println(" put  ");
    println("   black scholes price = ",
		option_price_put_black_scholes(S,X,r,sigma,time));
    println("    simulated = ",
		option_price_put_european_simulated(S,X,r,sigma,time,no_sims));
    println("DONE testing MC pricing ");
}
test_simulate_deltas()
{
    println("START testing estimating deltas of simulated prices");
    decl S        = 100.0;
    decl X        = 100.0;
    decl r        = 0.1;
    decl sigma    = 0.25;
    decl time     = 1.0;
    decl no_sims  = 50000;
    println(" call: bs= ",
    	option_price_delta_call_black_scholes(S,X,r,sigma,time),
        " sim= ",
        option_price_delta_call_european_simulated(S,X,r,sigma,time,no_sims));
    println(" put: bs= ",
    	option_price_delta_put_black_scholes(S,X,r,sigma,time),
      	" sim= ",
   		option_price_delta_put_european_simulated(S,X,r,sigma,time,no_sims));
  	println("DONE testing estimating deltas");
}
main()
{
  test_simulate_pricing();
  test_simulate_deltas();
}
