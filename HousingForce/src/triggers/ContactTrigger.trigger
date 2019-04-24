trigger ContactTrigger on Contact ( before update) 
{

    if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
        {
         //ContactTriggerHelperMethods.CheckIfEmployeeHasNewHousingApproved(trigger.new, trigger.oldMap);
         //EmailRoommates.checkIfothersExistInHousingUnit(trigger.new,trigger.oldMap);
        }
    }

}