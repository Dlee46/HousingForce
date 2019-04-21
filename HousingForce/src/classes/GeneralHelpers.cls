/**************************************************************************
 * 	Purpose: This hold methods for many classes to be used
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/16/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date:4/16/19
 * 	Description:	
 *************************************************************************/ 
public class GeneralHelpers
{
/**************************************************************************
 * 	Purpose: To Pass back a list of ids for contacts
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/16/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/16/19
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
/**************************************************************************
 * 	Purpose: Creates a task for the current user.
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/21/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/21/19
 * 	Description:	This is ment for alerting the user that emails were sent. After something has been Approved
 *************************************************************************/     
public static void CreateTask(String Comments, Integer Subject)
{
    Task CreateTask = new Task();
    CreateTask.Subject = OrgContants.PICKLISTVALUE_TASK_SUBJECT[1].getLabel();
    CreateTask.Status =  OrgContants.PICKLISTVALUE_TASK_STATUS[Subject].getLabel();
    CreateTask.Priority =OrgContants.PICKLISTVALUE_TASK_PRIORITY[2].getLabel();
    CreateTask.ActivityDate = Date.today();
    CreateTask.Description = Comments;
    CreateTAsk.OwnerId =UserInfo.getUserId();
    DataBase.insert(new list<Task>{CreateTask},false);
    
}

    
    
}