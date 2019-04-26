@isTest
public class ServiceAppointmentEmailTest 
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
 * 	Purpose: To test returnServiceAppointment
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/25/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date: 
 * 	Description: Testing check (0-false/1-true)
 * 					-Postive: 1
 * 					-negative: 1
 * 					-single case: 1
 * 					-Bulk:1
 * 					-restricted user: 0
 *************************************************************************/ 
    @istest static void returnServiceAppointment()
    {
    	list<id> ids = GeneralHelpers.returnids([SELECT ID FROM CONTACT]);
    	Test.startTest();
    		map<id,string> serviceAppointment = ServiceAppointmentEmail.returnServiceAppointment(ids);
    		system.assert(serviceAppointment.size()>0,'this map should have items in it');
    		for(id tempiDS: ids)
    		{
    			if(serviceAppointment.get(tempiDS) ==null)
    				system.assert(false,'An id doesnt exist in the serviceAppointment Map');
    				
    		}
    		list<id> emptyidList = new list<id>();
    		try
    		{
    			map<id,string> serviceAppointment2 = ServiceAppointmentEmail.returnServiceAppointment(emptyidlist);
    		}
    		catch(exception e)
    		{
    			System.assertEquals(null,e,'should be an null pointer exception or return a null' + e);
    		}
    	Test.stopTest();
    }

}