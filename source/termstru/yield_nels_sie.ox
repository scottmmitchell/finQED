// file termstru_yield_nels_sie.cc
// author: Bernt A Oedegaard
// purpose: Calculate the term structure proposed by Nelson and Siegel
// Parsimonious Modeling of Yield Curves, Journal of Business, (1987)

#include <oxstd.h>

term_structure_yield_nelson_siegel(decl t,
					  decl beta0, decl beta1, decl beta2,
					  decl lambda ) { 
   if (t==0.0) return beta0;
   decl tl = t/lambda; 
   decl r = beta0 + (beta1+beta2) * ((1-exp(-tl))/tl) + beta2 * exp(-tl);  
   return r; 
} 
