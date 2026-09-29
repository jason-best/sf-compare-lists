# Installation

## Option A — Install unlocked package (recommended)

**Version:** `0.1.0-1` (released)  
**Subscriber package version Id:** `04tgL000000WV0fQAG`

| Org type | Install URL |
|----------|-------------|
| Production | https://login.salesforce.com/packaging/installPackage.apexp?p0=04tgL000000WV0fQAG |
| Sandbox | https://test.salesforce.com/packaging/installPackage.apexp?p0=04tgL000000WV0fQAG |

CLI:

```bash
sf package install --package 04tgL000000WV0fQAG --target-org <alias>
```

No installation key. After install, add Flow action **Compare Lists** (`three_levers.CompareLists`).

## Option B — Deploy from source

### Namespaced scratch org (matches package)

```bash
sf org create scratch --definition-file config/project-scratch-def.json --alias compare-lists-scratch --set-default
sf project deploy start --manifest manifest/package.xml --target-org compare-lists-scratch --test-level RunLocalTests
```

### Unpackaged deploy (no namespace)

Remove or omit `"namespace"` in `sfdx-project.json`, then deploy to your dev org:

```bash
sf project deploy start --manifest manifest/package.xml --target-org <alias> --test-level RunLocalTests
```

The Flow action class is `CompareLists`. In a subscriber org that installed the package, Flow Builder shows it only because the class, invocable method, and invocable variables are `global`.

## Post-install

Open Flow Builder and search for **Compare Lists**. No Sites or Named Credentials.

## Upgrade

Install a newer package version from the [README](../README.md#install-package) or redeploy from source.
