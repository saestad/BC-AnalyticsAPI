/// <summary>
/// TODO: Unknown SteinSaestad.
/// </summary>

namespace SteinSaestad.BCAnalyticsAPI;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Account;

permissionset 50100 "Analytics API Access"
{
    Assignable = true;
    Caption = 'Analytics API Access';

    Permissions =
        tabledata "G/L Entry" = R,
        tabledata "G/L Account" = R,
        page "Sestad GL Accounts API" = X,
        page "Sestad GL Entries API" = X;
}

/*
Defines Permission Set for the Analytics API. This permission set should be assigned to any user that needs to access the API. It grants read access to the G/L Entry and G/L Account tables, as well as execute access to the API pages.

Grants:
tabledata "G/L Entry" = R - read access to the GL Entry table
tabledata "G/L Account" = R - read access to the GL Account table
page "Sestad GL Accounts API" = X - execute access to your API page
page "Sestad GL Entries API" = X - execute access to your API page

The R=Read, X=Execute
*/
