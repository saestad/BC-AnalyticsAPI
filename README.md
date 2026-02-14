# Analytics API by Saestad

An AL extension for Microsoft Dynamics 365 Business Central that exposes analytics-optimised API endpoints for Power BI reporting.

## Overview

This extension provides purpose-built API pages for reporting and analytics in Business Central. Instead of relying on OData web service endpoints (which Microsoft is deprecating in 2027 Wave 1), it uses BC API v2.0 architecture to serve financial and operational data through versioned REST endpoints.

Data can be consumed directly in Power BI or routed through an Azure SQL staging layer for larger deployments.

## Features

- Built on BC API v2.0
- Compatible with Microsoft's OData deprecation roadmap (2027 Wave 1)
- Incremental refresh support via `lastModifiedDateTime` on all endpoints
- Only exposes fields needed for reporting
- Versioned endpoints (`v1.0`)
- Permission set included, ready for AppSource

## API Endpoints

Base URL:

```
https://api.businesscentral.dynamics.com/v2.0/{tenantId}/{environment}/api/sestad/analytics/v1.0/companies({companyId})/
```

### Available

| Endpoint | Source Table | Description |
|---|---|---|
| `/glAccounts` | G/L Account | Chart of accounts with categories |
| `/glEntries` | G/L Entry | Posted GL transactions with dimension set IDs |

### Planned

| Endpoint | Source Table | Description |
|---|---|---|
| `/glBudgetEntries` | G/L Budget Entry | Budget figures for vs actuals reporting |
| `/dimensionSetEntries` | Dimension Set Entry | Decodes department and cost center dimensions |
| `/customers` | Customer | Customer master data |
| `/vendors` | Vendor | Vendor master data |
| `/itemLedgerEntries` | Item Ledger Entry | Inventory movements |

## Getting Started

### Prerequisites

- Visual Studio Code with AL Language extension
- Access to a Business Central environment (Sandbox recommended)
- Power BI Desktop

### Setup

1. Clone the repo
```bash
git clone https://github.com/saestad/BC-AnalyticsAPI.git
cd BC-AnalyticsAPI
```

2. Copy the launch config template
```bash
cp .vscode/launch.json.example .vscode/launch.json
```

3. Fill in your environment details in `launch.json`
```jsonc
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "BC-AnalyticsAPI Sandbox",
            "request": "launch",
            "type": "al",
            "tenant": "{COMPANY TENANT ID}",            // Tenant ID of the company you are connecting to
            "environmentType": "{ENVIRONMENT TYPE}",    // "Sandbox", "Production", "OnPrem", "W1"..
            "environmentName": "{ENVIRONMENT NAME}",    // Name of the environment that tenant is under
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

`launch.json` is in `.gitignore` and will not be committed. Your tenant ID stays local.

4. Download symbols
```
Ctrl+Shift+P -> AL: Download Symbols
```

5. Publish
```
F5
```

## Authentication

The API requires OAuth 2.0 via Azure Active Directory. Register an Azure AD app with:

- **Permission**: Dynamics 365 Business Central / Delegated / `Financials.ReadWrite.All`
- **Redirect URI**: Your callback URL
- **Grant Type**: Authorization Code

Postman settings for local testing:

| Field | Value |
|---|---|
| Auth URL | `https://login.microsoftonline.com/{tenantId}/oauth2/v2.0/authorize` |
| Access Token URL | `https://login.microsoftonline.com/{tenantId}/oauth2/v2.0/token` |
| Scope | `https://api.businesscentral.dynamics.com/.default` |
| Grant Type | Authorization Code |

## Connecting to Power BI

1. Open Power BI Desktop
2. Get Data -> OData Feed
3. Enter your endpoint URL:
```
https://api.businesscentral.dynamics.com/v2.0/{tenantId}/{environment}/api/sestad/analytics/v1.0/companies({companyId})/glAccounts
```
4. Sign in with Organizational Account using your BC credentials
5. Repeat for each endpoint

### Relationships

```
glEntries[glAccountNo] -> glAccounts[no]   (Many to One)
```

### Filtering

Filter by date to limit data during development:
```
/glEntries?$filter=postingDate ge 2024-01-01
```

Limit rows for testing:
```
/glEntries?$top=100
```

## Project Structure

```
BC-AnalyticsAPI/
├── .vscode/
│   ├── launch.json              # Local only, not committed
│   └── launch.json.example      # Copy this to launch.json
├── app.json                     # Extension manifest
├── GLAccountsAPI.al             # G/L Account API page
├── GLEntriesAPI.al              # G/L Entry API page
├── Permissions.al               # Permission set
└── .gitignore
```

## Object ID Range

| From | To |
|---|---|
| 50100 | 50149 |

## Versioning

API version is `v1.0`. Breaking changes will bump to `v2.0` while keeping `v1.0` working. Extension versioning follows `major.minor.patch.build` in `app.json`.

## Roadmap

- [x] GL Accounts endpoint
- [x] GL Entries endpoint
- [ ] GL Budget Entries endpoint
- [ ] Dimension Set Entries endpoint
- [ ] Customer and Vendor endpoints
- [ ] Item Ledger Entries endpoint
- [ ] Azure SQL staging pipeline
- [ ] Azure Function sync scheduler
- [ ] Power BI template pack - P&L
- [ ] Power BI template pack - Sales
- [ ] Power BI template pack - Aged receivables
- [ ] AppSource submission

## Security

- `launch.json` is gitignored. Tenant ID stays on your machine.
- Use `launch.json.example` as the setup template.
- `.alpackages/` is gitignored. No compiled symbols in source control.
- `allowDownloadingSource` and `includeSourceInSymbolFile` are set to `false` in `app.json`.

## Author

**Stein Saestad**
[saestad.no](https://saestad.no)

## License

Proprietary. All rights reserved. 2026 Stein Saestad