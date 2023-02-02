@isTest
public with sharing class UpdAccContactsAsyncTest {
    
    @TestSetup
    static void setup(){
        List<Account> testAccList = new List<Account>();

        for(Integer i = 0; i < 250; i++){
            Account acc = new Account(Name = 'Test Account' + i);
            testAccList.add(acc);
        }

        insert testAccList;

        List<Contact> testConList = new List<Contact>();
        for(Account acc : testAccList){
            for(Integer j=0; j<3; j++){
                testConList.add(new Contact(LastName = acc.Name + 'Contact' + j, AccountId = acc.Id));
            }
        }

        insert testConList;
    }
    @isTest
    public static void UpdAccContactsAsyncTestMethod() {

        Set<Id> accIds = new Set<Id>();
        List<Account> accList = [SELECT Id, PushToVendor__c FROM Account WHERE Name LIKE '%Test%'];

        for(Account acc : accList){
            acc.PushToVendor__c = 'Yes';
        }

        Database.update(accList,false);
        accIds = (new Map<Id, Account>(accList)).keySet();

        Test.startTest();
        Database.update(accList,false);
        Test.stopTest();

        System.assertEquals(750,[SELECT COUNT() FROM Contact WHERE AccountId IN :accIds AND Push_Date__c != NULL]);

    }
}