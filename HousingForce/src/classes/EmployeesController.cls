public class EmployeesController
{
    /*private String associateFN = 'firstName';
    private String associateLN = 'lastName'; */

    //variables to store our user inputs
    private String associateFN ;
    private String associateLN ;

    //called by EmployeeRecordDetails2 component

	public List<Contact> getEmployees
    {
        get
        {
            if(getEmployees ==null)
            {
               
                getEmployees = [SELECT id,FirstName, LastName, Title, Email FROM Contact limit 20];
            }
            return getEmployees;

        }
         //MAKE SURE TO PUT IN YOUR PRIVATE VARIABLES INTO THE DYNAMIC QUERY
        								 //dynamic SOQL so it will change when user changes their inputfields
        set;
    }

    //the methods so we can connect our user input to our controllers
    public String getFirstName() //return the firstName
    {
        return associateFN;
    }

	public void setFirstName(String str1) //set our firstName
    {
        associateFN = str1;
    }


    public String getaLastName()
    {
        return associateLN;
    }

	public void setaLastName(String str2){
        associateLN = str2;
    }

    //for storing input for new employee record and used in employeecreateform component
    public String newFirstName //can't be private because it will cause errors
    {
        set;
        get;
    }
    public String newLastName
    {
        set;
        get;
    }

    //List<Contact> currentEmployeeList = [SELECT FirstName, LastName FROM Contact];
    List<Contact> currentEmployeeList = new List<Contact>();


    //newEmployee.Name = newFirstName + newLastName;
    //newEmployee.LastName = newLastName;

    //methods to provide our buttons functionality
    public void addEmployee2DB()
    {
        //Contact newEmployee = new Contact(FirstName = newFirstName, LastName = newLastName);
        //can't make a constructor... not allowed because DML statements from Constructor are not allowed
        /* YOu will get this error when you hit the save button
            DML currently not allowed
            An unexpected error has occurred. Your development organization has been notified.
       	*/

        //this needs to be in a method
        Contact newEmployee = new Contact(FirstName = newFirstName, LastName = newLastName); //we pass the newFirstName and newLastName
    	currentEmployeeList.add(newEmployee);

        //newEmployee.add(); NOT A LIST!

        try
        {

            Insert(newEmployee);
        }
        catch(DMLException dMLE)
        {
            System.debug('A DML error occurred... Here it is... ' + dMLE);
        }
        catch(Exception  e)
        {
            System.debug('Oooops a general error occurred... Here it is... ' + e);
        }
    }

    //EmployeeRelatedList2
    //Query for Housing Assignment by making sure the ID of contacts and Housing Assignment matches
    /*
    public List<Contact> getRelatedList()
    {
		//SOQL query so we can return any related lists
        List<Contact> listHA = database.query();

        return getRelatedList;
    }
	*/
}