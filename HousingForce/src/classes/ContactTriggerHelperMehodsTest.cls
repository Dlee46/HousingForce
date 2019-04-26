@isTest
public class ContactTriggerHelperMehodsTest
{
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
 * 	Purpose: To test CheckIfEmployeeHasNewHousingApproved
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/25/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date: 4/25/19
 * 	Description: Testing check (0-false/1-true)
 * 					-Postive: 1
 * 					-negative: 1
 * 					-single case: 1
 * 					-Bulk:1
 * 					-restricted user: 0
 *************************************************************************/ 
@isTest static void CheckIfEmployeeHasNewHousingApprovedtest()
{
	map<id,contact> oldMap = TestFactory.createOLDmap();
	list<contact> newlist = [SELECT ID, NAME, EMAIL FROM CONTACT];
	
	Test.startTest();
	//postive test
		try
		{
		 ContactTriggerHelperMethods.CheckIfEmployeeHasNewHousingApproved(newlist,oldMap);
		}
		catch(exception e )
		{
			system.assert(false,'this is a postive test, and should not fail');
		}
		
	//negtive test
		list<contact> updatedContact = new list<contact>();
		for(contact c: newlist)
		{
            c.email = '';
			updatedContact.add(c);
		}
		update updatedContact;
		list<contact> newlist2 = [SELECT ID, NAME, EMAIL FROM CONTACT];
		try
		{
			 ContactTriggerHelperMethods.CheckIfEmployeeHasNewHousingApproved(newlist2,oldMap);
		}
		catch(exception e)
		{
			system.assert(true,'this should throw the error because the email doesnt have an @');
		}
		
	Test.stopTest();

}




 /**************************************************************************
 * 	Purpose: To test SendEmailToApprovedContact
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/25/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date: 4/25/19
 * 	Description: Testing check (0-false/1-true)
 * 					-Postive: 1
 * 					-negative: 1
 * 					-single case: 1
 * 					-Bulk:1
 * 					-restricted user: 0
 *************************************************************************/ 
@isTest static void SendEmailToApprovedContacttest()
{
	map<id,contact> oldMap = TestFactory.createOLDmap();
   	list<contact> newlist = [SELECT ID, NAME, EMAIL,Housing_Assignment_Count__c,Housing_Status__c FROM CONTACT];

	list<contact> updatedContact2 = new list<contact>();
	for(contact c: newlist)
	{
        c.Housing_Status__c = OrgContants.PICKLISTVALUE_HOUSING_ASSIGNMENT[1].getLabel();
		updatedContact2.add(c);
	}
	update updatedContact2;
	
	
	Test.startTest();

		//pos test
		try
		{
		 ContactTriggerHelperMethods.SendEmailToApprovedContact(newlist,oldMap);
		}catch(exception e)
		{
			System.assert(false,'this is a postive test and their is not suppose to be any errors');
		}
		
		//neg test
		list<contact> updatedContact = new list<contact>();
		for(contact c: newlist)
		{
            c.email = '';
			updatedContact.add(c);
		}
		update updatedContact;
		list<contact> newlist2 = [SELECT ID, NAME, EMAIL,Housing_Assignment_Count__c,Housing_Status__c FROM CONTACT];
		try
		{
			 ContactTriggerHelperMethods.SendEmailToApprovedContact(newlist2,oldMap);
		}
		catch(exception e)
		{
			System.assert(true,'expecting this to fail' + e);
		}
	Test.stopTest();
}    

}