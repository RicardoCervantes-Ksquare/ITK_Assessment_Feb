public with sharing class UpdAccContactsSync {
    public static void UpdAccContactsSyncMethod(Set<Id> accIds) {
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