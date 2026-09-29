/**
 * @description Invocable action to compare two lists and determine matches.
 * Each list can be a semicolon-separated string, a text collection, or both.
 */
global without sharing class CompareLists {
  global class CompareListsInput {
    @InvocableVariable(
      required=false
      label='List 1'
      description='Single text value or semicolon-separated list'
    )
    global String list1;

    @InvocableVariable(
      required=false
      label='List 1 Collection'
      description='Text collection. Combined with List 1 when both are set.'
    )
    global List<String> list1Collection;

    @InvocableVariable(
      required=false
      label='List 2'
      description='Single text value or semicolon-separated list'
    )
    global String list2;

    @InvocableVariable(
      required=false
      label='List 2 Collection'
      description='Text collection. Combined with List 2 when both are set.'
    )
    global List<String> list2Collection;

    @InvocableVariable(
      required=true
      label='Exact Match?'
      description='If true, both lists must contain the same values regardless of order. If false, uses Number of Required Matches.'
    )
    global Boolean exactMatch;

    @InvocableVariable(
      required=false
      label='Number of Required Matches'
      description='Number of values that must match. Used when Exact Match is false.'
    )
    global Integer requiredMatches;
  }

  global class CompareListsOutput {
    @InvocableVariable(
      label='Is Matched'
      description='True when the exact-match or required-match condition is met'
    )
    global Boolean isMatched;

    @InvocableVariable(
      label='Number of Matches'
      description='Count of matching values found'
    )
    global Integer numberOfMatches;

    @InvocableVariable(
      label='Matching Values'
      description='Deduplicated values present in both lists'
    )
    global List<String> matchingValues;

    @InvocableVariable(
      label='Unique Values List 1'
      description='Unique values from List 1 that are not in List 2'
    )
    global List<String> uniqueList1;

    @InvocableVariable(
      label='Unique Values List 2'
      description='Unique values from List 2 that are not in List 1'
    )
    global List<String> uniqueList2;
  }

  @InvocableMethod(
    label='Compare Lists'
    description='Compares two lists. Each list can be text, a text collection, or both.'
  )
  global static List<CompareListsOutput> compareLists(
    List<CompareListsInput> inputs
  ) {
    List<CompareListsOutput> outputs = new List<CompareListsOutput>();

    for (CompareListsInput input : inputs) {
      CompareListsOutput output = new CompareListsOutput();

      Set<String> set1 = parseValues(input.list1, input.list1Collection);
      Set<String> set2 = parseValues(input.list2, input.list2Collection);

      Set<String> matches = new Set<String>();
      for (String value : set1) {
        if (set2.contains(value)) {
          matches.add(value);
        }
      }

      List<String> matchingValuesList = new List<String>(matches);
      matchingValuesList.sort();
      output.matchingValues = matchingValuesList;
      output.numberOfMatches = matches.size();

      Set<String> uniqueSet1 = new Set<String>(set1);
      uniqueSet1.removeAll(set2);
      List<String> uniqueList1 = new List<String>(uniqueSet1);
      uniqueList1.sort();
      output.uniqueList1 = uniqueList1;

      Set<String> uniqueSet2 = new Set<String>(set2);
      uniqueSet2.removeAll(set1);
      List<String> uniqueList2 = new List<String>(uniqueSet2);
      uniqueList2.sort();
      output.uniqueList2 = uniqueList2;

      if (input.exactMatch) {
        output.isMatched =
          set1.size() == set2.size() &&
          matches.size() == set1.size();
      } else {
        Integer needed = input.requiredMatches == null
          ? 0
          : input.requiredMatches;
        output.isMatched = matches.size() >= needed;
      }

      outputs.add(output);
    }

    return outputs;
  }

  private static Set<String> parseValues(
    String inputString,
    List<String> inputValues
  ) {
    Set<String> result = new Set<String>();
    addText(result, inputString);
    if (inputValues != null) {
      for (String value : inputValues) {
        addItem(result, value);
      }
    }
    return result;
  }

  private static void addText(Set<String> result, String inputString) {
    if (String.isBlank(inputString)) {
      return;
    }
    for (String item : inputString.split(';')) {
      addItem(result, item);
    }
  }

  private static void addItem(Set<String> result, String item) {
    if (String.isBlank(item)) {
      return;
    }
    result.add(item.trim());
  }
}
