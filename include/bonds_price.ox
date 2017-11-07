// file bonds_price.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>

bonds_price(const cashflow_times, const cashflows, const r)
{ 
    // calculate bond price when term structure is flat, 
    return double(sumc(exp(-r*vec(cashflow_times)).*vec(cashflows))); 
}
