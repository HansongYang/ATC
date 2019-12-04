package test.pcucumber;

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

public class parallelCucumber {
	InputHandler inputHandler = new InputHandler();
	ServerOutput serverOutput = new ServerOutput("", 0);
	List<Client> clientList = new ArrayList<Client>();
	List<Student> studentList = new ArrayList<Student>();
	ServerThread from;
	int index = 0;
	University u = new University();
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
	
	@When("^Student S(\\d+) tries to log in$")
	public void student_S_tries_to_log_in(int arg1) throws Throwable {
		serverOutput = inputHandler.processInput("student", state, from);
		state = serverOutput.getState();
	}

	@When("^Student enters student number (\\d+) and name \"([^\"]*)\"$")
	public void student_enters_student_number_and_name(int arg1, String arg2) throws Throwable {
		ServerThread student = null;
		Client client = new Client(student,InputHandler.WAITING);
		client.setStudentNumber(arg1);
		clientList.add(index,client);
		
		serverOutput = inputHandler.processInput(arg1 + "," + arg2, state, from);
		state = serverOutput.getState();
		if(u.getStudents().size() > 0 && u.GetStudent(arg1).getStudentName().equals(arg2)){
			Student s = new Student(arg1, arg2, true);
			studentList.add(index, s);
			index++;
			status = true;
		} else {
			assertTrue("Student " + arg2 + " doesn't exist.", false);
		}
	}

	@When("^Student S(\\d+) enters select course \"([^\"]*)\" option and (\\d+)$")
	public void student_S_enters_select_course_option_and(int arg1, String arg2, int arg3) throws Throwable {
	    if(u.getCourses().size() > 0) {
			assertEquals(clientList.get(arg1-1).getStudentNumber(), studentList.get(arg1-1).getStudentNumber());
		    status = studentList.get(arg1-1).SelectCourse(u.GetCourse(arg3));
	    } else {
	    	status = false;
	    }
	}
	
	@When("^Student S(\\d+) enters register course \"([^\"]*)\" option and (\\d+)$")
	public void student_S_enters_register_course_option_and(int arg1, String arg2, int arg3) throws Throwable {
		assertEquals(clientList.get(arg1-1).getStudentNumber(), studentList.get(arg1-1).getStudentNumber());
		if(studentList.get(arg1-1).getSelectedCourses().size() > 0) {
		   status = u.RegisterStudentForCourse(studentList.get(arg1-1), u.GetCourse(arg3));
		} else {
		   status = false; 
		}
	}

	@Then("^I validate that only one of the three students register in this course$")
	public void i_validate_that_only_one_of_the_three_students_register_in_this_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		int count = 0;
	    for(int i = 0; i < studentList.size(); i++) {
	    	if(studentList.get(i).getRegisteredCourses().size() > 0) {
	    		count++;
	    	}
	    }
	    if(count == 2) {
	    	assertEquals(count, 2); //Total of two students register in this course successfully
	    	System.out.println("EX1 passes!");
	    } else {
	    	assertTrue("EX1 fails", false);
	    }
	}
	
	@When("^Student S(\\d+) deregisters from this course (\\d+) simultaneously$")
	public void student_S_deregisters_from_this_course_simultaneously(int arg1, int arg2) throws Throwable {
		assertEquals(clientList.get(arg1-1).getStudentNumber(), studentList.get(arg1-1).getStudentNumber());
	    if(studentList.get(arg1-1).getRegisteredCourses().size() > 0) {
	    	status = u.DeRegisterStudentFromCourse(studentList.get(arg1-1), u.GetCourse(arg2));
	    } else {
	    	status = false;
	    }
	}

	@Then("^I validate that the one of the last two students gets in this course$")
	public void i_validate_that_the_one_of_the_two_students_gets_in_this_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		int count = 0;
		int sn = 0;
		int first = 0;
	    for(int i = 0; i < studentList.size(); i++) {
	    	if(studentList.get(i).getRegisteredCourses().size() > 0) {
	    		count++;
	    		if(count == 1) {
	    			first = i;
	    		}
	    		if(count == 2) {
	    			sn = studentList.get(i).getStudentNumber();
	    		}
	    	}
	    }
	  
	    if(count == 2 && sn == clientList.get(clientList.size()-1).getStudentNumber() && studentList.get(first).getRegisteredCourses().size() > 0) {
	    	assertTrue("S4 registers in this course", true);
	    	System.out.println("EX2 passes");
	    } else if (count == 2 && sn == clientList.get(clientList.size()-2).getStudentNumber() && studentList.get(first).getRegisteredCourses().size() > 0) {
	    	assertTrue("S3 registers in this course", true);
	    	System.out.println("EX2 passes");
	    } else {
	    	assertTrue("EX2 fails", false);
	    }
	}

	@Then("^I validate that both of the last two students gets in this course$")
	public void i_validate_that_both_of_two_students_gets_in_this_course() throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		int count = 0;
		int sn1 = 0, sn2 = 0;
	    for(int i = 0; i < studentList.size(); i++) {
	    	if(studentList.get(i).getRegisteredCourses().size() > 0) {
	    		count++;
	    	}
	    	if(count == 2) {
	    		sn1 = studentList.get(i).getStudentNumber(); 
	    	}
	    	if(count == 3) {
	    		sn2 = studentList.get(i).getStudentNumber(); 
	    	}
	    }
	    if(count == 3 && sn1 == clientList.get(clientList.size()-2).getStudentNumber() && sn2 ==  clientList.get(clientList.size()-1).getStudentNumber()) {
	    	assertTrue("S3 and S4 register in this course", true);
	    	System.out.println("EX2 passes.");
	    } else {
	    	assertTrue("EX2 fails.", false);
	    }
	}
}
