/// <summary>
/// TODO: Unknown SteinSaestad.
/// </summary>

namespace SteinSaestad.BCAnalyticsAPI;

using Microsoft.Finance.GeneralLedger.Budget;

page 50104 "Sestad GL Budget Entries API"
{
    PageType = API;
    SourceTable = "G/L Budget Entry";
    APIPublisher = 'sestad';
    APIGroup = 'analytics';
    APIVersion = 'v1.0';
    EntityName = 'glBudgetEntry';
    EntitySetName = 'glBudgetEntries';
    ODataKeyFields = SystemId;
    Caption = 'Sestad GL Budget Entries API';
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

                field(entryNo; Rec."Entry No.")
                { Caption = 'Entry No'; }

                field(budgetName; Rec."Budget Name")
                { Caption = 'Budget Name'; }

                field(glAccountNo; Rec."G/L Account No.")
                { Caption = 'GL Account No'; }

                field(date; Rec.Date)
                { Caption = 'Date'; }

                field(amount; Rec.Amount)
                { Caption = 'Amount'; }

                field(description; Rec.Description)
                { Caption = 'Description'; }

                field(dimensionSetId; Rec."Dimension Set ID")
                { Caption = 'Dimension Set ID'; }

                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                { Caption = 'Last Modified DateTime'; }
            }
        }
    }
}