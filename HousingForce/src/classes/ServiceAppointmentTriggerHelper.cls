public WITH SHARING class ServiceAppointmentTriggerHelper 
{
    /**************************************************************************
* 	Purpose:  to check the type of Service being created, checking if its either cleaning or maintaince
* 	Author:	 Steven Zhao
* 	Created Date:	4/24/19
* 	Last Modifyied Author: Steven Zhao
*   Last Modifyied Date:
* 	Description:	
*************************************************************************/	
    public static void checkServiceForTriggerInsert(list<Service_Appointment__C> newlist)
    {	//check if cleaning or maintenance
        
        if(newlist != null && newlist.size() > 0)
        {
            List<id> CleaningHousingIds = new list<id>();
            List<id> MaintenanceHousingIds = new list<id>();
            for(Service_Appointment__C tempSAC : newlist)
            {
                if(tempSAC.Type_of_Service__c == OrgContants.PICKLISTVALUE_SERVICE_APPOINTMENT_TYPEOFSERVICE[0].getLabel())
                { 
                    CleaningHousingIds.add(tempSAC.Housing__c);
                }
                else if(tempSAC.Type_of_Service__c == OrgContants.PICKLISTVALUE_SERVICE_APPOINTMENT_TYPEOFSERVICE[1].getLabel())
                {
                    MaintenanceHousingIds.add(TempSAC.Housing__c);
                }
            }
            
            //otherwise if there are people email them
            if(CleaningHousingIds != null && CleaningHousingIds.size() > 0)
            { //check if current house has people AND QUERY FOR HOUSING WITH PEOPLE
                map<id,list<String>> contactEmailsForCleaning = queryForContacts(CleaningHousingIds);
                String subject = '<no-reply> new Cleaning Appointment';
                CreateAndSendEmail(CleaningHousingIds,subject,newlist,contactEmailsForCleaning,0);	
            }
            
            if(MaintenanceHousingIds != null && MaintenanceHousingIds.Size() > 0)
            {//checks for the current contact email in the house and sends an email to them
                map<id,list<String>> contactEmailsForMaintenance = queryForContacts(MaintenanceHousingIds);
                String subject = '<no-reply new Maintenance Appointment>';
                CreateAndSendEmail(MaintenanceHousingIds,subject,newlist,contactEmailsForMaintenance,1);
            }
        }       
    }
    
/**************************************************************************
* 	Purpose:Check for update change and if the change is related to a new day
* 	Author:	 Steven Zhao	
* 	Created Date:	4/23/19
* 	Last Modifyied Author: Steven Zhao
*  Last Modifyied Date: 4/23/19
* 	Description:	 this returns a map<id,list<string>> to email the user to the related service appointments (cleaning or maintaince)
*************************************************************************/
    public static void checkServiceForTriggerUpdate(list<Service_Appointment__C> newlist, Map<id,Service_Appointment__C> oldMap)
    {
        List<id> CleaningHousingIds = new list<id>();
        List<id> MaintenanceHousingIds = new list<id>();
        for(Service_Appointment__c tempSAC : newlist)
        {
            if(oldMap.get(tempSAC.Id) != null)
            {	Service_Appointment__c tempSA= oldMap.get(tempSAC.Id);
             if((GeneralHelpers.returnDayofWeek(Integer.valueof(tempSAC.DayOfWeek__c)) != GeneralHelpers.returnDayofWeek(Integer.valueof(tempSA.DayOfWeek__c))) && 
                (tempSAC.Cleaning_Reason__c == OrgContants.PICKLISTVALUE_SERVICE_APPOINTMENT_CLEANING_REASON[0].getLabel()
                 ||tempSAC.Maintenance_Reason__c == OrgContants.PICKLISTVALUE_SERVICE_APPOINTMENT_MAINTENANCE_REASON[0].getLabel()))
             {
                 if(tempSAC.Type_of_Service__c == OrgContants.PICKLISTVALUE_SERVICE_APPOINTMENT_TYPEOFSERVICE[0].getLabel())
                 { 
                     CleaningHousingIds.add(tempSAC.Housing__c);
                 }
                 else if(tempSAC.Type_of_Service__c == OrgContants.PICKLISTVALUE_SERVICE_APPOINTMENT_TYPEOFSERVICE[1].getLabel())
                 {
                     MaintenanceHousingIds.add(TempSAC.Housing__c);
                 }
                 
             }
            }
            //otherwise if there are people email them
            if(CleaningHousingIds != null && CleaningHousingIds.size() > 0)
            { //check if current house has people AND QUERY FOR HOUSING WITH PEOPLE
                map<id,list<String>> contactEmailsForCleaning = queryForContacts(CleaningHousingIds);
                String subject = '<no-reply> new Cleaning Appointment';
                CreateAndSendEmail(CleaningHousingIds,subject,newlist,contactEmailsForCleaning,0);	
            }
            
            if(MaintenanceHousingIds != null && MaintenanceHousingIds.Size() > 0)
            {//checks for the current contact email in the house and sends an email to them
                map<id,list<String>> contactEmailsForMaintenance = queryForContacts(MaintenanceHousingIds);
                String subject = '<no-reply new Maintenance Appointment>';
                CreateAndSendEmail(MaintenanceHousingIds,subject,newlist,contactEmailsForMaintenance,1);
            }
        }
    }
    /**************************************************************************
* 	Purpose: To return the email of the contacts related to the housing 
* 	Author:	 Steven Zhao	
* 	Created Date:	4/23/19
* 	Last Modifyied Author: Steven Zhao
*  Last Modifyied Date: 4/23/19
* 	Description:	 this returns a map<id,list<string>> to email the user to the related service appointments (cleaning or maintaince)
*************************************************************************/
    public static map<id,list<String>> queryForContacts(list<id> newIDlist)
    {
        Map<id,list<String>> contactEmails = new Map<id,list<String>>();
        for(housing__c tempH : [SELECT Id, (SELECT CONTACT__r.Email FROM HOUSING_ASSIGNMENTS__R) from housing__C where CURRENT_OCCUPANTS__C != 0 AND ID IN :newIDlist])
        {
            for(Id tempID : newIDlist)
            {
                if(tempId == tempH.id)
                {
                    list<String> emailList = new list<String>();
                    for(Housing_Assignment__c tempHA : tempH.Housing_Assignments__r)
                    {
                        emailList.add(tempHA.Contact__r.Email);
                    }
                    if(contactEmails.get(tempId) == null)
                        contactEmails.put(TempH.id,emailList);
                }
            }
        }
        return contactEmails;
    }	
    /**************************************************************************
* 	Purpose:  creates emails and send the email
* 	Author:	 Steven Zhao
* 	Created Date:	4/24/19
* 	Last Modifyied Author: Steven Zhao
*  Last Modifyied Date: 4/24/19
* 	Description:	
*************************************************************************/	
    public static void CreateAndSendEmail(list<id> housingid, string subject ,list<Service_Appointment__c> newlist,map<id,list<string>> contactEmail,integer serviceType)
    {	
        for(Service_Appointment__c tempSAC:newlist)
        {
            for(id tempId:housingid)
            {
                if(tempId == tempSAC.Housing__c)
                {//Service_Interval__c
                    String tBody = textBody(serviceType,integer.valueOf(tempSAC.Service_Interval__c),integer.valueOf(tempSAC.DayOfWeek__c),tempSAC.Date__C,tempSAC.Time__C);
                    list<Messaging.SingleEmailMessage> newEmail = OutBoundEmail.Create_Email(contactEmail.get(tempId),subject,tBody);
                    System.debug(newEmail);
                    Messaging.sendEmail(newEmail);
                }
            }
        }
    }
    /**************************************************************************
* 	Purpose:  The body for the housing text body
* 	Author:	 Steven Zhao
* 	Created Date:	4/24/19
* 	Last Modifyied Author: Steven Zhao
*  Last Modifyied Date: 4/24/19
* 	Description:	
*************************************************************************/	
    public static string textBody( integer Service,integer numberDays, integer dayofWeek, date serviceDate, time serviceTime)
    {
        //if service is 0 it means cleaning otherwise if its 1 it means maintance
        if(Service == 0 )
        {
            if(numberDays ==null || numberDays ==0)
            {
                return 'Cleaning will be on ' +serviceDate +' at '+serviceTime;
            }
            else 
                return 'Cleaning will be on ' +GeneralHelpers.returnDayofWeek(dayofWeek)+' every '+GeneralHelpers.returnWeekANDdays(numberDays)+' Starting: '+serviceDate;
        }
        else if (Service == 1)
        {
            if(numberDays ==null || numberDays ==0)
            {
                return 'Maintaince will be on ' +serviceDate +' at '+serviceTime;
            }
            else 
                return 'Maintaince will be on ' +GeneralHelpers.returnDayofWeek(dayofWeek)+' every '+GeneralHelpers.returnWeekANDdays(numberDays)+'Starting: '+serviceDate;
        }
        else
            return null;
        
        
    }
    
}