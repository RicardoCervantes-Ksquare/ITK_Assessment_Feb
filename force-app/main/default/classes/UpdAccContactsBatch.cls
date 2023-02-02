public with sharing class UpdAccContactsBatch implements Database.Batchable<SObject>{

    Set<Id> accIds = new Set<Id>();

    public UpdAccContactsBatch(Set<Id> accIdsParams) {
        accIds = accIdsParams;
    }

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Push_Date__c, Account.PushToVendor__c FROM Contact WHERE Account.Id IN :accIds');
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope){
        List<Contact> conList = new List<Contact>();

        for(Contact cont: scope){
            if(cont.Account.PushToVendor__c == 'Yes'){
                cont.Push_Date__c = System.now();
            }
            if(cont.Account.PushToVendor__c == 'No'){
                cont.Push_Date__c = null;
            }

            conList.add(cont);
        }

        Database.update(conList,false);
    }

    public void finish(Database.BatchableContext bc){}
    
}