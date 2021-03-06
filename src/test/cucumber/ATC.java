package test.cucumber;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.core.IsEqual.equalTo;
import static org.junit.Assert.assertEquals;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import main.server.logic.handler.InputHandler;
import main.server.logic.handler.OutputHandler;
import main.server.logic.handler.model.ServerOutput;
import main.server.logic.model.Course;
import main.server.logic.model.Student;
import main.server.logic.model.University;
import main.utilities.Config;
import main.server.network.ServerThread;

public class ATC {
	InputHandler inputHandler = new InputHandler();
	ServerOutput serverOutput = new ServerOutput("", 0);
	ServerThread from;
	University u = new University();
	Student s;
	boolean status = false;
	int state = 0;
	String output = "";
	
	@Given("^The server is running and the comming term is initialized$")
	public void the_server_is_running_and_the_comming_term_is_initialized() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput("", InputHandler.WAITING, from);
		state = serverOutput.getState();
	}

	@When("^A user connects to the server and then this user enters clerk$")
	public void a_user_connects_to_the_server_and_then_this_user_enters_clerk() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput("clerk", state, from);
		state = serverOutput.getState();
	}

	@Then("^I validate the password \"([^\"]*)\" which this clerk enters$")
	public void i_validate_the_password_which_this_clerk_enters(String password) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(password, state, from);
		state = serverOutput.getState();
		if(password.equals(Config.CLERK_PASSWORD)) {
			assertThat(state, equalTo(OutputHandler.CLERK));
		} else {
			assertThat(state, equalTo(OutputHandler.CLERKLOGIN));
		}
	}

	@Given("^A clerk logs into the ATC successfully\\.$")
	public void a_clerk_logs_into_the_ATC_successfully() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		inputHandler.processInput(Config.CLERK_PASSWORD, state, from);
	}

	@When("^This clerk logs out of the ATC$")
	public void this_clerk_enters_option_for_logging_out() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput("log out", InputHandler.WAITING, from);
		state = serverOutput.getState();
	}

	@Then("^I verify that this clerk is logged out or not$")
	public void i_verify_that_this_clerk_is_logged_out_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		assertThat(state, equalTo(OutputHandler.FINISHWAITING));
	}

	@Given("^The registration period hasn't opened yet$")
	public void a_clerk_logs_into_the_ATC_successfully_and_the_registration_period_hasn_t_opened_yet() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		Thread.sleep(Config.SIMULATED_DAY * 2);
		Config.REGISTRATION_ENDS = false;
		Config.REGISTRATION_STARTS = false;
		Config.TERM_ENDS = false;
	}
	
	@Given("^The registration period opens$")
	public void a_clerk_logs_into_the_ATC_successfully_and_the_registration_period_opens() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		Thread.sleep(Config.SIMULATED_DAY * 20);
	}
	
	@Given("^The registration period ends$")
	public void a_clerk_logs_into_the_ATC_successfully_and_the_registration_period_ends() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		//serverOutput = inputHandler.processInput(Config.CLERK_PASSWORD, state);
		Thread.sleep(Config.SIMULATED_DAY * 34);
	}

	@Given("^The term ends$")
	public void the_term_ends() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		Thread.sleep(Config.SIMULATED_DAY * 118);
	}

	@When("^This clerk enters create course \"([^\"]*)\"$")
	public void this_clerk_enters_create_course(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(option, state, from);
		state = serverOutput.getState();
	}

	@When("^This clerk enters course information, such as \"([^\"]*)\", (\\d+), (\\d+), \"([^\"]*)\", (\\d+), (\\d+), \"([^\"]*)\" and \"([^\"]*)\"$")
	public void this_clerk_enters_course_information_such_as_and(String arg1, int arg2, int arg3, String arg4, int arg5, int arg6, String arg7, String arg8) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		boolean preReq, finalExam, project = preReq = finalExam = false;
		if(arg4.equals("y")) {
			preReq = true;
		} 
		if(arg7.equals("y")){
			finalExam = true;
		}
		if(arg8.equals("y")) {
			project = true;
		}
		if(!Config.REGISTRATION_ENDS && !Config.REGISTRATION_STARTS && !u.CheckCourse(arg2)) {
			status = u.CreateCourse(arg1 , arg2 , arg3, preReq, arg5, arg6, finalExam, project);
		} else {
			status = false;
		}
	}

	@Then("^I verify that this course is created or not$")
	public void i_verify_that_this_course_is_created_or_not() throws Throwable {
		if(!Config.REGISTRATION_ENDS && !Config.REGISTRATION_STARTS) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}
	
	@When("^This clerk enters delete course \"([^\"]*)\"$")
	public void this_clerk_enters_delete_course(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(option, state, from);
		state = serverOutput.getState();
	}
	
	@When("^This clerk enters course code (\\d+) for deleting course$")
	public void this_clerk_enters_course_code(int code) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(u.CheckCourse(code) == false || Config.REGISTRATION_ENDS || Config.REGISTRATION_STARTS){
			status = false;
		} else {
			status = u.DestroyCourse((Course)u.GetCourse(code));
		}
	}
	
	@Then("^I verify that this course is deleted or not$")
	public void i_verify_that_this_course_is_deleted_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(!Config.REGISTRATION_ENDS && !Config.REGISTRATION_STARTS) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}
	
	@Then("^I verify that this non-existent course is deleted or not$")
	public void i_verify_that_this_non_existed_course_is_deleted_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		assertEquals(status, false);
	}
	
	@When("^This clerk enters create student \"([^\"]*)\"$")
	public void this_clerk_enters_create_student(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(option, state, from);
		state = serverOutput.getState();
	}
	
	@When("^This clerk enters student information, such as (\\d+), \"([^\"]*)\" and \"([^\"]*)\"$")
	public void this_clerk_enters_student_information_such_as_and(int arg1, String arg2, String arg3) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		boolean fullTime = false;
		if(arg3.equals("y")) {
			fullTime = true;
		}
		if(!Config.REGISTRATION_STARTS && !u.CheckStudent(arg1)) {
			status = u.CreateStudent(arg1,  arg2, fullTime);
			s = new Student(arg1, arg2, fullTime);
		} else {
			status = false;
		}
	}
	
	@Then("^I verify that this student is created or not$")
	public void i_verify_that_this_student_is_created_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(!Config.REGISTRATION_ENDS && !Config.REGISTRATION_STARTS) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}
	
	@When("^This clerk enters delete student \"([^\"]*)\"$")
	public void this_clerk_enters_delete_student(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(option, state, from);
		state = serverOutput.getState();
	}

	@When("^This clerk enters student number (\\d+)$")
	public void this_clerk_enters_student_number(int code) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(u.CheckStudent(code) == false || Config.REGISTRATION_ENDS || Config.REGISTRATION_STARTS){
			status = false;
		} else {
			status = u.DestroyStudent((Student)u.GetStudent(code));
		}
	}

	@Then("^I verify that this student is deleted or not$")
	public void i_verify_that_this_student_is_deleted_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(!Config.REGISTRATION_ENDS && !Config.REGISTRATION_STARTS) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}
	
	@Then("^I verify that this non-existent student is deleted or not$")
	public void i_verify_that_this_non_existent_student_is_deleted_or_not() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		assertEquals(status, false);
	}
	

	@When("^This clerk enters cancel course \"([^\"]*)\"$")
	public void this_clerk_enters_cancel_course(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(option, state, from);
		state = serverOutput.getState();
	}
	
	@When("^This clerk enters course code (\\d+) for cancelling course$")
	public void this_clerk_enters_course_code_for_cancelling_course(int code) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(u.CheckCourse(code) == false || !Config.REGISTRATION_ENDS || Config.REGISTRATION_STARTS || Config.TERM_ENDS){
			status = false;
		} else {
			status = u.CancelCourse((Course)u.GetCourse(code));
		}
	}
	
	@Then("^I verify that this course is canceled or not$")
	public void i_verify_that_this_course_is_canceled_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(Config.REGISTRATION_ENDS && !Config.REGISTRATION_STARTS && !Config.TERM_ENDS) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}
	
	@Then("^I verify that this non-existent course is canceled or not$")
	public void i_verify_that_this_non_existent_course_is_canceled_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		assertEquals(status, false);
	}
	
	@When("^A user connects to the server and then this user enters student$")
	public void a_user_connects_to_the_server_and_then_this_user_enters_student() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput("student", state, from);
		state = serverOutput.getState();
	}

	@When("^This student enters student number (\\d+) and name \"([^\"]*)\"$")
	public void this_student_enters_student_number_and_name(int arg1, String arg2) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(arg1 + "," + arg2, state, from);
		state = serverOutput.getState();
		if(u.getStudents().size() > 0 && u.GetStudent(arg1).getStudentName().equals(arg2)){
			s = new Student(arg1, arg2, true);
			status = true;
		}
	}

	@Then("^I validate whether this student logs in or not$")
	public void i_validate_whether_this_student_logs_in_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(u.getStudents().size() > 0) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}
	
	@When("^This student logs out of the ATC$")
	public void this_student_logs_out_of_the_ATC() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput("log out", InputHandler.WAITING, from);
		state = serverOutput.getState();
	}

	@Then("^I validate whether this student logs out or not$")
	public void i_validate_whether_this_student_logs_out_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		assertThat(state, equalTo(OutputHandler.FINISHWAITING));
	}

	
	@When("^This student enters select course \"([^\"]*)\"$")
	public void this_student_enters_select_course(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(option, state, from);
		state = serverOutput.getState();
	}

	@When("^This student enters course code (\\d+) for selecting a course$")
	public void this_student_enters_course_code(int arg1) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(u.getCourses().size() > 0 && !Config.REGISTRATION_ENDS && !Config.TERM_ENDS) {
			status = s.SelectCourse(u.GetCourse(arg1));
		} else {
			status = false;
		}
	}

	@Then("^I validate that this student selects a course successfully or not$")
	public void i_validate_that_this_student_selects_course_successfully() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
	    if(u.getCourses().size() > 0 && !Config.REGISTRATION_ENDS && !Config.TERM_ENDS) {
	    	assertEquals(status, true);
	    } else {
	    	assertEquals(status, false);
	    }
	}
	
	@Then("^I validate that this student selects a non-existent course$")
	public void i_validate_that_this_student_selects_a_non_existent_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		assertEquals(status, false);
	}
	

	@When("^This student enters register course \"([^\"]*)\"$")
	public void this_student_enters_register_course(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(option, state, from);
		state = serverOutput.getState();
	}

	@When("^This student enters course code (\\d+) for registering a course$")
	public void this_student_enters_course_code_for_registering_a_course(int arg1) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
	    if(s.getSelectedCourses().size() > 0 && !Config.REGISTRATION_ENDS && Config.REGISTRATION_STARTS && !Config.TERM_ENDS && s.isFullTime() && s.getRegisteredCourses().size() <= 4) {
	    	status = u.RegisterStudentForCourse(s, u.GetCourse(arg1));
	    } else if (s.getSelectedCourses().size() > 0 && !Config.REGISTRATION_ENDS && Config.REGISTRATION_STARTS && !Config.TERM_ENDS && !s.isFullTime() && s.getRegisteredCourses().size() <= 2) {
	    	status = u.RegisterStudentForCourse(s, u.GetCourse(arg1));
		}else {
	    	status = false;
	    }
	}
	
	@Then("^I validate that this student registers a course successfully or not$")
	public void i_validate_that_this_student_registers_a_course_successfully() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(s.getRegisteredCourses().size() > 0 && !Config.REGISTRATION_ENDS && Config.REGISTRATION_STARTS && !Config.TERM_ENDS) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}

	@Then("^I validate that this student registers a non-existent course$")
	public void i_validate_that_this_student_registers_a_non_existent_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		assertEquals(status, false);
	}
	
	@Then("^I validate that this student cannot register this course$")
	public void i_validate_that_this_student_cannot_register_this_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		assertEquals(status, false);
	}
	
	@Then("^I validate that one student registers a course successfully$")
	public void i_validate_that_the_first_student_registers_a_course_successfully_but_not_the_second_student() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(u.GetCourse(100000).getEnrollStudent().size() > 0) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}
	
	@When("^This student enters drop course \"([^\"]*)\"$")
	public void this_student_enters_drop_course(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
	   serverOutput = inputHandler.processInput(option, state, from);
	   state = serverOutput.getState();
	}
	
	int courses;
	@When("^This student enters course code (\\d+) for dropping a course$")
	public void this_student_enters_course_code_for_dropping_a_course(int arg1) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		courses = s.getRegisteredCourses().size();
	    if(Config.REGISTRATION_ENDS && !Config.TERM_ENDS && s.getRegisteredCourses().size() > 0) {
	    	status = u.dropCourse(s, u.GetCourse(arg1));
	    } else {
	    	status = false;
	    }
	}
	
	@Then("^I validate that this student drops a course successfully or not$")
	public void i_validate_that_this_student_drops_a_course_successfully() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(!Config.REGISTRATION_STARTS && Config.REGISTRATION_ENDS && !Config.TERM_ENDS && courses > s.getRegisteredCourses().size()) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}
	
	@Then("^I validate that this student is deleted or not$")
	public void i_validate_that_this_student_is_deleted_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(status) {
			assertEquals(u.getStudents().size(), 0);
		} else {
			assertEquals(u.getStudents().size(), 1);
		}
	}
	

	@Then("^I validate that this student drops a non-registered course$")
	public void i_validate_that_this_student_drops_a_non_registered_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
	    assertEquals(status, false);
	}
	
	@Then("^I validate that this student deregisters a non-registered course$")
	public void i_validate_that_this_student_deregisters_a_non_registered_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
	    assertEquals(status, false);
	}
	
	@When("^This student enters deregister course \"([^\"]*)\"$")
	public void this_student_enters_deregister_course(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(option, state, from);
		state = serverOutput.getState();
	}

	@When("^This student enters course code (\\d+) for deregistering a course$")
	public void this_student_enters_course_code_for_deregistering_a_course(int arg1) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
	    if(s.getRegisteredCourses().size() > 0 && !Config.REGISTRATION_ENDS && Config.REGISTRATION_STARTS && !Config.TERM_ENDS) {
	    	status = u.DeRegisterStudentFromCourse(s, u.GetCourse(arg1));
	    } else {
	    	status = false;
	    }
	}

	@Then("^I validate that this student deregisters a course or not$")
	public void i_validate_that_this_student_deregisters_a_course_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(!Config.REGISTRATION_ENDS && Config.REGISTRATION_STARTS && !Config.TERM_ENDS) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}
	
	@When("^This student enters complete course \"([^\"]*)\"$")
	public void this_student_enters_complete_course(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		 serverOutput = inputHandler.processInput(option, state, from);
		 state = serverOutput.getState();
	}

	@When("^This student enters course code (\\d+) for completing a course$")
	public void this_student_enters_course_code_for_completing_a_course(int arg1) throws Throwable {
	    if(s.getRegisteredCourses().size() > 0 && !Config.TERM_ENDS) {
	    	status = u.MarkStudents(u.GetCourse(arg1));
	    } else {
	    	status = false;
	    }
	}

	@Then("^I verify that this student complete this course or not$")
	public void i_verify_that_this_student_complete_this_course_or_not() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(s.getRegisteredCourses().size() > 0 && !Config.TERM_ENDS) {
			assertEquals(status, true);
		} else {
			assertEquals(status, false);
		}
	}
	
	@Then("^I validate that second student registers this course successfully$")
	public void i_validate_that_second_student_registers_this_course_successfully() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
	    if(s.getRegisteredCourses().size() > 0 && u.GetCourse(100000).getEnrollStudent().size() > 0) {
	    	assertEquals(status, true);
	    } else {
	    	assertEquals(status, false);
	    }
	}
}
