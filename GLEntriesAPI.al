namespace DefaultPublisher.BCFytBI;

using Microsoft.Finance.GeneralLedger.Ledger;

page 50102 "Sestad GL Entries API"
{
    PageType = API;
    SourceTable = "G/L Entry";
    APIPublisher = 'sestad';
    APIGroup = 'analytics';
    APIVersion = 'v1.0';
    EntityName = 'glEntry';
    EntitySetName = 'glEntries';
    ODataKeyFields = SystemId;
    Caption = 'Sestad GL Entries API';
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

                field(glAccountNo; Rec."G/L Account No.")
                { Caption = 'GL Account No'; }

                field(postingDate; Rec."Posting Date")
                { Caption = 'Posting Date'; }

                field(documentType; Rec."Document Type")
                { Caption = 'Document Type'; }

                field(documentNo; Rec."Document No.")
                { Caption = 'Document No'; }

                field(description; Rec.Description)
                { Caption = 'Description'; }

                field(amount; Rec.Amount)
                { Caption = 'Amount'; }

                field(debitAmount; Rec."Debit Amount")
                { Caption = 'Debit Amount'; }

                field(creditAmount; Rec."Credit Amount")
                { Caption = 'Credit Amount'; }

                field(dimensionSetId; Rec."Dimension Set ID")
                { Caption = 'Dimension Set ID'; }

                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                { Caption = 'Last Modified DateTime'; }
            }
        }
    }
}

// https://api.businesscentral.dynamics.com/v2.0/489cefa7-d943-4495-b847-1b9ee69b4f36/Sandbox_Env/api/sestad/analytics/v1.0/companies(a9f5a8fd-7a01-f111-a200-7ced8db390c1)/glEntries