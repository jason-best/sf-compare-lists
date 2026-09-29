# Flow configuration

Add Apex action **Compare Lists**. Each run compares one pair of lists.

## Action name

| Install method | Flow action |
|----------------|-------------|
| Unlocked package | **Compare Lists** (`three_levers.CompareLists`) |
| Deploy from source | **Compare Lists** (`CompareLists`) |

## Compare two lists

1. Set **Exact Match?** to true when the lists must contain the same values, ignoring order.
2. Pass each list as **List 1** / **List 2** (text), **List 1 Collection** / **List 2 Collection**, or both on the same side.
3. When Exact Match is false, set **Number of Required Matches**.
4. Use **Matching Values**, **Unique Values List 1**, and **Unique Values List 2**.

A text value may be one item or several items separated by semicolons. A collection item is one value, even if it contains a semicolon. When text and a collection are both set on the same side, the action combines them.

Leave the second list empty and read **Unique Values List 1** when you only want the distinct values of the first list.

## Inputs

| Input | Required | Notes |
|-------|----------|--------|
| List 1 | No | One value, or several separated by semicolons |
| List 1 Collection | No | Text collection. Combined with List 1 when both are set |
| List 2 | No | Same as List 1 |
| List 2 Collection | No | Same as List 1 Collection |
| Exact Match? | Yes | True when both lists must contain the same values, ignoring order |
| Number of Required Matches | No | Used when Exact Match is false. A blank number is treated as zero |

## Outputs

| Output | Notes |
|--------|--------|
| Is Matched | True when the exact-match or required-match condition is met |
| Number of Matches | Count of values present in both lists |
| Matching Values | Those shared values, sorted |
| Unique Values List 1 | Values in List 1 that are not in List 2 |
| Unique Values List 2 | Values in List 2 that are not in List 1 |

Spaces around a value are removed. Blank values are dropped. Duplicates count once. `Red` and `red` are different values.
