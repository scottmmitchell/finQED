// file: simulate_underlying_sequence.cc

#include <oxstd.h>

simulate_price_sequence(decl S, 		// current value of underlying
			     		decl r,  		// interest rate
			     		decl sigma,  	// volatitily 
			     		decl time,  	// time to final date
			     		decl no_steps)  // number of steps 
{
    decl delta_t = time / no_steps;
    decl R = (r - 0.5 * sqr(sigma)) * delta_t;
    decl SD = sigma * sqrt(delta_t);
	return S * cumprod(exp(R + SD * rann(no_steps, 1)))';
}
