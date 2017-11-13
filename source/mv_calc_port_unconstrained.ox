// file mv_calc_port_unconstrained.cc
// author: Bernt A Oedegaard

#include <oxstd.h>
#include "financialNR.h"

mv_calculate_portfolio_given_mean_unconstrained(const e, const V, const r)
{
    decl Vinv = invertsym(V);  // inverse of V
    decl a = sumc(Vinv*e);
    decl b = e'*Vinv*e;
    decl c = sumr(sumc(Vinv));
    decl d = b*c - a*a;
    decl Vinv1=sumr(Vinv);
    decl Vinve=Vinv*e;
    decl g = (Vinv1*b - Vinve*a)/d;
    decl h = (Vinve*c - Vinv1*a)/d;
    return g + h*r;
}
