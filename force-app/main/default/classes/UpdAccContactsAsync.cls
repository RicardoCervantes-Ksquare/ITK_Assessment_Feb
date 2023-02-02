public with sharing class UpdAccContactsAsync implements Queueable{
    
    Set<Id> accIds = new Set<Id>();
    
    public UpdAccContactsAsync(Set<Id> accIdsParams) {
        accIds = accIdsParams;
    }

    public void execute(QueueableContext context){
        List<Contact> contactList = new List<Contact>();

        for(Contact cont : [SELECT Id, Push_Date__c, Account.PushToVendor__c FROM Contact WHERE Account.Id IN :accIds]){
            if(cont.Account.PushToVendor__c == 'Yes'){
                cont.Push_Date__c = System.now();
            }
            if(cont.Account.PushToVendor__c == 'No'){
                cont.Push_Date__c = null;
            }

            contactList.add(cont);
        }

        Database.update(contactList,false);
        return;
    }
}