@ClerkUseCase
Feature: Use Case of clerk with valid paths

  @tag1
  Scenario Outline: A Clerk logs into the ATC
    Given The server is running and the comming term is initialized
    When A user connects to the server and then this user enters clerk
    Then I validate the password <password> which this clerk enters

    Examples: 
      | password     |
      | "admin"      |
      | "clerk"      |
      | "qwertyuiop" |

  @tag2
  Scenario: A Clerk logs out of the ATC
    Given A clerk logs into the ATC successfully.
    When This clerk logs out of the ATC
    Then I verify that this clerk is logged out or not

  @tag3
  Scenario Outline: A Clerk creates a course when registration period hasn't opened yet
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create course <option>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    Then I verify that this course is created or not

    Examples: 
      | option          | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) |
      | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    |
      | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    |
      | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    |

  @tag4
  Scenario Outline: A Clerk deletes a course when registration period hasn't opened yet
    Given The registration period hasn't opened yet
    When This clerk enters create course <option1>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk enters delete course <option2>
    And This clerk enters course code <course code> for deleting course
    Then I verify that this course is deleted or not

    Examples: 
      | option1         | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) |
      | "create course" | "delete course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    |
      | "create course" | "delete course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    |
      | "create course" | "delete course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    |

  @tag5
  Scenario Outline: A Clerk creates a student when registration period hasn't open yet
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    Then I verify that this student is created or not

    Examples: 
      | option           | student number | name             | is fulltime(y/n) |
      | "create student" |      101000001 | "John Masefield" | "y"              |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              |

  @tag6
  Scenario Outline: A clerk deletes a student when the registration period hasn't started yet
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters delete student <option2>
    And This clerk enters student number <student number>
    Then I verify that this student is deleted or not

    Examples: 
      | option           | student number | name             | is fulltime(y/n) | option2          |
      | "create student" |      101000001 | "John Masefield" | "y"              | "delete student" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "delete student" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "delete student" |

 @tag7
  Scenario Outline: A clerk cancels a course when the registration period ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create course <option1>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    And The registration period ends
    When This clerk enters cancel course <option2>
    And This clerk enters course code <course code> for cancelling course
    Then I verify that this course is canceled or not

    Examples: 
      | option1         | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) |
      | "create course" | "cancel course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    |
      | "create course" | "cancel course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    |
      | "create course" | "cancel course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    |
      