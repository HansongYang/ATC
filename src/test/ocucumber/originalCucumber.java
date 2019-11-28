package test.ocucumber;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import main.server.logic.handler.InputHandler;
import main.server.logic.handler.model.Client;
import main.server.logic.handler.model.ServerOutput;
import main.server.logic.model.Student;
import main.server.logic.model.University;
import main.server.network.ServerThread;
import main.utilities.Config;

public class originalCucumber {
	InputHandler inputHandler = new InputHandler();
	ServerOutput serverOutput = new ServerOutput("", 0);
	List<Client> clientList = new ArrayList<Client>();
	ServerThread from;
	int index = 0;
	University u = new University();
	Student s1, s2, s3, s4;
	boolean status = false;
	int state = 0;
	
	@Given("^Clerk logs into the ATC successfully\\.$")
	public void a_clerk_logs_into_the_ATC_successfully() throws Throwable {
		inputHandler.processInput(Config.CLERK_PASSWORD, state, from);
	}
	
	@When("^Clerk logs out of the ATC$")
	public void clerk_logs_out_of_the_ATC() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput("log out", InputHandler.WAITING, from);
		state = serverOutput.getState();
	}
	
	@When("^Clerk enters create course \"([^\"]*)\"$")
	public void this_clerk_enters_create_course(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(option, state, from);
		state = serverOutput.getState();
	}

	@When("^Clerk enters course information, such as \"([^\"]*)\", (\\d+), (\\d+), \"([^\"]*)\", (\\d+), (\\d+), \"([^\"]*)\" and \"([^\"]*)\"$")
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

	@When("^Clerk enters create student \"([^\"]*)\"$")
	public void this_clerk_enters_create_student(String option) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		serverOutput = inputHandler.processInput(option, state, from);
		state = serverOutput.getState();
	}
	
	@When("^Clerk enters student information, such as (\\d+), \"([^\"]*)\" and \"([^\"]*)\"$")
	public void this_clerk_enters_student_information_such_as_and(int arg1, String arg2, String arg3) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		boolean fullTime = false;
		if(arg3.equals("y")) {
			fullTime = true;
		}
		if(!Config.REGISTRATION_STARTS && !u.CheckStudent(arg1)) {
			status = u.CreateStudent(arg1,  arg2, fullTime);
		} else {
			status = false;
		}
	}
	
	@When("^Student S(\\d+) tries to log in$")
	public void student_S_tries_to_log_in(int arg1) throws Throwable {
		serverOutput = inputHandler.processInput("student", state, from);
		state = serverOutput.getState();
	}

	@When("^Student enters student number (\\d+) and name \"([^\"]*)\"$")
	public void student_enters_student_number_and_name(int arg1, String arg2) throws Throwable {
		Client client = new Client(from,InputHandler.WAITING);
		client.setStudentNumber(arg1);
		clientList.add(index,client);
		index++;
		serverOutput = inputHandler.processInput(arg1 + "," + arg2, state, from);
		state = serverOutput.getState();
		if(u.getStudents().size() > 0 && u.GetStudent(arg1).getStudentName().equals(arg2)){
			if(arg2.equals("S1")) {
				s1 = new Student(arg1, arg2, true);
			} else if(arg2.equals("S2")) {
				s2 = new Student(arg1, arg2, true);
			} else if(arg2.equals("S3")) {
				s3 = new Student(arg1, arg2, true);
			} else if(arg2.equals("S4")) {
				s4 = new Student(arg1, arg2, true);
			}
			status = true;
		} else {
			assertTrue("Student " + arg2 + " doesn't exist.", false);
		}
	}

	@When("^Student S(\\d+) enters select course \"([^\"]*)\" option and (\\d+)$")
	public void student_S_enters_select_course_option_and(int arg1, String arg2, int arg3) throws Throwable {
	    if(u.getCourses().size() > 0) {
			if(arg1 == 1) {
				assertEquals(clientList.get(0).getStudentNumber(), s1.getStudentNumber());
		    	status = s1.SelectCourse(u.GetCourse(arg3));
		    } else if (arg1 == 2) {
		    	assertEquals(clientList.get(1).getStudentNumber(), s2.getStudentNumber());
		    	status = s2.SelectCourse(u.GetCourse(arg3));
		    } else if (arg1 == 3) {
		    	assertEquals(clientList.get(2).getStudentNumber(), s3.getStudentNumber());
		    	status = s3.SelectCourse(u.GetCourse(arg3));
		    } else if (arg1 == 4) {
		    	assertEquals(clientList.get(3).getStudentNumber(), s4.getStudentNumber());
		    	status = s4.SelectCourse(u.GetCourse(arg3));
		    }
	    } else {
	    	status = false;
	    }
	}
	
	@When("^Student S(\\d+) enters register course \"([^\"]*)\" option and (\\d+)$")
	public void student_S_enters_register_course_option_and(int arg1, String arg2, int arg3) throws Throwable {
	   if(arg1 == 1) {
		   assertEquals(clientList.get(0).getStudentNumber(), s1.getStudentNumber());
		   if(s1.getSelectedCourses().size() > 0) {
			   status = u.RegisterStudentForCourse(s1, u.GetCourse(arg3));
		   } else {
			   status = false; 
		   }
	   } else if(arg1 == 2) {
		   assertEquals(clientList.get(1).getStudentNumber(), s2.getStudentNumber());
		   if(s2.getSelectedCourses().size() > 0) {
			   status = u.RegisterStudentForCourse(s2, u.GetCourse(arg3));
		   } else {
			   status = false;
		   }
	   } else if(arg1 == 3) {
		   assertEquals(clientList.get(2).getStudentNumber(), s3.getStudentNumber());
		   if(s3.getSelectedCourses().size() > 0) {
			   status = u.RegisterStudentForCourse(s3, u.GetCourse(arg3));
		   } else {
			   status = false;
		   }
	   } else if(arg1 == 4) {
		   assertEquals(clientList.get(3).getStudentNumber(), s4.getStudentNumber());
		   if(s4.getSelectedCourses().size() > 0) {
			   status = u.RegisterStudentForCourse(s4, u.GetCourse(arg3));
		   } else {
			   status = false;
		   }
	   }
	}

	@Then("^I validate that only one of the three students register in this course$")
	public void i_validate_that_only_one_of_the_three_students_register_in_this_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
	    if(s2.getRegisteredCourses().size() > 0 && s3.getRegisteredCourses().size() == 0 && s4.getRegisteredCourses().size() == 0) {
	    	assertEquals(s2.getRegisteredCourses().size(), 1);
	    } else if(s2.getRegisteredCourses().size() == 0 && s3.getRegisteredCourses().size() > 0 && s4.getRegisteredCourses().size() == 0) {
	    	assertEquals(s3.getRegisteredCourses().size(), 1);
	    } else if(s2.getRegisteredCourses().size() == 0 && s3.getRegisteredCourses().size() == 0 && s4.getRegisteredCourses().size() > 0) {
	    	assertEquals(s4.getRegisteredCourses().size(), 1);
	    } else {
	    	assertEquals(status, false);
	    }
	}
	
	@When("^Student S(\\d+) deregisters from this course (\\d+) simultaneously$")
	public void student_S_deregisters_from_this_course_simultaneously(int arg1, int arg2) throws Throwable {
	    if(arg1 == 1) {
	    	assertEquals(clientList.get(0).getStudentNumber(), s1.getStudentNumber());
	    	if(s1.getRegisteredCourses().size() > 0) {
	    		status = u.DeRegisterStudentFromCourse(s1, u.GetCourse(arg2));
	    	} else {
	    		status = false;
	    	}
	    } else if(arg1 == 2) {
	    	assertEquals(clientList.get(1).getStudentNumber(), s2.getStudentNumber());
	    	if(s2.getRegisteredCourses().size() > 0) {
	    		status = u.DeRegisterStudentFromCourse(s2, u.GetCourse(arg2));
	    	} else {
	    		status = false;
	    	}
	    } else if(arg1 == 3) {
	    	assertEquals(clientList.get(2).getStudentNumber(), s3.getStudentNumber());
	    	if(s3.getRegisteredCourses().size() > 0) {
	    		status = u.DeRegisterStudentFromCourse(s3, u.GetCourse(arg2));
	    	} else {
	    		status = false;
	    	}
	    } else if(arg1 == 4) {
	    	assertEquals(clientList.get(3).getStudentNumber(), s4.getStudentNumber());
	    	if(s4.getRegisteredCourses().size() > 0) {
	    		status = u.DeRegisterStudentFromCourse(s4, u.GetCourse(arg2));
	    	} else {
	    		status = false;
	    	}
	    }
	}

	@Then("^I validate that the one of the two students gets in this course$")
	public void i_validate_that_the_one_of_the_two_students_gets_in_this_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		if(s3.getRegisteredCourses().size() > 0 && s4.getRegisteredCourses().size() == 0) {
	    	assertEquals(s3.getRegisteredCourses().size(), 1);
	    } else if(s3.getRegisteredCourses().size() == 0 && s4.getRegisteredCourses().size() > 0) {
	    	assertEquals(s4.getRegisteredCourses().size(), 1);
	    }
	}

	@Then("^I validate that both of two students gets in this course$")
	public void i_validate_that_both_of_two_students_gets_in_this_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		assertEquals(s3.getRegisteredCourses().size(), 1);
		assertEquals(s4.getRegisteredCourses().size(), 1);
	}
}
