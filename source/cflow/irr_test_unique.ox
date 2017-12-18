﻿// file cflow_irr_test_unique.cc
// author Bernt A Oedegaard

#include <oxstd.h>

/**
Determines the number of sign changes in the cash flows. This function creates two new variables by vectorizing the cash
flows with one excluding the first entry and the other excluding the last entry. This is done to create two offset vectors to compare
entry 1 with entry 2, entry 2 with entry 3, etc. Starting with the first entry, it determines if the first entry is positive and the next
entry negative or if the first entry is negative and the next entry positive, until moving on to entry two. Using the logical dot-OR
expression the two vectors return a single vector of zeros and ones. An entry is 1 if one of these conditions is true or 0 if both conditions
are false. The column of this vector is summed to determine the number of sign changes in the cash flow. 

@param v Column of cash flows or column of cumulative cash flow
@returns Number of sign changes in the cash flow or cumulative cash flow
**/
count_sign_changes(v)
{
	decl c = sizerc(v);	
	if (c <= 1)
		return 0;
	decl v1 = vec(v)[1 : ];	//Vector excluding first entry 
	decl v2 = vec(v)[: c-2]; //Vector excluding last entry  
	return int(sumc(v1 .< 0 .&& v2 .>= 0 .|| v1 .>= 0 .&& v2 .< 0));
}
	
/**
Test whether the cash flow has multiple IRRs. According to Descartes’ rule of signs there can be as many different IRRs as there
are changes in the sign of cash flows. This rule is first checked by calling Count Sign Changes. If there is no sign changes the
function returns false and if the function has one sign change returns true. If there is more than 1 sign change, Nordstrom’s criterion
is checked, which evaluates the number of sign changes in the cumulative cash flow.

@returns One if the cash flow has a unique IRR, zero otherwise.   
**/
 cash_flow_unique_irr()
{

    decl sign_changes = count_sign_changes(cflow_amounts);
    if (sign_changes == 0) return FALSE;  //Can not find any irr
    if (sign_changes == 1) return TRUE;	  //Unique IRR 

    sign_changes = count_sign_changes(cumulate(vec(cflow_amounts))); //Check the aggregate cash flows, due to Nordstrom’s criterion
    return sign_changes <= 1; //If sign changes greater than 1 return 0 IRR not unique

}
  


