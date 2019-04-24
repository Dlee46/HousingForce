public with sharing class EmailRoommates
{

/**************************************************************************
 * 	Purpose: To check if the housing contain other peoples for insert
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	This is a body text for the new howing email
 *************************************************************************/ 
    public static void checkIfothersExistInHousingUnit(list<Contact> newlist,Map<id,Contact> oldMap)
    {
        //checking triggers incase a contact is not assigned to any housing units already.
        List<Contact> CheckedList = new list<Contact>();
        for(contact tempCC: newlist)
        {
            if(tempCC.Housing_Assignment_Count__c>0 && tempCC.Email !=null && oldMap.get(tempCC.id)!=null)
            {
                Contact tempContact = oldMap.get(tempCC.id);
                if(tempContact.Housing_Status__c == OrgContants.PICKLISTVALUE_HOUSING_ASSIGNMENT[0].getLabel())
                	Checkedlist.add(tempCC);
            }
        }
        if(CheckedList != null && Checkedlist.size()>0)
        {
			sendingEmails(CheckedList);
        }
    }
/**************************************************************************
 * 	Purpose: This is ment for the body of the email
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	iterates though the list and adds a name
 *************************************************************************/ 

public static String textBody(List<String> name)
{
    String MessageStart = 'Hello everyone,\n you have a new roommate:\n';
    String MessageName='';
    String MessageEnd = ' if you have any Question message the housing Deparment.' ;
    for(string tempN: name)
    {
        MessageName = MessageName + ' '+tempN+'\n';
    }
    return MessageStart + MessageName + MessageEnd;
}
/**************************************************************************
 * 	Purpose: To send email out to anyone related to a housing that has been added to.
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	
 *************************************************************************/    
public static void sendingEmails(List<contact> CheckedList)
{
	list<id> TempIds = checkHousing(CheckedList);
    
    List<housing__C> housing = [SELECT (SELECT CONTACT__R.NAME,CONTACT__R.EMAIL FROM Housing_Assignments__r) 
                                FROM housing__c 
                                WHERE CURRENT_Occupants__C > 1
                                AND HOUSING__C.ID IN :TempIds
                                AND (ACTIVE__C= true)];
    TempIds.clear();
 
    if(housing != null && housing.size()>0)
    {
        for(contact tempC : CheckedList)
        {
            If(tempC.Email != null && String.valueOf(tempC.Housing_Status__c) == OrgContants.PICKLISTVALUE_HOUSING_ASSIGNMENT[1].getlabel() )
            {
                list<String> emailList = new list<String>();
                String subject = '<do-not-rely> Current Housing Members';
                list<String> nameList = new list<String>();
                List<Messaging.SingleEmailMessage> outBoundEmails;
                //this loops though the housing
                for(housing__c tempH : housing)
                {//this loops though housing assignment and get the related contacts emails and names
                    for(Housing_Assignment__C tempHA: tempH.Housing_Assignments__r)
                    {
                        if(tempHA.Contact__r.Email != null)
                            emailList.add(tempHA.Contact__r.Email);                    
                        namelist.add(tempHA.Contact__r.Name);
                        
                    }
                    if(emailList != null && emailList.size() > 0)
                    {
                        outBoundEmails=OutBoundEmail.Create_Email(emailList, subject, textBody(namelist));
                        Messaging.sendEmail(outBoundEmails);
                        GeneralHelpers.CreateTask('Emails Sent to: ' + nameList, 2);
                        emailList.clear();
                        namelist.clear();
                    }
                }
            }
        }
    }
}
/**************************************************************************
 * 	Purpose: Helper method to return a list of housing id from the contact
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	
 *************************************************************************/ 
public static List<id> checkHousing(list<Contact> newContactList)
{
    List<Id> contactIds  = generalhelpers.returnIDs(newContactList);
    List<Id> housingIds = new list<id>();
    for(Housing_Assignment__C tempHA :[SELECT HOUSING__r.id FROM HOUSING_ASSIGNMENT__C WHERE CONTACT__r.id IN :contactIds])
    {
        housingIds.add(tempHA.Housing__r.id);
    }
   	return housingIds;
}    
    
}