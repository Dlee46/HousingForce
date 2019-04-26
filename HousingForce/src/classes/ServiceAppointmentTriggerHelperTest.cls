@isTest
public class ServiceAppointmentTriggerHelperTest 
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
 * 	Purpose: To test 
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
 @istest static void checkServiceForTriggerInsertTest()
 {
 	
 }
 /**************************************************************************
 * 	Purpose: To test 
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
 @isTest static void checkServiceForTriggerUpdatetest()
 {
 	
 }

 /**************************************************************************
 * 	Purpose: To test queryForContacts
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
 @isTest static void queryForContactstest()
 {
     
     list<id> HAids = GeneralHelpers.returnIds([SELECT ID FROM HOUSING__C]);
	list<id> empty = new list<id>();
	test.starttest();
	map<id,list<string>> contactEmails = ServiceAppointmentTriggerHelper.queryForContacts(HAids);
	for(id hids:HAids)
	{
		if(contactEmails.get(Hids) == null)
			system.assert(false,'this id is suppose to exist in the HAids list');
	}
	
	try
	{
		ServiceAppointmentTriggerHelper.queryForContacts(HAids);
	}
	catch(exception e )
	{
		system.assertEquals(null,e,'should return a null pointer');
	}
	
	test.stoptest();
	
 	
 }
 /**************************************************************************
 * 	Purpose: To test CreateAndSendEmail
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
 @isTest static void CreateAndSendEmailTest()
 {
 	list<id> housingids = GeneralHelpers.returnids([SELECT ID FROM HOUSING__c LIMIT 1]);
 	list<Service_Appointment__C> SA = TestFactory.MuiltSAcaseforonehousing(false,housingids[0]);
 	list<id> HAids = GeneralHelpers.returnIds([SELECT ID FROM HOUSING__C]);
	map<id,list<string>> contactEmails = ServiceAppointmentTriggerHelper.queryForContacts(HAids);
	list<id> emptylist = new list<id>();
	Test.startTest();
		try
		{
			ServiceAppointmentTriggerHelper.CreateAndSendEmail(HAids,'subject',SA,contactEmails,0);
		}catch(exception e)
		{
			system.assert(false,'pos test not suppose to find an exception');
		}
	 	try
	 	{
	 		ServiceAppointmentTriggerHelper.CreateAndSendEmail(emptylist,'subject',SA,contactEmails,4);
	 	}
	 	catch(exception e)
	 	{
	 		System.assert(true,'trying to get an error because an emty list and 4 is not goning to make is work');
	 	}
	Test.stopTest(); 	
 	
 	
 }
 /**************************************************************************
 * 	Purpose: To test textBody
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
	@isTest static void textBodyTest()
	{
		test.startTest();
		list<string> listBody = new list<string>();
		for(integer i = 0; i < 20; i++)
		{
			listBody.add(ServiceAppointmentTriggerHelper.textbody(0,0,4,date.today(),Time.newInstance(1,1,1,1)));
		}
		System.assert(listbody.size()>0,'nothing was inserted in listbody');
		list<string> listBody2 = new list<string>();
		for(integer i = 0; i < 20; i++)
		{
			listBody2.add(ServiceAppointmentTriggerHelper.textbody(0,2,4,date.today(),Time.newInstance(1,1,1,1)));
		}
		System.assert(listbody2.size()>0,'nothing was inserted in listbody2');
		list<string> listBody3 = new list<string>();
		for(integer i = 0; i < 20; i++)
		{
			listBody3.add(ServiceAppointmentTriggerHelper.textbody(1,0,4,date.today(),Time.newInstance(1,1,1,1)));
		}
		System.assert(listbody3.size()>0,'nothing was inserted in listbody3');
		list<string> listBody4 = new list<string>();
		for(integer i = 0; i < 20; i++)
		{
			listBody4.add(ServiceAppointmentTriggerHelper.textbody(1,2,4,date.today(),Time.newInstance(1,1,1,1)));
		}
		System.assert(listbody4.size()>0,'nothing was inserted in listbody4');

		
		System.assertEquals(null,ServiceAppointmentTriggerHelper.textbody(8,2,4,date.today(),Time.newInstance(1,1,1,1)),'should have returned a null');
		
		test.stoptest();
	}
}