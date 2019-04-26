/**************************************************************************
 * 	Purpose: This hold methods for many classes to be used
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/16/19
 * 	Last Modifyied Author:
 *  Last Modifyied Date:
 * 	Description:	
 *************************************************************************/ 
public class GeneralHelpers
{
/**************************************************************************
 * 	Purpose: To Pass back a list of ids for contacts
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/16/19
 * 	Last Modifyied Author:
 *  Last Modifyied Date:
 * 	Description:	
 *************************************************************************/ 
public static list<ID> returnIDs(list<sObject> newlist)
{ List<id> ListOfid = new list<id>();
    if(newlist != null)
    { 
        for(sObject tempSO : newlist)
        {
        	ListOfid.add(tempSO.id);
        }     
	}
    return ListOfid;
}

}