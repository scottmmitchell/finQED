// file futures_price.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>

futures_price(decl S,                     // value of underlying
		     decl r,                     // risk free interest
		     decl time_to_maturity) {
    return exp(r*time_to_maturity)*S;
}
