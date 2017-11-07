// file bonds_price_both.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>

bonds_price_both(const coupon_times,
		    const coupon_amounts,
		    const principal_times,
		    const principal_amounts, 
		    const r) 
  // calculate bond price when term structure is flat, 
  // given both coupon and principals
{ 
	decl p = sumc(exp(-r*vec(coupon_times)).*vec(coupon_amounts));
	p += sumc(exp(-r*vec(principal_times)).*vec(principal_amounts));
    return double(p); 
}
