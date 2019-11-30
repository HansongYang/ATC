Feature: Example 2 with Original cucumber.

  Scenario Outline: Ex2
    Given The registration period hasn't opened yet
    And Clerk logs into the ATC successfully.
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number2>, <name2> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number3>, <name3> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number4>, <name4> and <is fulltime(y/n)>
    When Clerk enters create course <option2>
    And Clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When Clerk logs out of the ATC
    And The registration period opens
    When Student S1 tries to log in
    And Student enters student number <student number> and name <name>
    When Student S1 enters select course <option3> option and <course code>
    And Student S1 enters register course <option4> option and <course code>
    When Student S2 tries to log in
    And Student enters student number <student number2> and name <name2>
    When Student S2 enters select course <option3> option and <course code>
    And Student S2 enters register course <option4> option and <course code>
    When Student S3 tries to log in
    And Student enters student number <student number3> and name <name3>
    When Student S3 enters select course <option3> option and <course code>
    When Student S4 tries to log in
    And Student enters student number <student number4> and name <name4>
    When Student S4 enters select course <option3> option and <course code>
    When Student S3 enters register course <option4> option and <course code>
    And Student S4 enters register course <option4> option and <course code>
    And Student S2 deregisters from this course <course code> simultaneously
    Then I validate that the one of the last two students gets in this course

    Examples: 
      | option1          | student number | name | student number2 | name2 | student number3 | name3 | student number4 | name4 | is fulltime(y/n) | option2         | title | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               |
      | "create student" |      101000001 | "S1" |       101000002 | "S2"  |       101000003 | "S3"  |       101000004 | "S4"  | "y"              | "create course" | "C2"  |      100000 |       3 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" |

  Scenario Outline: Ex2
    Given The registration period hasn't opened yet
    And Clerk logs into the ATC successfully.
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number2>, <name2> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number3>, <name3> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number4>, <name4> and <is fulltime(y/n)>
    When Clerk enters create course <option2>
    And Clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When Clerk logs out of the ATC
    And The registration period opens
    When Student S1 tries to log in
    And Student enters student number <student number> and name <name>
    When Student S1 enters select course <option3> option and <course code>
    And Student S1 enters register course <option4> option and <course code>
    When Student S2 tries to log in
    And Student enters student number <student number2> and name <name2>
    When Student S2 enters select course <option3> option and <course code>
    And Student S2 enters register course <option4> option and <course code>
    When Student S3 tries to log in
    And Student enters student number <student number3> and name <name3>
    When Student S3 enters select course <option3> option and <course code>
    When Student S4 tries to log in
    And Student enters student number <student number4> and name <name4>
    When Student S4 enters select course <option3> option and <course code>
    When Student S4 enters register course <option4> option and <course code>
    And Student S3 enters register course <option4> option and <course code>
    And Student S2 deregisters from this course <course code> simultaneously
    Then I validate that the one of the last two students gets in this course

    Examples: 
      | option1          | student number | name | student number2 | name2 | student number3 | name3 | student number4 | name4 | is fulltime(y/n) | option2         | title | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               |
      | "create student" |      101000001 | "S1" |       101000002 | "S2"  |       101000003 | "S3"  |       101000004 | "S4"  | "y"              | "create course" | "C2"  |      100000 |       3 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" |

  Scenario Outline: Ex2
    Given The registration period hasn't opened yet
    And Clerk logs into the ATC successfully.
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number2>, <name2> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number3>, <name3> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number4>, <name4> and <is fulltime(y/n)>
    When Clerk enters create course <option2>
    And Clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When Clerk logs out of the ATC
    And The registration period opens
    When Student S1 tries to log in
    And Student enters student number <student number> and name <name>
    When Student S1 enters select course <option3> option and <course code>
    And Student S1 enters register course <option4> option and <course code>
    When Student S2 tries to log in
    And Student enters student number <student number2> and name <name2>
    When Student S2 enters select course <option3> option and <course code>
    And Student S2 enters register course <option4> option and <course code>
    When Student S3 tries to log in
    And Student enters student number <student number3> and name <name3>
    When Student S3 enters select course <option3> option and <course code>
    When Student S4 tries to log in
    And Student enters student number <student number4> and name <name4>
    When Student S4 enters select course <option3> option and <course code>
    And Student S2 deregisters from this course <course code> simultaneously
    When Student S4 enters register course <option4> option and <course code>
    And Student S3 enters register course <option4> option and <course code>
    Then I validate that both of the last two students gets in this course

    Examples: 
      | option1          | student number | name | student number2 | name2 | student number3 | name3 | student number4 | name4 | is fulltime(y/n) | option2         | title | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               |
      | "create student" |      101000001 | "S1" |       101000002 | "S2"  |       101000003 | "S3"  |       101000004 | "S4"  | "y"              | "create course" | "C2"  |      100000 |       3 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" |

  Scenario Outline: Ex2
    Given The registration period hasn't opened yet
    And Clerk logs into the ATC successfully.
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number2>, <name2> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number3>, <name3> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number4>, <name4> and <is fulltime(y/n)>
    When Clerk enters create course <option2>
    And Clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When Clerk logs out of the ATC
    And The registration period opens
    When Student S1 tries to log in
    And Student enters student number <student number> and name <name>
    When Student S1 enters select course <option3> option and <course code>
    And Student S1 enters register course <option4> option and <course code>
    When Student S2 tries to log in
    And Student enters student number <student number2> and name <name2>
    When Student S2 enters select course <option3> option and <course code>
    And Student S2 enters register course <option4> option and <course code>
    When Student S3 tries to log in
    And Student enters student number <student number3> and name <name3>
    When Student S3 enters select course <option3> option and <course code>
    When Student S4 tries to log in
    And Student enters student number <student number4> and name <name4>
    When Student S4 enters select course <option3> option and <course code>
    And Student S2 deregisters from this course <course code> simultaneously
    When Student S3 enters register course <option4> option and <course code>
    And Student S4 enters register course <option4> option and <course code>
    Then I validate that both of the last two students gets in this course

    Examples: 
      | option1          | student number | name | student number2 | name2 | student number3 | name3 | student number4 | name4 | is fulltime(y/n) | option2         | title | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               |
      | "create student" |      101000001 | "S1" |       101000002 | "S2"  |       101000003 | "S3"  |       101000004 | "S4"  | "y"              | "create course" | "C2"  |      100000 |       3 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" |

  Scenario Outline: Ex2
    Given The registration period hasn't opened yet
    And Clerk logs into the ATC successfully.
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number2>, <name2> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number3>, <name3> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number4>, <name4> and <is fulltime(y/n)>
    When Clerk enters create course <option2>
    And Clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When Clerk logs out of the ATC
    And The registration period opens
    When Student S1 tries to log in
    And Student enters student number <student number> and name <name>
    When Student S1 enters select course <option3> option and <course code>
    And Student S1 enters register course <option4> option and <course code>
    When Student S2 tries to log in
    And Student enters student number <student number2> and name <name2>
    When Student S2 enters select course <option3> option and <course code>
    And Student S2 enters register course <option4> option and <course code>
    When Student S3 tries to log in
    And Student enters student number <student number3> and name <name3>
    When Student S3 enters select course <option3> option and <course code>
    When Student S4 tries to log in
    And Student enters student number <student number4> and name <name4>
    When Student S4 enters select course <option3> option and <course code>
    And Student S4 enters register course <option4> option and <course code>
    When Student S2 deregisters from this course <course code> simultaneously
    And Student S3 enters register course <option4> option and <course code>
    Then I validate that both of the last two students gets in this course

    Examples: 
      | option1          | student number | name | student number2 | name2 | student number3 | name3 | student number4 | name4 | is fulltime(y/n) | option2         | title | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               |
      | "create student" |      101000001 | "S1" |       101000002 | "S2"  |       101000003 | "S3"  |       101000004 | "S4"  | "y"              | "create course" | "C2"  |      100000 |       3 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" |

  Scenario Outline: Ex2
    Given The registration period hasn't opened yet
    And Clerk logs into the ATC successfully.
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number2>, <name2> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number3>, <name3> and <is fulltime(y/n)>
    When Clerk enters create student <option1>
    And Clerk enters student information, such as <student number4>, <name4> and <is fulltime(y/n)>
    When Clerk enters create course <option2>
    And Clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When Clerk logs out of the ATC
    And The registration period opens
    When Student S1 tries to log in
    And Student enters student number <student number> and name <name>
    When Student S1 enters select course <option3> option and <course code>
    And Student S1 enters register course <option4> option and <course code>
    When Student S2 tries to log in
    And Student enters student number <student number2> and name <name2>
    When Student S2 enters select course <option3> option and <course code>
    And Student S2 enters register course <option4> option and <course code>
    When Student S3 tries to log in
    And Student enters student number <student number3> and name <name3>
    When Student S3 enters select course <option3> option and <course code>
    When Student S4 tries to log in
    And Student enters student number <student number4> and name <name4>
    When Student S4 enters select course <option3> option and <course code>
    When Student S3 enters register course <option4> option and <course code>
    And Student S2 deregisters from this course <course code> simultaneously
    And Student S4 enters register course <option4> option and <course code>
    Then I validate that both of the last two students gets in this course

    Examples: 
      | option1          | student number | name | student number2 | name2 | student number3 | name3 | student number4 | name4 | is fulltime(y/n) | option2         | title | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               |
      | "create student" |      101000001 | "S1" |       101000002 | "S2"  |       101000003 | "S3"  |       101000004 | "S4"  | "y"              | "create course" | "C2"  |      100000 |       3 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" |

