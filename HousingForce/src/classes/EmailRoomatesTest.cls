@isTest
public class EmailRoomatesTest 
{
    
    Map<id,Contact> oldMap;
    @TestSetup static void loadData()
    {
        list<Contact> testContact = TestFactory.MuiltContact(false);
        System.assert(testContact.size()>0);
        list<Housing__c> TestHousing = new list<Housing__c>();
        TestHousing.add(TestFactory.singleHousing(false,testContact.size()));
        System.assert(testHousing.size() > 0);
        insert testContact;
        insert TestHousing;
        list<Housing__c> housingIDS = [SELECT ID FROM HOUSING__c];
        list<Contact> contactIds = [SELECT ID FROM CONTACT];
        list<Housing_Assignment__c> newHA = TestFactory.HASingleHousing(Contactids.size(),false,housingIDS[0],ContactIDS);
        System.assert(newHa.size() > 0, 'This doesnt have anything in here');
      //this might not work still 
        insert newHA;

        
        
    }
    
    
    /**************************************************************************
* 	Purpose: To test checkifothersExistInHousingUnit
* 	Author:	 Steven Zhao
* 	Created Date:	
* 	Last Modifyied Author: Steven Zhao
*  Last Modifyied Date: 
* 	Description: Testing check (0-false/1-true)
* 					-Postive: 1
* 					-negative: 0
* 					-single case: 1
* 					-Bulk:1
* 					-restricted user: 0
*************************************************************************/ 
    
    @isTest static void checkifothersExistInHousingUnitTest()
    {
         Map<id,Contact> oldMap = new Map<id,Contact>();
        for(contact c:[SELECT ID,Employee_Status__C,Housing_Status__c FROM CONTACT])
        {
        	if(oldMap.get(c.id) == null)
        	{
        		oldMap.put(c.id,c);
             
        	}
        }
        
        list<Contact> updateContact = new list<contact>();
        for(contact c: [SELECT ID,name,Employee_Status__C,Housing_Status__c,Housing_Assignment_Count__c FROM CONTACT])
        {
        	c.Housing_Status__c = OrgContants.PICKLISTVALUE_HOUSING_ASSIGNMENT[1].getLabel();
        	updateContact.add(c);
            
        }
        system.assert(updateContact.size()>0,'updateContact list is empty');
        update updateContact;
        list<contact> newContact = [SELECT ID, NAME, EMAIL,Employee_Status__C,Housing_Assignment_Count__c ,Housing_Status__c FROM CONTACT ];
        list<contact> emptyContact = new list<contact>();
		
        test.startTest();
      
        try
        {
        	  EmailRoommates.checkIfothersExistInHousingUnit(newContact,oldMap);
        }
        catch(exception e )
        {
        
			 
			 System.assertEquals(0,Limits.getEmailInvocations(),'An error was not expected in this postive test');
        }
        try
        {
        	  EmailRoommates.checkIfothersExistInHousingUnit(emptyContact,oldMap);
        }
        catch(exception e )
        {
        	System.assert(true,'An error was expected in this neg test');
        }
        test.stopTest();
        
        
    }
    /**************************************************************************
* 	Purpose: To test textBody methods
* 	Author:	 Steven Zhao
* 	Created Date:	
* 	Last Modifyied Author: Steven Zhao
*  Last Modifyied Date: 
* 	Description: Testing check (0-false/1-true)
* 					-Postive: 1
* 					-negative: 1
* 					-single case: 1
* 					-Bulk:1
* 					-restricted user: 0
*************************************************************************/ 
    @isTest static void textbodyTest()
    {
    	list<contact> newName = [SELECT NAME FROM CONTACT];
    	list<string> Names = new list<string>();
    	for(contact c : newName)
    	{
    		 Names.add(c.name);
    	}
    	list<string> emptyList = new list<string>();
    	TEST.startTest();
    		//This checks for postive chase
    		system.assertNotEquals(null,Emailroommates.textBody(Names),'this is null this should not happen in this POS test');
    		//checking for neg case
    		Exception expectedException;
    		try
    		{
    			String teststring = Emailroommates.textBody(emptyList);
    		}
    		catch(exception e )
    		{
    			expectedException =e;
    		}
    		system.assertEquals(null,expectedException,'This is not a null, in the neg test');
    	TEST.stopTest();
    	
        
    }
    /**************************************************************************
* 	Purpose: To test sendingEmails
* 	Author:	 Steven Zhao
* 	Created Date:	
* 	Last Modifyied Author: Steven Zhao
*  Last Modifyied Date: 
* 	Description: Testing check (0-false/1-true)
* 					-Postive: 0
* 					-negative: 0
* 					-single case: 0
* 					-Bulk:0
* 					-restricted user: 0
*************************************************************************/ 
    @isTest static void sendingEmailTest()
    {
        
    }
    /**************************************************************************
* 	Purpose: To test  checkHousing
* 	Author:	 Steven Zhao
* 	Created Date:	
* 	Last Modifyied Author: Steven Zhao
*  Last Modifyied Date: 
* 	Description: Testing check (0-false/1-true)
* 					-Postive: 1
* 					-negative: 1
* 					-single case: 1
* 					-Bulk:1
* 					-restricted user: 0
*************************************************************************/ 
    @isTest static void checkHousingTest()
    {
 
        list<contact> newContact = [SELECT ID,NAME FROM CONTACT];
        System.assert(newContact.size()>0,'new contact has no contacts in it.');
        list<housing__C> testHousing = [SELECT ID FROM HOUSING__c];
        List<contact> emptylist = new list<contact>();
        Test.StartTest();
        list<id> newhousingids = EmailRoommates.checkHousing(newContact);
   
        for(id IDS: newhousingids)
        {
            for(housing__C h : testHousing)
            {
                if(iDS != h.id)
                    System.assert(false,'Housing id don\'t match the id in the testdatabase.');
            }
            
        }
        
        System.assertEquals(null,EmailRoommates.checkHousing(emptyList));
        
        Test.StopTest();
    }
    
    
    
}