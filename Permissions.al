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