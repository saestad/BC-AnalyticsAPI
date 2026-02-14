# Analytics API by Saestad

An AL extension for Microsoft Dynamics 365 Business Central that exposes clean, analytics-optimised API endpoints for use with Power BI. Built as the data layer for a modern BC reporting product — a fast, beautiful alternative to legacy BC reporting tools like BI4Dynamics.

---

## Overview

Analytics API by Saestad replaces slow OData web service endpoints with purpose-built API pages designed specifically for reporting and analytics. It extracts key financial and operational data from Business Central and serves it through versioned REST endpoints that connect directly to Power BI or an Azure SQL staging layer.

Built on BC API v2.0 architecture, this extension is fully compatible with Microsoft's OData deprecation roadmap (effective 2027 Wave 1) — making it future-proof from day one.

---

## Features

- Custom API pages built on BC API v2.0 architecture
- Future-proof — fully aligned with Microsoft's OData deprecation roadmap
- Incremental refresh support via `lastModifiedDateTime` on all endpoints
- Optimised field selection — only exposes what reporting needs
- Versioned endpoints (`v1.0`) for safe iterative development
- Clean namespace and permission set structure ready for AppSource

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
- Access to a Microsoft Dynamics 365 Business Central environment (Sandbox recommended)
- Microsoft Power BI Desktop (for report development)

### Installation

1. Clone this repository
```bash
git clone https://github.com/saestad/BC-AnalyticsAPI.git
cd BC-AnalyticsAPI
```

2. Open the folder in VS Code
```bash
code .
```

3. Copy the example launch config and fill in your environment details:
```bash
cp .vscode/launch.json.example .vscode/launch.json
```

Edit `.vscode/launch.json` with your own values:
```jsonc
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "BC-AnalyticsAPI Sandbox",
            "request": "launch",
            "type": "al",
            "tenant": "{COMPANY TENANT ID}",
            "environmentType": "{ENVIRONMENT TYPE}",
            "environmentName": "{ENVIRONMENT NAME}",
            "startupObjectId": 22,
            "startupObjectType": "Page",
            "breakOnError": "All",
            "launchBrowser": true,
            "enableLongRunningSqlStatements": true,
            "enableSqlInformationDebugger": true
        }
    ]
}
```

> **Note:** `launch.json` is listed in `.gitignore` and will never be committed. Your tenant ID stays local only.

4. Update `app.json` platform and application version to match your BC environment version if needed

5. Download symbols
```
Ctrl+Shift+P → AL: Download Symbols
```

6. Publish to your sandbox
```
F5
```

---

## Authentication

The API uses OAuth 2.0 with Azure Active Directory. You will need to register an Azure AD app with the following configuration:

- **API Permission**: Dynamics 365 Business Central → Delegated → `Financials.ReadWrite.All`
- **Redirect URI**: Your application callback URL
- **Grant Type**: Authorization Code

For local testing with Postman:

| Field | Value |
|---|---|
| Auth URL | `https://login.microsoftonline.com/{tenantId}/oauth2/v2.0/authorize` |
| Access Token URL | `https://login.microsoftonline.com/{tenantId}/oauth2/v2.0/token` |
| Scope | `https://api.businesscentral.dynamics.com/.default` |
| Grant Type | Authorization Code |

---

## Connecting to Power BI

1. Open Power BI Desktop
2. Get Data → OData Feed
3. Enter your endpoint URL, for example:
```
https://api.businesscentral.dynamics.com/v2.0/{tenantId}/{environment}/api/sestad/analytics/v1.0/companies({companyId})/glAccounts
```
4. Select **Organizational Account** and sign in with your BC credentials
5. Load and repeat for each endpoint

### Recommended Relationships in Power BI

```
glEntries[glAccountNo] → glAccounts[no]   (Many to One)
```

### Useful Query Filters

Limit GL Entries during development by appending a date filter:
```
/glEntries?$filter=postingDate ge 2024-01-01
```

Limit results for testing:
```
/glEntries?$top=100
```

---

## Project Structure

```
BC-AnalyticsAPI/
├── .vscode/
│   ├── launch.json              # Local only — never committed (see .gitignore)
│   └── launch.json.example      # Template — copy this to launch.json
├── app.json                     # Extension manifest and versioning
├── GLAccountsAPI.al             # G/L Account API page
├── GLEntriesAPI.al              # G/L Entry API page
├── Permissions.al               # Permission set for API access
└── .gitignore                   # Excludes launch.json, .alpackages, *.app
```

---

## Object ID Range

| From | To |
|---|---|
| 50100 | 50149 |

---

## Versioning

This extension follows semantic versioning. The current API version is `v1.0`.

Breaking changes will result in a new API version (`v2.0`) while maintaining backwards compatibility on existing versions. The AL extension version in `app.json` follows `major.minor.patch.build` format.

---

## Roadmap

- [x] GL Accounts endpoint
- [x] GL Entries endpoint
- [ ] GL Budget Entries endpoint
- [ ] Dimension Set Entries endpoint
- [ ] Customer and Vendor endpoints
- [ ] Item Ledger Entries endpoint
- [ ] Azure SQL staging pipeline
- [ ] Azure Function sync scheduler
- [ ] Power BI template pack — P&L report
- [ ] Power BI template pack — Sales analytics
- [ ] Power BI template pack — Aged receivables
- [ ] AppSource packaging and submission

---

## Security

- `launch.json` is excluded via `.gitignore` — your tenant ID never leaves your machine
- Use `.vscode/launch.json.example` as a template — it contains only placeholders
- Never commit `.alpackages/` — large compiled symbols not needed in source control
- Source code protection is enabled — `allowDownloadingSource` and `includeSourceInSymbolFile` are set to `false` in `app.json`

---

## Author

**Stein Sæstad**
[saestad.no](https://saestad.no)

---

## License

Proprietary — All rights reserved. © 2026 Stein Sæstad