@isTest
public class ServiceTriggerTest
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
 @isTest static void ServiceTriggers()
 {
     list<id> HAids = GeneralHelpers.returnIds([SELECT ID FROM HOUSING__C]);
     Test.startTest();
     List<Service_Appointment__c> serviceInsert = TestFactory.MuiltSAcaseforonehousing(false,HAids[0]);
     insert serviceInsert;
     list<Service_Appointment__C> testService = [SELECT ID,Date__c FROM Service_Appointment__c];
     System.assertEquals(20,testService.size(),'pos test fails');
            
     list<Service_Appointment__C> updatelist = new list<Service_Appointment__c>();
     for(Service_Appointment__C SA : testService)
     {
         SA.Date__c = Date.today() +1;
         updatelist.add(SA);
     }
	 try
     {
     	update updatelist;
     }
     catch(DmlException	e)
     {
         System.assert(false,'update is suppose to update');
     }
     Test.stopTest();
     
 }
}