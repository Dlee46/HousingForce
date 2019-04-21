public class ContactTriggerHelperHelperMethods 
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
        String Body = 'Dear '+firstName +' '+lastName
           +'\n You have been approved for housing and'+
            ' your new housing is at '+address+'. \n'
            +'Contact the housing department at '
            +housingEmail+',If you have any further '
            +'questions.';

        return Body;
    }
/**************************************************************************
 * 	Purpose: Query for Address
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	this return a map of an contact id and the address that is related to it.
 *************************************************************************/ 
    public static Map<id,String> queryAddress(list<id> contactIds)
    {
        Map<id,String> address = new Map<id,String>();
        if(contactIds.size()>0 && contactIds != null )
        {
            For(Housing_Assignment__C tempHA: [SELECT Contact__c,Housing__r.Address__c FROM Housing_Assignment__C])
            {
                For(Id tempId: contactIds)
                {
                    if(tempHA.Contact__c == tempId)
                    {
                       address.put(tempId,String.valueOf(tempHA.Housing__r.Address__c));
                    }
                }
            }
        }
        return address;
    }    

}