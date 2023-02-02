trigger AccountTrigger on Account (after update) {
    if(Trigger.isUpdate){AccountTriggerHandler.UpdateAccountContacts(Trigger.new);}
}