trigger ServiceAppointmentTrigger on Service_Appointment__c (after insert, before Update) 
{
	if(trigger.isInsert)
    {
        if(trigger.isAfter)
        {
            ServiceAppointmentTriggerHelper.checkServiceForTriggerInsert(trigger.new);
        }
    }
    
    if(trigger.isUpdate)
    {
        if(trigger.isBefore)
        {
            ServiceAppointmentTriggerHelper.checkServiceForTriggerUpdate(trigger.new, trigger.oldMap);
        }
    }
   
}