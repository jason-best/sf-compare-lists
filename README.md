# Compare Lists

Compare Lists for Salesforce. A Flow action that compares two text lists and returns what they share and what each list has alone. Each list can be a text value, a text collection, or both.

Product page: [threelevers.com/projects/compare-lists](https://threelevers.com/projects/compare-lists)

[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](LICENSE)
[![Salesforce API](https://img.shields.io/badge/Salesforce_API-65.0-00A1E0)](https://developer.salesforce.com)

---

## Features

- Flow action **Compare Lists**
- Each side accepts a semicolon-separated string, a text collection, or both
- Exact match, or a minimum number of shared values
- Matching values, plus the values that appear in only one list
- Trims spaces, drops blanks, and removes duplicates
- **Unlocked 2GP package** — install in any org

Matching is case-sensitive. `Red` and `red` stay as two values.

---

## Quick start

1. **Install** the unlocked package ([Install](#install-package)) or [deploy from source](docs/INSTALL.md).
2. In a Flow, add the action **Compare Lists**.
3. Pass List 1 and List 2 as text, a collection, or both.
4. Use **Matching Values**, **Unique Values List 1**, or **Unique Values List 2**.

See [Flow configuration](docs/FLOW.md).

---

## Install package

**Version `0.1.0-1` (released)** · Subscriber version Id `04tgL000000WV0fQAG`

| Org | URL |
|-----|-----|
| Production | https://login.salesforce.com/packaging/installPackage.apexp?p0=04tgL000000WV0fQAG |
| Sandbox | https://test.salesforce.com/packaging/installPackage.apexp?p0=04tgL000000WV0fQAG |

```bash
sf package install --package 04tgL000000WV0fQAG --target-org <alias>
```

After install, the Flow action is **Compare Lists** (`three_levers.CompareLists`).

**Deploy from source:** [docs/INSTALL.md](docs/INSTALL.md)

---

## Requirements

- Salesforce with Flow (API 65.0 source)
- No Sites or Named Credentials

---

## Development

```bash
sf org create scratch --definition-file config/project-scratch-def.json --alias compare-lists-scratch --set-default
sf project deploy start --manifest manifest/package.xml --target-org compare-lists-scratch --test-level RunLocalTests
```

Packaging and 2GP releases are maintained in the private [ThreeLeversDevOrg](https://github.com/jason-best/ThreeLeversDevOrg) monorepo. Source and docs: [jason-best/sf-compare-lists](https://github.com/jason-best/sf-compare-lists). See [docs/PACKAGING.md](docs/PACKAGING.md).

---

## License

[BSD 3-Clause](LICENSE) · Copyright Three Levers

---

## Support

Questions or consulting: [threelevers.com/contact](https://threelevers.com/contact/)
