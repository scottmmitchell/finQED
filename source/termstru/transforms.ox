// file termstru_transforms.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

term_structure_yield_from_discount_factor(decl dfact, decl t) {
    return (-log(dfact)/t); 
}

term_structure_discount_factor_from_yield(decl r, decl t) {
    return exp(-r*t);
}

term_structure_forward_rate_from_disc_facts(decl d_t, decl d_T,
						   decl time) {
    return (log (d_t/d_T))/time;
}

term_structure_forward_rate_from_yields(decl r_t1, decl r_T, 
					       decl t1, decl T) { 
    return (r_T*(T/(T-t1))-r_t1*(t1/T));
}
