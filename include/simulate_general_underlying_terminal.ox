// file simulate_underlying_terminal.cc 

#include <oxstd.h>

simulate_terminal_price(decl S,  	// current value of underlying
			       		decl r,  	// interest rate
			       		decl sigma, // volatitily 
			       		decl time)  // time to final date
{
    decl R = (r - 0.5 * sqr(sigma)) * time;
    decl SD = sigma * sqrt(time);
    return S * exp(R + SD * rann(1,1));
}
