@studentUseCase
Feature: Use case of Student with invalid paths

  @tag1
  Scenario Outline: A non-existent Student logs into the ATC
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    Then I validate whether this student logs in or not

    Examples: 
      | option           | student number | name             | is fulltime(y/n) |
      | "create student" |      101000001 | "John Masefield" | "y"              |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              |

  @tag2
  Scenario Outline: A Student selects a course when the registraion period ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period ends
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    Then I validate that this student selects a course successfully or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" |

  @tag3
  Scenario Outline: A Student selects a course when the term ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    And The term ends
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    Then I validate that this student selects a course successfully or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" |

  @tag4
  Scenario Outline: A Student selects a non-existent course when the registraion period opens
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk logs out of the ATC
    And The registration period opens
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

  @tag5
  Scenario Outline: A Student registers a course when the registraion period ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period ends
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    Then I validate that this student registers a course successfully or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" |

	@tag6
  Scenario Outline: A Student registers a course when the registraion period hasn't opened yet
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    Then I validate that this student registers a course successfully or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" |

  @tag7
  Scenario Outline: A Student registers a course when the term ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period ends
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    And The term ends
    When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    Then I validate that this student registers a course successfully or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" |

  @tag8
  Scenario Outline: A full time Student registers a course when his number of courses reach to the limit
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title2>, <course code2>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title3>, <course code3>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title4>, <course code4>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title5>, <course code5>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period ends
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    When This student enters select course <option3>
    And This student enters course code <course code2> for selecting a course
    When This student enters select course <option3>
    And This student enters course code <course code3> for selecting a course
    When This student enters select course <option3>
    And This student enters course code <course code4> for selecting a course
    When This student enters select course <option3>
    And This student enters course code <course code5> for selecting a course
    When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    When This student enters register course <option4>
    And This student enters course code <course code2> for registering a course
    When This student enters register course <option4>
    And This student enters course code <course code3> for registering a course
    When This student enters register course <option4>
    And This student enters course code <course code4> for registering a course
    When This student enters register course <option4>
    And This student enters course code <course code5> for registering a course
    Then I validate that this student cannot register this course

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               | title2      | course code2 | title3      | course code3 | title4      | course code4 | title5      | course code5 |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" | "Time"      |       100001 | "Algorithm" |       100002 | "Logic"     |       100003 | "Bussines"  |       100004 |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100000 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" | "Physics"   |       100001 | "Arts"      |       100002 | "Geomatics" |       100003 | "Chemistry" |       100004 |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100000 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" | "Chemistry" |       100001 | "Fictions"  |       100002 | "AI"        |       100003 | "Time"      |       100004 |

	@tag9
  Scenario Outline: A part time Student registers a course when his number of courses reach to the limit
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title2>, <course code2>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title3>, <course code3>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
 	  When This clerk logs out of the ATC
    And The registration period ends
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    When This student enters select course <option3>
    And This student enters course code <course code2> for selecting a course
    When This student enters select course <option3>
    And This student enters course code <course code3> for selecting a course
    When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    When This student enters register course <option4>
    And This student enters course code <course code2> for registering a course
    When This student enters register course <option4>
    And This student enters course code <course code3> for registering a course
    Then I validate that this student cannot register this course 

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               | title2      | course code2 | title3      | course code3 | 
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" | "Time"      |       100001 | "Algorithm" |       100002 |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100000 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" | "Physics"   |       100001 | "Arts"      |       100002 | 
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100000 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" | "Chemistry" |       100001 | "Fictions"  |       100002 |

  @tag10
  Scenario Outline: A Student registers a non-existent course when the registraion period opens
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk logs out of the ATC
    And The registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters register course <option2>
    And This student enters course code <course code> for registering a course
    Then I validate that this student registers a non-existent course

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | course code | option2               |
      | "create student" |      101000001 | "John Masefield" | "y"              |      100000 | "register for course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              |      100001 | "register for course" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              |      100002 | "register for course" |

  @tag11
  Scenario Outline: A Student drops a course when the registraion period opens
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    When This student enters drop course <option5>
    And This student enters course code <course code> for dropping a course
    Then I validate that this student drops a course successfully or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               | option5       |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" | "drop course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" | "drop course" |
      | "create student" |      101000003 | "Kerry Smith"    | "y"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" | "drop course" |

  @tag12
  Scenario Outline: A Student drops a course when the term ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    And The term ends
    When This student enters drop course <option5>
    And This student enters course code <course code> for dropping a course
    Then I validate that this student drops a course successfully or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               | option5       |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" | "drop course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" | "drop course" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" | "drop course" |

  @tag13
  Scenario Outline: A Student drops a non-registered course when the registraion period ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period ends
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters drop course <option3>
    And This student enters course code <course code> for dropping a course
    Then I validate that this student drops a non-registered course

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3       |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "drop course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "drop course" |
      | "create student" |      101000003 | "Kerry Smith"    | "n"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "drop course" |

  @tag14
  Scenario Outline: A Student deregisters a course when the registraion period ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    When This student enters deregister course <option5>
    And The registration period ends
    And This student enters course code <course code> for deregistering a course
    Then I validate that this student deregisters a course or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               | option5             |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" | "deregister course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" | "deregister course" |
      | "create student" |      101000003 | "Kerry Smith"    | "y"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" | "deregister course" |

  @tag15
  Scenario Outline: A Student deregisters a course when the term ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    When This student enters deregister course <option5>
    And The term ends
    And This student enters course code <course code> for deregistering a course
    Then I validate that this student deregisters a course or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               | option5             |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" | "deregister course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" | "deregister course" |
      | "create student" |      101000003 | "Kerry Smith"    | "y"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" | "deregister course" |

  @tag16
  Scenario Outline: A Student deregisters a non-registered course when the registraion period opens
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters deregister course <option3>
    And This student enters course code <course code> for deregistering a course
    Then I validate that this student deregisters a non-registered course

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3             |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "deregister course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "deregister course" |
      | "create student" |      101000003 | "Kerry Smith"    | "y"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "deregister course" |

  @tag17
  Scenario Outline: A Student fufills a course when the term ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    When This student enters select course <option3>
    And This student enters course code <course code> for selecting a course
    When This student enters register course <option4>
    And This student enters course code <course code> for registering a course
    And The term ends
    When This student enters complete course <option5>
    And This student enters course code <course code> for completing a course
    Then I verify that this student complete this course or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               | option5           |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" | "complete course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" | "complete course" |
      | "create student" |      101000003 | "Kerry Smith"    | "y"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" | "complete course" |

  @tag18
  Scenario Outline: A Student tries to fufill a non-registered course when the term does not ends
    Given The registration period hasn't opened yet
    And A clerk logs into the ATC successfully.
    When This clerk enters create student <option1>
    And This clerk enters student information, such as <student number>, <name> and <is fulltime(y/n)>
    When This clerk enters create course <option2>
    And This clerk enters course information, such as <title>, <course code>, <capsize>, <enforce prereqs(y/n)>, <number of midterms>, <number of assignments>, <has a final(y/n)> and <is project course(y/n)>
    When This clerk logs out of the ATC
    And The registration period opens
    When A user connects to the server and then this user enters student
    And This student enters student number <student number> and name <name>
    And The registration period ends
    When This student enters complete course <option5>
    And This student enters course code <course code> for completing a course
    Then I verify that this student complete this course or not

    Examples: 
      | option1          | student number | name             | is fulltime(y/n) | option2         | title                  | course code | capsize | enforce prereqs(y/n) | number of midterms | number of assignments | has a final(y/n) | is project course(y/n) | option3         | option4               | option5           |
      | "create student" |      101000001 | "John Masefield" | "y"              | "create course" | "Software Engineering" |      100000 |      10 | "n"                  |                  3 |                     5 | "y"              | "n"                    | "select course" | "register for course" | "complete course" |
      | "create student" |      101000002 | "Tom Hansen"     | "y"              | "create course" | "Network Computing"    |      100001 |      20 | "n"                  |                  0 |                     0 | "n"              | "y"                    | "select course" | "register for course" | "complete course" |
      | "create student" |      101000003 | "Kerry Smith"    | "y"              | "create course" | "Game Development"     |      100002 |      30 | "n"                  |                  2 |                     4 | "y"              | "n"                    | "select course" | "register for course" | "complete course" |
