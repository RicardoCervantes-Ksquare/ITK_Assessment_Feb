public with sharing class AccountTriggerHandler {
    public static void UpdateAccountContacts(List<Account> accList) {
        Integer totalContacts = 0;
        List<Contact> contactList = new List<Contact>();

        Set<Id> accountIds = new Set<Id>();

        for(account a : accList){
            accountIds.add(a.Id);
        }

        for(AggregateResult AggRe: [SELECT AccountId AccId, COUNT(Id) ContactsPerAccount FROM Contact WHERE Account.Id IN :accountIds GROUP BY AccountId]){
            totalContacts += (Integer)AggRe.get('ContactsPerAccount');
        }

        if(totalContacts <= 200){
            UpdAccContactsSync.UpdAccContactsSyncMethod(accountIds);
        }
        else if(totalContacts > 200 && totalContacts <= 1000){
            UpdAccContactsAsync async = new UpdAccContactsAsync(accountIds);
            Id contactQueue = System.enqueueJob(async);

        } else if(totalContacts > 1000){
            UpdAccContactsBatch batch = new UpdAccContactsBatch(accountIds);
        }
    }
}