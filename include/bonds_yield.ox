// file bonds_yield.cc
// author: Bernt A Oedegaard
// calculate Yield to maturity for bond

#include <oxstd.h>
#include "financialNR.h"

bonds_yield_to_maturity(const cashflow_times,
				const cashflow_amounts,
				const bondprice)
{
  	decl bot=0, top=1.0;
  	while (bonds_price(cashflow_times, cashflow_amounts, top) > bondprice)
  	{
  		top = top*2;
  	}
  	decl r = 0.5 * (top+bot);
  	for (decl i=0;i<FNR_MAXIT;i++)
	{
    	decl diff = bonds_price(cashflow_times, cashflow_amounts,r) - bondprice;
	    if (fabs(diff)<FNR_ACCURACY) return r;
    	if (diff>0.0)  { bot=r; }
	    else           { top=r; }
    	r = 0.5 * (top+bot);
	}
  	return r;
}
