@isTest
public class TestFactory 
{	//for single contact
    public static list<Contact> singleContact(String name1, boolean doInsert)
    {
        list<Contact> singleContact = new list<Contact>();
        singleContact.add(new Contact(Firstname = name1, lastName= ' '+ 1,
                                      email  ='stevenzhao76@gmail.com',
                                      Housing_Status__c = OrgContants.PICKLISTVALUE_HOUSING_ASSIGNMENT[0].getLabel(), 
                                      Gender__C = OrgContants.PICKLISTVALUE_GENDER[0].getLabel(),
                                      Employee_Status__C = OrgContants.PICKLISTVALUE_EmloyeeStatus[0].getLabel(),
                                      Start_Date__C = date.today()));
        
        if(doInsert == true)
        {
            insert singleContact;
        }
        return singleContact;
    }
    //for more then one bulk
    public static list<Contact> MuiltContact(boolean doInsert)
    {
        list<Contact> Contacts = new list<Contact>();
        for(integer i= 0; i < 20; i ++)
        {
            Contacts.add(new Contact(firstName = 'Test ', 
                                     lastname= ' '+ i,
                                     email = 'stevenzhao76@gmail.com',
                                     Housing_Status__c = OrgContants.PICKLISTVALUE_HOUSING_ASSIGNMENT[0].getLabel(), 
                                     Gender__C = OrgContants.PICKLISTVALUE_GENDER[0].getLabel(),
                                     Employee_Status__C = OrgContants.PICKLISTVALUE_EmloyeeStatus[0].getLabel(),
                                     Start_Date__C = date.today()));
        }
        if(doInsert == true)
        {
            insert Contacts;
        }
        return Contacts;
    }
    //for single Service appointment
    public static Service_Appointment__c singleSAcase(boolean doInsert)
    {
        Service_Appointment__c singleSA = new Service_Appointment__c();
        singleSA =new Service_Appointment__c(Company_Name__c = 'Test ');
        if(doInsert == true)
        {
            insert singleSA;
        }
        
        return singleSA;
    }
    //for build Service appointment
    public static list<Service_Appointment__c> MuiltSAcaseforonehousing(boolean doInsert,id housingid)
    {
        list<Service_Appointment__c> MuiltSA = new list<Service_Appointment__c>();
        for(integer i= 0; i < 20; i ++)
        {
            MuiltSA.add(new Service_Appointment__c(Company_Name__c = 'Test ' + i, 
            										Date__C = date.today(),time__C = Time.newInstance(1,1,1,1),
                                                    Type_of_Service__c = OrgContants.PICKLISTVALUE_SERVICE_APPOINTMENT_TYPEOFSERVICE[0].getlabel(),
                                                    Cleaning_Reason__C =OrgContants.PICKLISTVALUE_SERVICE_APPOINTMENT_CLEANING_REASON[0].getLabel()));
        }
        if(doInsert == true)
        {
            insert MuiltSA;
        }
        
        return MuiltSA;
    }
    //singe housing assingment
    public static list<Housing_Assignment__C> HASingleHousing(integer ContactMax,boolean doInsert,Housing__C housingIds, List<contact> ContactIds)
    {
        list<Housing_Assignment__C> HAnew = new list<Housing_Assignment__C>();
        for(integer i = 0; i <ContactMax; i++ )
        {
            HAnew.add(new Housing_Assignment__C(name = 'Test '+ i,Arrival_Date_and_Time__c= date.Today(),Contact__C = ContactIds[i].id,Housing__c = housingIds.id ));
        }
        if(doInsert == true)
        {
            insert HAnew;
        }
        return HAnew;  
    }
    //bulk housing assignment
    public static list<Housing_Assignment__C> HADiffrentHousing(integer ContactMax,boolean doInsert,List<Housing__C> housingIds, List<Contact> ContactIds)
    {
        list<Housing_Assignment__C> HAnew = new list<Housing_Assignment__C>();
        for(integer i = 0; i <ContactMax; i++ )
        {
            HAnew.add(new Housing_Assignment__C(name = 'Test '+ i,Arrival_Date_and_Time__c= date.Today(),Contact__C = ContactIds[i].id,Housing__c = housingIds[i].id ));
        }
        if(doInsert == true)
        {
            insert HAnew;
        }
        return HAnew;
    } 
    //single housing 
    public static Housing__C singleHousing(boolean doInsert, integer MaxOccupants)
    {
        Housing__c newHousing = new Housing__C(name = 'TestHousing',
                                               Active__c = true,
                                               Max_Occupants__c=MaxOccupants,
                                               Group_Designation__C = OrgContants.PICKLISTVALUE_HOUSING_GENDER[0].getLabel(),
                                               Address__C = '666 Final Destnation Street');
        if(doInsert == true)
        {
            insert newHousing;
        }
        
        return newHousing;
        
    }
    //build housing
    public static List<Housing__C> MuiltHousing(boolean doInsert, integer MaxOccupants, integer NumberofContacts)
    {
        List<Housing__C> HousingList = new list<Housing__c>();
        for(integer i =0; i < NumberofContacts; i++)
        {
            HousingList.add(new Housing__C(name = 'TestHousing' + i,
                                               Active__c = true,
                                               Max_Occupants__c=MaxOccupants,
                                               Group_Designation__C = OrgContants.PICKLISTVALUE_HOUSING_GENDER[0].getLabel(),
                                               Address__C = '666 Final Destnation Street'));
        }
        if(doInsert == true)
        {
            insert HousingList;
        }
        
        return HousingList;
        
    }
    
    
    //generates a user 
    public static User generateUser(String profileName)
    {
        UserRole userRole = new UserRole(DeveloperName = 'TestingTeam', Name = 'Testing Team');
        insert userRole;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = :profileName].Id,
            LastName = 'last',
            Email = 'Cpt.Awesome@awesomesauce.com',
            Username = 'Cpt.Awesome@awesomesauce.com',
            CompanyName = 'Testing Co',
            Title = 'Captian',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = userRole.Id
        );
        insert u;
        return u;
    }
    //generate a list of names
    public static list<string> generateNames()
    {
    	list<string> listofnames = new list<string>();
    	for(integer i = 0; i < 20; i++)
    	{
    		listofnames.add('testName' + i);
    	}
    	return listofnames;
    }
    //return a map of firstname and lastname;
    public static Map<string,string> firstandlastnames()
    {
    	
    	map<string,string> fullnames = new map<string,string>();
    	
    	for(integer i = 0; i < 20; i++)
    	{
    		fullnames.put('firstName '+i,'lastName ' + i);
    	}
    	
    	return fullnames;
    }
    
    public static map<id,Contact> createOLDmap()
    {
    	Map<id,Contact> oldMap = new Map<id,Contact>();
        for(contact c:[SELECT ID,Employee_Status__C,Housing_Status__c FROM CONTACT])
        {
        	if(oldMap.get(c.id) == null)
        	{
        		oldMap.put(c.id,c);
             
        	}
        }
        return oldMap;
    }
    
}