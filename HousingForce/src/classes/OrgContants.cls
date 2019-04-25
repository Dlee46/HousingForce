/**************************************************************************
 * 	Purpose: Contant Values that the org uses
 * 	Author:	 Steven Zhao
 * 	Created Date:	
 * 	Last Modifyied Author:
 *  Last Modifyied Date:
 * 	Description:	Mostly just picklistvalues
 *************************************************************************/ 
public class OrgContants
{
    public static Final list<schema.PicklistEntry>  PICKLISTVALUE_EmloyeeStatus = Contact.Employee_Status__c.getDescribe().getpicklistValues();
    public static Final list<schema.PicklistEntry>  PICKLISTVALUE_GENDER = Contact.Gender__c.getDescribe().getpicklistValues();
    public static Final list<schema.PicklistEntry>  PICKLISTVALUE_HOUSING_GENDER = Housing__C.Group_Designation__c.getDescribe().getpicklistValues();
    public static Final list<schema.PicklistEntry>  PICKLISTVALUE_HOUSING_ASSIGNMENT = Contact.Housing_Status__c.getDescribe().getpicklistValues();
    public static Final list<schema.PicklistEntry>  PICKLISTVALUE_TASK_SUBJECT = Task.Subject.getDescribe().getpicklistValues();
    public static Final list<schema.PicklistEntry>  PICKLISTVALUE_TASK_STATUS = Task.STATUS.getDescribe().getpicklistValues();
	public static Final list<schema.PicklistEntry>  PICKLISTVALUE_TASK_PRIORITY = Task.PRIORITY.getDescribe().getpicklistValues();
    public static Final list<schema.PicklistEntry>  PICKLISTVALUE_SERVICE_APPOINTMENT_TYPEOFSERVICE = Service_Appointment__c.Type_of_Service__c.getDescribe().getpicklistValues();
    public static Final list<schema.PicklistEntry>	PICKLISTVALUE_SERVICE_APPOINTMENT_CLEANING_REASON = Service_Appointment__c.Cleaning_Reason__c.getDescribe().getpicklistValues();
    public static Final list<schema.PicklistEntry>	PICKLISTVALUE_SERVICE_APPOINTMENT_MAINTENANCE_REASON = Service_Appointment__c.Maintenance_Reason__c.getDescribe().getpicklistValues();

}