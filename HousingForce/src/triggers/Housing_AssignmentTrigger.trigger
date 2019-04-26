trigger Housing_AssignmentTrigger on Housing_Assignment__c (before insert) 
{

    if(Trigger.isInsert)
    {
        if(Trigger.isBefore)
        {
       //     Housing_AssignmentTriggerHelper.CheckHousingForContact(Trigger.new);
        }
    }
    
    if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
        {
      //      Housing_AssignmentTriggerHelper.CheckHousingForContact(Trigger.new);
        }
    }
}