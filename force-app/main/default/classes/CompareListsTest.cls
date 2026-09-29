/**
 * @description Test class for CompareLists invocable action.
 */
@IsTest
private class CompareListsTest {
  @IsTest
  static void stringInputsMatchExistingBehavior() {
    CompareLists.CompareListsInput input = new CompareLists.CompareListsInput();
    input.list1 = ' apple ; banana ; apple ';
    input.list2 = 'banana;apple';
    input.exactMatch = true;

    CompareLists.CompareListsOutput result = compare(input);

    System.assertEquals(true, result.isMatched);
    System.assertEquals(2, result.numberOfMatches);
    System.assertEquals(
      new List<String>{ 'apple', 'banana' },
      result.matchingValues
    );
    System.assertEquals(0, result.uniqueList1.size());
    System.assertEquals(0, result.uniqueList2.size());
  }

  @IsTest
  static void collectionsMatchRegardlessOfOrder() {
    CompareLists.CompareListsInput input = new CompareLists.CompareListsInput();
    input.list1Collection = new List<String>{
      'cherry',
      'apple',
      ' apple ',
      ''
    };
    input.list2Collection = new List<String>{ 'apple', 'cherry' };
    input.exactMatch = true;

    CompareLists.CompareListsOutput result = compare(input);

    System.assertEquals(true, result.isMatched);
    System.assertEquals(
      new List<String>{ 'apple', 'cherry' },
      result.matchingValues
    );
  }

  @IsTest
  static void stringAndCollectionOnTheSameListAreCombined() {
    CompareLists.CompareListsInput input = new CompareLists.CompareListsInput();
    input.list1 = 'apple;banana';
    input.list1Collection = new List<String>{ 'cherry' };
    input.list2Collection = new List<String>{ 'cherry', 'banana', 'apple' };
    input.exactMatch = true;

    CompareLists.CompareListsOutput result = compare(input);

    System.assertEquals(true, result.isMatched);
    System.assertEquals(3, result.numberOfMatches);
  }

  @IsTest
  static void stringComparedWithCollection() {
    CompareLists.CompareListsInput input = new CompareLists.CompareListsInput();
    input.list1 = 'apple;banana';
    input.list2Collection = new List<String>{ 'apple', 'grape' };
    input.exactMatch = false;
    input.requiredMatches = 1;

    CompareLists.CompareListsOutput result = compare(input);

    System.assertEquals(true, result.isMatched);
    System.assertEquals(new List<String>{ 'apple' }, result.matchingValues);
    System.assertEquals(new List<String>{ 'banana' }, result.uniqueList1);
    System.assertEquals(new List<String>{ 'grape' }, result.uniqueList2);
  }

  @IsTest
  static void blankSecondListReturnsDistinctValuesFromFirst() {
    CompareLists.CompareListsInput input = new CompareLists.CompareListsInput();
    input.list1Collection = new List<String>{ 'red', ' blue ', 'red', null };
    input.exactMatch = true;

    CompareLists.CompareListsOutput result = compare(input);

    System.assertEquals(false, result.isMatched);
    System.assertEquals(new List<String>{ 'blue', 'red' }, result.uniqueList1);
    System.assertEquals(0, result.matchingValues.size());
  }

  @IsTest
  static void requiredMatchCountCanFail() {
    CompareLists.CompareListsInput input = new CompareLists.CompareListsInput();
    input.list1Collection = new List<String>{ 'apple' };
    input.list2 = 'apple;banana';
    input.exactMatch = false;
    input.requiredMatches = 2;

    CompareLists.CompareListsOutput result = compare(input);

    System.assertEquals(false, result.isMatched);
    System.assertEquals(1, result.numberOfMatches);
  }

  private static CompareLists.CompareListsOutput compare(
    CompareLists.CompareListsInput input
  ) {
    Test.startTest();
    List<CompareLists.CompareListsOutput> results = CompareLists.compareLists(
      new List<CompareLists.CompareListsInput>{ input }
    );
    Test.stopTest();
    return results[0];
  }
}
