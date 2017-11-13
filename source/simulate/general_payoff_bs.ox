// file simulate_general_payoff_bs.cc

#include <oxstd.h>

payoff_european_call(const price, const X)
{
    return max(0.0,price-X);
}
payoff_european_put(const price, const X)
{
    return max(0.0,X-price);
}
