// file cflow_pv_discrete.cc
// author: Bernt Arne Oedegaard.
// calculate the present value of a stream of cash flows using discrete compounding 

#include <oxstd.h>

cash_flow_pv_discrete(const cflow_times, const cflow_amounts, decl r)
{
	return double(sumc(vec(cflow_amounts) ./ ((1+r) .^ vec(cflow_times))));
}
