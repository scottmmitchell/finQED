#include "../../include/finQED.h"

static const decl CFLOW_ERROR = .NaN;	

/**
The setflow function sets the global variable cflow_amounts to the user inputted cash flows.
If no periods are specified the global variable cflow_times is set to correspond with the first cash flow being period 0
(the investment) and each subsequent cash flow being period 1,2,3...etc. If the user has inputted periods these are set to the
global variable cflow_times and a check is preformed to ensure the number of cash flows and periods are equal. The user does not have
to input times/periods in chronological order.

@example To inpute a cash flow that does not start generating income for 5 periods. All periods in-between will be given a cash flow of zero. 

setflow(<-100,500>,<0,5>) 
																															  
@param inflow User inputted cash flows 
@param times User inputted periods or given a value of zero if no periods are inputted 
**/
setflow(inflow, times = 0) {																						   
	
	 cflow_amounts = inflow;
	 if (isint(times)) 
	 		cflow_times = range(0,sizec(cflow_amounts)-1); //Periods start at zero	
	 else   	 { 
	 cflow_times = times; 
	 if (sizerc(cflow_times) != sizerc(cflow_amounts)) { 
	 println("Cash flows and periods do not match. Cannot compute PV,IRR,MIRR,Breakeven.");
	 
	   }
	 } 																													  
  }

/**
To determine the IRR of the cash flow, it is first determined if there is a unique or multiple IRRs.

@returns Either the single or mutliple IRRs 
**/
cash_flow_irr() {
 
 if (sizerc(cflow_times) != sizerc(cflow_amounts))
 return CFLOW_ERROR; 
 
 if(cash_flow_unique_irr()==1)
 return single_irr();
 else 
 return multiple_roots();
 
}

/**
Calculate the present value of cash flows using continuous discounting.
Continuous discounting always leads to a lower present value than discrete discounting.

PV = FV0 + FV1 / e^(r*1) + FV2 / e^(r*2) + ... + FVn / e^(r*n)

Where r is the interest rate and n is the number of periods. 

@param r Interest rate at which to discount future value of cash flows
@returns Present value of cash flows using continuous discounting 
**/
cash_flow_pv(r)
{
	return double(sumc(vec(cflow_amounts) .* exp(-r .* vec(cflow_times))));
}

/**
Finds a single IRR or root if it exists. An initial bracket is created discounting the cash flows at interest rates of x1 = 0% and x2 = 20%.
If f(x1) and f(x2) do not have opposite signs and the function is decreasing x1 is continually decreased or if the
function is increasing x2 is continually increased until f(x1) and f(x2) bracket zero.

Depending on which of x1 or x2 produce a negative present value that variable is equated to a new variable rtb.
A change dx (change in interest rate) which starts off as x2 - x1 if the function is increasing or x1 - x2 if the
function is decreasing is added to rtb to create x_mid (x_mid = dx + rtb). To find a root, the present value is first
calculated at the x_mid. If the present value is negative, rtb is adjusted to the x_mid. If the present value is positive
rtb does not change. The dx value is then halved and added again to rtb to create a new x_mid. 

The present value is again calculated and the process repeated until the present value or the dx value is less than the accuracy of 1.0e-6.
If the maximum number of iterations is reached 500, returns error. 																												 

@comments The present value of cash flows is calculated using continuous discounting.
**/
single_irr()	 
{
    
	decl x1 = 0.0, x2 = 0.2; //Denotes inital guesses of interest rates (r values) 
    decl f1 = cash_flow_pv(x1), f2 = cash_flow_pv(x2), i;
   
    for (i=0;i<FNR_MAXIT;i++)
	{
		if (f1*f2 < 0.0)
			break;
		if (fabs(f1)<fabs(f2))
		 	f1 = cash_flow_pv(x1+=1.6*(x1-x2));
		else
			f2 = cash_flow_pv(x2+=1.6*(x2-x1));
    }
    if (f2*f1>0.0)	return CFLOW_ERROR;
	
    decl f = cash_flow_pv(x1), rtb, dx=0;
    if (f<0.0) //Define bottom bracket which equals either x1 or x2 depending on the slope of the function.
	{	rtb = x1;	dx = x2-x1;
	}
    else
	{	rtb = x2;	dx = x1-x2;
	}
    for (decl i=0;i<FNR_MAXIT;i++)
	{
		dx *= 0.5;
		decl x_mid = rtb+dx;
		decl f_mid = cash_flow_pv(x_mid);
		if (f_mid<=0.0)
			rtb = x_mid; //rtb only changes to x_mid only if the cash flows evaluated at x_mid are less negative.
		if ( (fabs(f_mid)<FNR_ACCURACY) || (fabs(dx)<FNR_ACCURACY) )
			return x_mid;
    }
    return CFLOW_ERROR;   
}

