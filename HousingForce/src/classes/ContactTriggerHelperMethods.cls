public with sharing class ContactTriggerHelperMethods 
{
/**************************************************************************
 * 	Purpose: To check if the contact has an email
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
    	if(newlist != null && oldMap != null)
    	{
	        list<Contact> CheckedList = new list<Contact>();
	        for(Contact tempC : newlist)
	        {
	            if(tempC.Email != null && tempC.Email.contains('@'))
	            {
	            	CheckedList.add(TempC);
	            }
	            	
	        }
			if(CheckedList != null && CheckedList.Size()>0)    
	        	SendEmailToApprovedContact(CheckedList,oldMap);
    	}
    }
/**************************************************************************
 * 	Purpose: Sends out emails to the new Approved Contact
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	this checks if the past housing assignment was in 'process' and compares it to the new version 
 *                     'Assigned' and check if the the oldMap of the housing_status was processed, and will not send 
 * 				 an email if it was anything else. 
 *************************************************************************/  
    public static Void SendEmailToApprovedContact(list<Contact> newlist,Map<id,Contact> oldMap)
    {          
            String emailSubject = 'New Housing<do-not-reply>';
            list<ID> contactIds = GeneralHelpers.returnIDs(newlist);
        	
            list<String> body = new list<String>();
            list<String> emailList = new list<String>();
            map<id,String> address =ContactTriggerHelperHelperMethods.queryAddress(contactIds,0);
        	map<id,String> CleaningService = ServiceAppointmentEmail.returnServiceAppointment(contactIds);
            list<Messaging.SingleEmailMessage> listOfEmail;
            for(Contact tempC: newlist)   
            {	
                if(oldMap.containsKey(tempC.Id)&& oldMap.get(tempC.Id) !=null)
                {
                    Contact tempContact = oldMap.get(tempC.Id);
                    
                    if(string.valueOf(tempC.Housing_Status__c) == OrgContants.PICKLISTVALUE_HOUSING_ASSIGNMENT[1].getlabel() 
                       &&string.valueOf(tempContact.Housing_Status__c) == OrgContants.PICKLISTVALUE_HOUSING_ASSIGNMENT[0].getLabel()
                       &&TempC.Housing_Assignment_Count__c>0 && tempC.Email != null)
                    {
                        emailList.add(tempC.Email);
                        if(cleaningService.get(TempC.id)==null)
                        {
                            body.add(ContactTriggerHelperHelperMethods.NewHousingApprovalMessage(tempC.FirstName,tempC.LastName,address.get(tempC.Id),'Housing@Testrev.com'));
                            GeneralHelpers.CreateTask('Emails Sent to: ' + tempC.FirstName+' '+ tempC.lastName, 2);
                        }
                        else if(cleaningService.get(TempC.id)!=null)
                        {
                            body.add(ContactTriggerHelperHelperMethods.NewHousingApprovalMessage(tempC.FirstName,tempC.LastName,address.get(tempC.Id),'Housing@Testrev.com',CleaningService.get(TempC.id)));
                            GeneralHelpers.CreateTask('Emails Sent to: ' + tempC.FirstName+' '+ tempC.lastName, 2);                      
                        }
                    }
                    
                }
            }
            listOfEmail= OutBoundEmail.create_Email(emailList,emailSubject,body);
            if(listOfEmail != null)
            {
              
               // Messaging.sendEmail(listOfEmail);
                listOfEmail.clear();
                
                
            }
        
    }
	

}