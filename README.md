# BC-AnalyticsAPI — Business Central Analytics API

An AL extension for Microsoft Dynamics 365 Business Central that exposes clean, analytics-optimised API endpoints for use with Power BI. Built as the data layer for the FytBI reporting product — a modern, fast, and beautifully designed alternative to legacy BC reporting tools.

---

## Overview

BC-AnalyticsAPI replaces slow OData web service endpoints with purpose-built API pages designed specifically for reporting and analytics. It extracts key financial and operational data from Business Central and serves it through versioned REST endpoints that connect directly to Power BI or an Azure SQL staging layer.

---

## Features

- Custom API pages built on BC API v2.0 architecture
- Future-proof — fully compatible with Microsoft's OData deprecation roadmap (2027 Wave 1)
- Incremental refresh support via `lastModifiedDateTime` on all endpoints
- Optimised field selection — only exposes what reporting needs
- Versioned endpoints (`v1.0`) for safe iterative development
- Covers GL Accounts, GL Entries, and more to come

---

## API Endpoints

All endpoints follow this base URL pattern:

```
https://api.businesscentral.dynamics.com/v2.0/{tenantId}/{environment}/api/sestad/analytics/v1.0/companies({companyId})/
```

### Available Endpoints

| Endpoint | Source Table | Description |
|---|---|---|
| `/glAccounts` | G/L Account | Chart of accounts with categories and classifications |
| `/glEntries` | G/L Entry | Posted GL transactions with dimension set IDs |

### Coming Soon

| Endpoint | Source Table | Description |
|---|---|---|
| `/glBudgetEntries` | G/L Budget Entry | Budget figures for vs actuals reporting |
| `/dimensionSetEntries` | Dimension Set Entry | Dimension decoding for department/cost center |
| `/customers` | Customer | Customer master data |
| `/vendors` | Vendor | Vendor master data |
| `/itemLedgerEntries` | Item Ledger Entry | Inventory movements |

---

## Getting Started

### Prerequisites

- Visual Studio Code
- AL Language extension for VS Code
- Access to a Microsoft Dynamics 365 Business Central environment
- Microsoft Power BI Desktop (for report development)

### Installation

1. Clone this repository
```bash
git clone https://github.com/yourusername/BC-AnalyticsAPI.git
```

2. Open the folder in VS Code
```bash
code BC-AnalyticsAPI
```

3. Update `.vscode/launch.json` with your environment details:
```jsonc
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "BC-AnalyticsAPI",
            "request": "launch",
            "type": "al",
            "environmentType": "Sandbox",
            "environmentName": "YOUR_ENVIRONMENT_NAME",
            "startupObjectId": 22,
            "startupObjectType": "Page",
            "breakOnError": "All",
            "launchBrowser": true
        }
    ]
}
```

4. Update `app.json` platform and application version to match your BC environment version

5. Download symbols
```
Ctrl+Shift+P → AL: Download Symbols
```

6. Publish to your environment
```
F5
```

---

## Authentication

The API uses OAuth 2.0 with Azure Active Directory. You will need to register an Azure AD app with the following configuration:

- **API Permission**: Dynamics 365 Business Central → Delegated → `Financials.ReadWrite.All`
- **Redirect URI**: Your application callback URL
- **Grant Type**: Authorization Code

---

## Connecting to Power BI

1. Open Power BI Desktop
2. Get Data → OData Feed
3. Enter your endpoint URL, for example:
```
https://api.businesscentral.dynamics.com/v2.0/{tenantId}/{environment}/api/sestad/analytics/v1.0/companies({companyId})/glAccounts
```
4. Authenticate with Organizational Account using your BC credentials
5. Load and repeat for each endpoint you need

### Recommended Relationships in Power BI

```
glEntries[glAccountNo] → glAccounts[no]   (Many to One)
```

### Useful Filters

Limit GL Entries during development by appending a date filter to the URL:
```
/glEntries?$filter=postingDate ge 2024-01-01
```

---

## Project Structure

```
BC-AnalyticsAPI/
├── .vscode/
│   └── launch.json          # Environment connection config
├── app.json                 # Extension manifest and versioning
├── GLAccountsAPI.al         # G/L Account API page
├── GLEntriesAPI.al          # G/L Entry API page
└── Permissions.al           # Permission set for API access
```

---

## Object ID Range

This extension uses the following object ID range:

| From | To |
|---|---|
| 50100 | 50149 |

---

## Versioning

This extension follows semantic versioning. The current API version is `v1.0`. Breaking changes will result in a new API version (`v2.0`) while maintaining backwards compatibility on existing versions.

---

## Roadmap

- [ ] GL Budget Entries endpoint
- [ ] Dimension Set Entries endpoint  
- [ ] Customer and Vendor endpoints
- [ ] Item Ledger Entries endpoint
- [ ] Azure SQL staging pipeline
- [ ] Power BI template pack — P&L report
- [ ] Power BI template pack — Sales analytics
- [ ] Power BI template pack — Aged receivables
- [ ] AppSource packaging and submission

---

## Contributing

This project is in active early development. Contributions, issues, and feature requests are welcome.

---

## Author

**Stein Sæstad**  
Egersund, Norway  
[fyt.no](https://fyt.no)

---

## License

Proprietary — All rights reserved. © 2026 Stein Sæstad
