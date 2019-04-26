/**************************************************************************
 * 	Purpose: Helper class for the trigger on Housing_Assignment
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/16/19
 * 	Last Modifyied Author:
 *  Last Modifyied Date:
 * 	Description:	
 *************************************************************************/ 
public class Housing_AssignmentTriggerHelper
{
    
/**************************************************************************
 * 	Purpose: to check if the contact already has a housing assinment 
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/16/19
 * 	Last Modifyied Author:
 *  Last Modifyied Date:
 * 	Description:	Throws an error if this person exist in the housing
 *************************************************************************/ 
    public static void CheckHousingForContact(list<Housing_Assignment__c> newlist)
    {
        list<id> newlistOfContacts = new list<id>();  
        for(Housing_Assignment__C tempQuery: [SELECT ID, CONTACT__C FROM Housing_Assignment__C ])
            for(Housing_Assignment__c temp : newlist)
            {
              if(tempQuery.id != temp.id )
              {
                  if(tempQuery.Contact__c == temp.Contact__c)
                  {
                      temp.addError('This Contact Already has a Housing unit!!');
                      
                  }
              }
            }
   		        
        
    
    }

}