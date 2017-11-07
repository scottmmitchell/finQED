// file bondopt_call_coupon.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>
#include "financialNR.h"

bond_option_price_call_coupon_bond_black_scholes(
   decl B, decl X, decl r, decl sigma, decl time,
   const coupon_times, const coupon_amounts)
{
	// subtract present value of coupons
	decl idx = vecindex(coupon_times .<= time);
	if (sizerc(idx))
		B -= double(sumc(vec(coupon_amounts[idx]) .* exp(-r*vec(coupon_times[idx]))));
    return bond_option_price_call_zero_black_scholes(B,X,r,sigma,time);
}
