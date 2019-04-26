public with sharing class ContactTriggerHelperHelperMethods 
{
 /**************************************************************************
 * 	Purpose: Creates the Body for the email.
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	This is a body text for the new howing email
 *************************************************************************/ 
    public static String NewHousingApprovalMessage(String firstName, String lastName,String address,String HousingEmail)
    {
    	if(firstName != null && lastName != null && address != null && housingEmail != null && housingEmail.contains('@'))
    	{

        	String Body = 'Dear '+firstName +' '+lastName
           +'\n You have been approved for housing and'+
            ' your new housing is at '+address+'. \n'
            +'Contact the housing department at '
            +housingEmail+',If you have any further '
            +'questions.';
        	return Body;
    	}return null;
    }
  /**************************************************************************
 * 	Purpose: Creates the Body for the email. if They have a cleaning service
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/23/19
 * 	Description:	This is a body text for the new howing email
 *************************************************************************/    
    public static String NewHousingApprovalMessage(String firstName, String lastName,String address,String HousingEmail,String HousingService)
    {
    	if(firstName != null && lastName != null && address != null && housingEmail != null && HousingService != null && housingEmail.contains('@'))
    	{
        	String Body = 'Dear '+firstName +' '+lastName
           +'\n You have been approved for housing and'+
            ' your new housing is at '+address+'. \n'
            +'Contact the housing department at '
            +housingEmail+',If you have any further '
            +'questions.'+'\nCleaning Serivce is at ' + housingService;
    	 	return Body;
    	}return null;
       
    }
/**************************************************************************
 * 	Purpose: Query for Address, 0 is for contact id and 1 is for housing id
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	this return a map of an contact id and the housing address that is related to it.
 *************************************************************************/ 
    public static Map<id,String> queryAddress(list<id> contactIds, Integer typeofIdRelatedtoHA)
    {
        Map<id,String> address = new Map<id,String>();
        if( contactIds != null &&contactIds.size()>0 && (typeofIdRelatedtoHA == 0 || typeofIdRelatedtoHA == 1))
        {
            For(Housing_Assignment__C tempHA: [SELECT Contact__c,Housing__r.Address__c FROM Housing_Assignment__C WHERE CONTACT__c IN :contactIds])
            {
                if( typeOfIdRelatedtoHA == 0)
                {
                    address.put(tempHA.Contact__c,String.valueOf(tempHA.Housing__r.Address__c)); 
                }
                else if(typeofIdRelatedtoHA == 1)
                    address.put(tempHA.Housing__c,String.valueOf(tempHA.Housing__r.Address__c)); 
                             
            }
            return address;
        } 
       return null;
    }    

}