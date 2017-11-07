// file bonds_duration_modified.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>
#include "financialNR.h"

bonds_duration_modified(
				const cashflow_times,
				const cashflow_amounts,
				const bond_price,
				const r)
{
    decl dur = bonds_duration(cashflow_times, cashflow_amounts, r);
    decl y = bonds_yield_to_maturity(cashflow_times,cashflow_amounts,
				       bond_price);
    return dur/y;
}
