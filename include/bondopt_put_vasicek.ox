// file bondopt_call_vasicek.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>
#include "financialNR.h"

bond_option_price_put_zero_vasicek(decl X,  // exercise price
					   decl r, // current interest rate
					   decl option_time_to_maturity,
					   decl bond_time_to_maturity,
					   decl a,  // parameters
					   decl b,
					   decl sigma)
{
    decl s_t = bond_time_to_maturity;
    decl T_t = option_time_to_maturity;
    decl T_s = s_t-T_t;
    decl v_t_T;
    decl sigma_P;
    if (a==0.0)
	{
		v_t_T = sigma * sqrt ( T_t );
		sigma_P = sigma*T_s*sqrt(T_t);
    }
    else
	{
		v_t_T = sqrt (sigma*sigma*(1-exp(-2*a*T_t))/(2*a));
		decl B_T_s = (1-exp(-a*T_s))/a;
       sigma_P = v_t_T*B_T_s;
    }
    decl h = (1.0/sigma_P) * log (
		term_structure_discount_factor_vasicek(s_t,r,a,b,sigma)/
		(term_structure_discount_factor_vasicek(T_t,r,a,b,sigma)*X) )
		+ sigma_P/2.0;
    decl p =
		term_structure_discount_factor_vasicek(T_t,r,a,b,sigma)*probn(-h+sigma_P)
		-term_structure_discount_factor_vasicek(s_t,r,a,b,sigma)*probn(-h);
    return p;
}
