/// <summary>
/// TODO: Unknown SteinSaestad.
/// </summary>

namespace SteinSaestad.BCAnalyticsAPI;

using Microsoft.Finance.GeneralLedger.Account;



page 50101 "Sestad GL Accounts API"
{
    PageType = API;
    SourceTable = "G/L Account";
    APIPublisher = 'sestad';
    APIGroup = 'analytics';
    APIVersion = 'v1.0';
    EntityName = 'glAccount';
    EntitySetName = 'glAccounts';
    ODataKeyFields = SystemId;
    Caption = 'Sestad GL Accounts API';
    Editable = false;
    ChangeTrackingAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                { Caption = 'System Id'; }

                field(no; Rec."No.")
                { Caption = 'No'; }

                field(name; Rec.Name)
                { Caption = 'Name'; }

                field(accountType; Rec."Account Type")
                { Caption = 'Account Type'; }

                field(accountCategory; Rec."Account Category")
                { Caption = 'Account Category'; }

                field(incomeBalance; Rec."Income/Balance")
                { Caption = 'Income Balance'; }

                field(indentation; Rec.Indentation)
                { Caption = 'Indentation'; }

                field(blocked; Rec.Blocked)
                { Caption = 'Blocked'; }

                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                { Caption = 'Last Modified DateTime'; }
            }
        }
    }
}

// https://api.businesscentral.dynamics.com/v2.0/489cefa7-d943-4495-b847-1b9ee69b4f36/Sandbox_Env/api/sestad/analytics/v1.0/companies(a9f5a8fd-7a01-f111-a200-7ced8db390c1)/glAccounts
// 