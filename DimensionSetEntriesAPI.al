/// <summary>
/// TODO: Unknown SteinSaestad.
/// </summary>

namespace SteinSaestad.BCAnalyticsAPI;

using Microsoft.Finance.Dimension;

page 50103 "Sestad Dimension Set Entry API"
{
    PageType = API;
    SourceTable = "Dimension Set Entry";
    APIPublisher = 'sestad';
    APIGroup = 'analytics';
    APIVersion = 'v1.0';
    EntityName = 'dimensionSetEntry';
    EntitySetName = 'dimensionSetEntries';
    ODataKeyFields = SystemId;
    Caption = 'Sestad Dimension Set Entry API';
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

                field(dimensionSetId; Rec."Dimension Set ID")
                { Caption = 'Dimension Set ID'; }

                field(dimensionCode; Rec."Dimension Code")
                { Caption = 'Dimension Code'; }

                field(dimensionValueCode; Rec."Dimension Value Code")
                { Caption = 'Dimension Value Code'; }

                field(dimensionValueName; Rec."Dimension Value Name")
                { Caption = 'Dimension Value Name'; }

                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                { Caption = 'Last Modified DateTime'; }
            }
        }
    }
}