/**
Calculates multiple IRRs using Ox's polyroots function. A polynomial of the following form (Equation 1) is sent to polyroots where n
is the number of periods and a is the cash flow for that period.   

1) a0 + a1*b + a2*b^2 + ... + an*b^n

As polyroots returns the inverse roots of the polynomial these roots are inverted to obtain both the real and imaginary
roots of the function. To find the IRRs of the cash flow, note that the present value using discrete discounted is calculated
using Equation 2.  

2) a0 + a1*(1/(1+x)) + a2*(1/(1+x))^2 + ... + an*(1/(1+x))^n

Comparing Equation 1 and Equation 2 the IRRs can be found as follows:

b = 1/(1+x) so x = 1/b - 1 

@returns Vector of real IRRs for the cash flow 
@comments Multiple IRRs are found assuming present value is calculated using discrete compounding
**/
multiple_roots() {
	decl i,roots, orderofpoly = max(cflow_times), coeffs = zeros(1,orderofpoly+1);
	coeffs[][cflow_times] = cflow_amounts;
	polyroots(coeffs,&roots);
	roots = selectifc(roots,roots[1][].==0 );
	if(sizerc(roots) == 0)
	return "There are no real roots.";
	roots = roots[0][];
	return roots = roots - 1;

	}

/**
Calculate the MIRR which assumes that positive cash flows are reinvested at the firm's reinvestment rate and
negative cash flows are discounted at the firms finance rate or cost of capital.

MIRR is calculated using the following formula:
MIRR = (sum of terminal cash flows/|investment + discounted negative cash flows|)^(1/n) - 1
where n is the number of periods. 

@param financerate The cost of borrowing (cost of capital) or interest expense in the event of negative cash flows
@param reinvestmentrate The compounding rate of return at which positive cash flow is reinvested
**/
modified_irr(financerate, reinvestmentrate) {
  decl i,mirr,terminalvalue = 0, initialinvestment = cflow_amounts[0][0], neg_cflow = 0; 
  for (i = 1;i < columns(cflow_times); i ++)	{
  if (cflow_amounts[0][i] > 0)
  terminalvalue = terminalvalue + cflow_amounts[0][i] * (1 + reinvestmentrate) ^ (cflow_times[0][columns(cflow_times)-1] - cflow_times[0][i]);
  else	 
  neg_cflow = neg_cflow + cflow_amounts[0][i]/(1+financerate)^cflow_times[0][i];

  }

  mirr =  (terminalvalue / fabs(neg_cflow + initialinvestment)) ^ (1/cflow_times[0][columns(cflow_times)-1]) - 1; 
  return mirr;
  
}	 

/**
Find the period in which then initial investment break-even by summing up the cashflows until they are greater than zero.

@returns Break-even periods of the cash flow
**/
breakeven() {

	decl count = 1, cumulativecash = cflow_amounts[0]; 
	while (cumulativecash < 0 && count < sizec(cflow_amounts)) {
	cumulativecash = cumulativecash + cflow_amounts[count];
	count++;
		
	}
		
	if (cumulativecash < 0)
	return "Does not break even";
	else
	return cflow_times[count-1]; 

}

/**
Print summary function for NPV, IRR(s), MIRR and the break even period corresponding to a set of cash flows. The finance rate and investment
rate can either be inputted or default values of 8% and 15% are used respectively.  

@param finrate The cost of borrowing (cost of capital) or interest expense in the event of negative cash flows
@param investrate The compounding rate of return at which positive cash flow is reinvested
**/
print_summary(finrate = 0.08, investrate = 0.15) {
	
  println("The NPV of the project is (default finance rate 8%): $","%5.2f",cash_flow_pv(finrate));
  println("The IRR(s) of the project is/are: ",multiple_roots());
  println("The MIRR of the project is (default finance rate 8%, reinvestment rate 15%): ","%5.2f",modified_irr(finrate,investrate),"%");
  println("The break even period is: ", breakeven());

}
	

	
 
