/**************************************************************************
 * 	Purpose: To Test the generalHelpers class
 * 	Author:	 Steven Zhao
 * 	Created Date: 4/24/19	
 * 	Last Modifyied Author:  Steven Zhao
 *  Last Modifyied Date: 4/24/19
 * 	Description:	 To test every case possible, ie(postive/negative case, single/bulk case, user restricted case)
 *************************************************************************/ 

@isTest
public class GeneralHelpersTest 
{
	@TestSetup
    static void loadGeneralData()
    {
        list<contact> testContact = TestFactory.MuiltContact(false);
        insert testContact;

    }
	    

    
    
/**************************************************************************
 * 	Purpose: To test returnIDs
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/24/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date: 4/24/19
 * 	Description: Testing check (0-false/1-true)
 * 					-Postive: 1
 * 					-negative: 0ish
 * 					-single case: 1
 * 					-Bulk:1
 * 					-restricted user: 0
 *************************************************************************/ 
	
    @isTest static void returnIDsTest()
    {
        list<Contact> newContact = [SELECT ID FROM CONTACT];
        list<Contact> emptyContact = new List<Contact>();
        System.assert(newContact.size()>0, 'no Contacts in the newContact list.');
        TEST.startTest();
        	
        	System.assertEquals(true,Generalhelpers.returnIDs(emptyContact).isEmpty(),'should have return true from emptyContact because it is empty');
        	list<id> newIds = Generalhelpers.returnIDs(newContact);
        	System.assertEquals(newContact.size(),newIds.size(),' newids size is not the same as newcontacts');
        	For(Contact c : newContact)
            {
                For(id IDS : newIds)
                {
                    if(c.id == ids)
                    {
                        System.assert(true,'this id doesn\'t exist in the newContacts');
                    }
                }
                
            }
        
        TEST.stopTest();
        
    }
/**************************************************************************
 * 	Purpose: To test CreateTask
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/24/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date: 4/24/19
 * 	Description: Testing check (0-false/1-true)
 * 					-Postive: 1
 * 					-negative: 0
 * 					-single case: 1
 * 					-Bulk:1
 * 					-restricted user: 0
 *************************************************************************/ 
    @isTest static void CreateTaskTest()
    {
        
        
        Test.startTest();
        //bulktest
        //        
        for(integer i = 0; i < 20; i++)
        {
            String comments = 'test' +i;
            Integer status = 2;
            GeneralHelpers.createTask(comments,status);
        }
        list<Task> newTasklist = new list<task>();
        newTasklist = [SELECT ID FROM TASK];
        System.assert(newTasklist.size() > 0,'no task was found');
        System.assert(newTasklist.size()==20,'newTasklist does not equal 20');
        Test.stopTest();
        
        
    }
/**************************************************************************
 * 	Purpose: To test returnDayofWeek
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/24/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date: 4/24/19
 * 	Description: Testing check (0-false/1-true)
 * 					-Postive: 1
 * 					-negative: 0
 * 					-single case: 1
 * 					-Bulk:1
 * 					-restricted user: 0
 *************************************************************************/ 
 @isTest static void returnDayofWeekTest()
 {
     list<Integer> listOFRandomNumbersPOS = new list<Integer>();
     list<Integer> listOFRandomNumbersNEG = new list<Integer>();

     
     for(integer i = 1 ; i< 100; i++)
     {
		if(i < 8)
         listOfRandomNumbersPOS.add(i);
         listOFRandomNumbersNEG.add((i+7));
     }
     
     test.startTest();
     for(Integer x : listOFrandomNumbersPOS)
     {
         if(GeneralHelpers.returnDayofWeek(x) == null)
			System.Assert(false,'this is returning a null during a postive testing');
         
     }
     //neg test
     for(Integer y :listOFRandomNumbersNEG )
     {
         System.assertEquals(null,GeneralHelpers.returnDayofWeek(y),'listOFRandomnumbersNEG: is not returning a null');
     }
		System.assertEquals(null,GeneralHelpers.returnDayofWeek(-1),'not returning a null for a negtive number');     	
     test.stopTest();
	     
 }
 /**************************************************************************
 * 	Purpose: To test returnWeekANDdays
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/24/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date: 4/24/19
 * 	Description: Testing check (0-false/1-true)
 * 					-Postive: 1
 * 					-negative: 1
 * 					-single case: 1
 * 					-Bulk:1
 * 					-restricted user: 0
 *************************************************************************/ 
@isTest static void returnWeekANDdaysTest()
 {
 
     list<Integer> listOFRandomNumbers = new list<Integer>();
	 list<Integer> listOfempty = new list<Integer>();
     
     for(integer i = 0 ; i< 100; i++)
     {
         
        
         listOFRandomNumbers.add((i));
     }
     
     test.startTest();
 
     for(Integer y :listOFRandomNumbers )
     {
       if(GeneralHelpers.returnWeekANDdays(y) ==null)
         System.assert(false,'GeneralHelpers.returnweekanddays is returning a null in a POS test');
     }
     for(integer x: listOfempty)
     {
         System.assertEquals(null, GeneralHelpers.returnWeekANDdays(x), 'listOfempty: not reutrning null');
     }
     
     System.assertEquals(null,GeneralHelpers.returnWeekANDdays(-1),'not returning a null for a negtive number');
     test.stopTest();
 }
}