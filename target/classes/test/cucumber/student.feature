@studentUseCase
Feature: Use case of Student

  @tag1
  Scenario Outline: A Student logs into the ATC
    Given A clerk logs into the ATC successfully and the registration period hasn't opened yet
    When This clerk enters create student <option>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    And This clerk logs out of the ATC
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    Then I validate whether this student logs in or not

    Examples: 
      | option           | student number | name             | is fulltime(y/n) |
      | "create student" |      101000001 | "John Masefield" | "y"              |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              |

  @tag2
  Scenario Outline: A non-existent Student logs into the ATC
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    Then I validate whether this student logs in or not

    Examples: 
      | option           | student number | name             | is fulltime(y/n) |
      | "create student" |      101000001 | "John Masefield" | "y"              |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              |

  @tag3
  Scenario Outline: A Student selectes a course when the registraion period opens
    Given A clerk logs into the ATC successfully and the registration period hasn't opened yet
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And A clerk logs into the ATC successfully and the registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    Then I validate that this student selects a course successfully

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" |

  @tag4
  Scenario Outline: A Student selectes a course when the registraion period ends
    Given A clerk logs into the ATC successfully and the registration period hasn't opened yet
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And A clerk logs into the ATC successfully and the registration period ends
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    Then I validate that this student selects a course successfully

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" |

  @tag5
  Scenario Outline: A Student selectes a non-existent course when the registraion period opens
    Given A clerk logs into the ATC successfully and the registration period hasn't opened yet
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk logs out of the ATC
    And A clerk logs into the ATC successfully and the registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option2>
    And This student enters course code <course code> for selecting a course
    Then I validate that this student selects a non-existent course

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | course code |
      | "create student" |      101000001 | "John Masefield" | "y"              | "select course" |      100000 |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "select course" |      100001 |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "select course" |      100002 |
      
   @tag6
    Scenario Outline: A Student registers a course when the registraion period opens
    Given A clerk logs into the ATC successfully and the registration period hasn't opened yet
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And A clerk logs into the ATC successfully and the registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
     When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    Then I validate that this student registers a course successfully

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4|
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course"|
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course"|
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course"|
   
    @tag7
    Scenario Outline: A Student registers a course when the registraion period ends
    Given A clerk logs into the ATC successfully and the registration period hasn't opened yet
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And A clerk logs into the ATC successfully and the registration period ends
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
     When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    Then I validate that this student registers a course successfully

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4|
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course"|
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course"|
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course"|
