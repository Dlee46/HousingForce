public class ContactTriggerHelperMethods 
{
/**************************************************************************
 * 	Purpose: To check if a new housing email need to be sent out
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	this checks if the past housing assignment was in 'process' and compares it to the new version 
 *                     'Assigned' and check if the the oldMap of the housing_status was processed, and will not send 
 * 				 an email if it was anything else. 
 *************************************************************************/ 

    public static void CheckIfEmployeeHasNewHousingApproved(List<Contact> newList, Map<id,Contact> oldMap)
    {
		        
        if(newlist.size()>0 && newlist != null )
        {           
            String emailSubject = 'New Housing<do-not-reply>';
            list<ID> contactIds = GeneralHelpers.returnIDs(newlist);
            list<String> body = new list<String>();
            list<String> emailList = new list<String>();
            Map<id,String> address =ContactTriggerHelperHelperMethods.queryAddress(contactIds);
            List<Messaging.SingleEmailMessage> listOfEmail;
            for(Contact tempC: newlist)   
            {	
                if(oldMap.containsKey(tempC.Id)&& oldMap.get(tempC.Id) !=null)
                {
                    Contact tempContact = oldMap.get(tempC.Id);
                    
                    if(string.valueOf(tempC.Housing_Status__c) == OrgContants.PICKLISTVALUE_HOUSING_ASSIGNMENT[1].getlabel() 
                       &&string.valueOf(tempContact.Housing_Status__c) == OrgContants.PICKLISTVALUE_HOUSING_ASSIGNMENT[0].getLabel()
                       &&TempC.Housing_Assignment_Count__c>0)
                    {
                        emailList.add(tempC.Email);
                        body.add(ContactTriggerHelperHelperMethods.NewHousingApprovalMessage(tempC.FirstName,tempC.LastName,address.get(tempC.Id),'Housing@Testrev.com'));
                    	GeneralHelpers.CreateTask('Emails Sent to: ' + tempC.FirstName+' '+ tempC.lastName, 2);
                    }
                    
                }
            }
            listOfEmail= OutBoundEmail.create_Email(emailList,emailSubject,body);
            if(listOfEmail != null)
            {
                Messaging.sendEmail(listOfEmail);
                
                listOfEmail.clear();
                
                
            }
        }
    }
 
    


}