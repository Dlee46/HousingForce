@isTest
public class ContactTriggerHelperHelperTest 
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
 * 	Purpose: To test NewHousingApprovalMessage
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
 @isTest static void NewHousingApprovalMessageTest()
 {
 	map<String,String> fullnames = TestFactory.firstandlastnames();
 	list<string> firstName = fullnames.values();
 	list<string> lastName = fullnames.values();
 	list<String> body = new list<String>();
	list<String> body2 = new list<String>();
 	test.startTest();
 		 for(integer i = 0; i < firstName.size();  firstName)
	 	{
	 		body.add(ContactTriggerHelperHelperMethods.NewHousingApprovalMessage(firstName[i],lastName[i],firstName[i],'zhaosteven76@yahoo.com'));
	 	}
	 	System.assertEquals(20,body.size(),'the size of body list is not 20');
	 	
	 	try
	 	{
	 		body2.add(ContactTriggerHelperHelperMethods.NewHousingApprovalMessage('1','2','3','null'));
	 	}
	 	catch(exception e)
	 	{
			System.assert(true);	 		
	 	}
	 	
 	test.stopTest();
 	
 }
 
 /**************************************************************************
 * 	Purpose: To test NewHousingApprovalMessage
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
 @isTest static void NewHousingApprovalMessageTest2()
 {
   map<String,String> fullnames = TestFactory.firstandlastnames();
 	list<string> firstName = fullnames.values();
 	list<string> lastName = fullnames.values();
 	list<String> body = new list<String>();
	list<String> body2 = new list<String>();
	
 	test.startTest();
 		for(integer i = 0; i < firstName.size();  firstName)
	 	{
	 		body.add(ContactTriggerHelperHelperMethods.NewHousingApprovalMessage(firstName[i],lastName[i],firstName[i],'zhaosteven76@yahoo.com',lastName[i]+firstName[i]));
	 	}
	 	System.assertEquals(20,body.size(),'the size of body list is not 20');
	 	
	 	try
	 	{
	 		body2.add(ContactTriggerHelperHelperMethods.NewHousingApprovalMessage('1','2','3','null','apples'));
	 	}
	 	catch(exception e)
	 	{
			System.assert(true,'tryin to thorw an error, null');	 		
	 	}
	 	
 	test.stopTest();
 	
 	
 }
 /**************************************************************************
 * 	Purpose: To test queryAddress
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/25/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date: 4/25/19
 * 	Description: Testing check (0-false/1-true)
 * 					-Postive: 1
 * 					-negative: 0
 * 					-single case: 1
 * 					-Bulk:1
 * 					-restricted user: 0
 *************************************************************************/ 
@isTest static void queryAddresstest()
{
	list<id> contactids = generalhelpers.returnIDs([SELECT ID FROM CONTACT]);
	list<id> housingids = generalhelpers.returnIDs([SELECT ID FROM CONTACT]);
	Test.startTest();
		map<id,string> contactMap = ContactTriggerHelperHelperMethods.queryAddress(contactids,0);
		for(id tempids: contactids)
		{
			if(contactMap.get(tempids)==null)
			{
				system.assert(false,'contactids doesnt exist in this map');
				
			}
		}
    	
		map<id,string> housingMAp = ContactTriggerHelperHelperMethods.queryAddress(housingids,1);
		for(id tempids: housingids)
		{
			if(housingMap.get(tempids)==null)
			{
				system.assert(false,'contactids doesnt exist in this map');
				
			}
		}
		
		system.assertEquals(null,ContactTriggerHelperHelperMethods.queryAddress(housingids,4),'not an null error');
		
	Test.stopTest();
	
}


}