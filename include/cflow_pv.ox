// file cflow_pv.cc
// author: Bernt Arne Oedegaard.
 
#include <oxstd.h>

cash_flow_pv(const cflow_times, const cflow_amounts, decl r)
{
    // calculate present value of cash flow, continous discounting
	return double(sumc(vec(cflow_amounts) .* exp(-r .* vec(cflow_times))));
}
