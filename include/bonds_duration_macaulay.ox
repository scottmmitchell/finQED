// file bonds_duration_macaulay.cc
// author: Bernt A Oedegaard.
// calculate Macaulay duration.

#include <oxstd.h>
#include "financialNR.h"

bonds_duration_macaulay(
	const cashflow_times, const cashflows, const bond_price)
{
    decl y = bonds_yield_to_maturity(cashflow_times, cashflows, bond_price);
    return bonds_duration(cashflow_times, cashflows, y); // use YTM in duration
}
