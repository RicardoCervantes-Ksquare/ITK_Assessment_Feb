public with sharing class contactListViewHelper {
    
    @AuraEnabled(cacheable=True)
    public static List<Contact> getContacts(){
        return [SELECT Id, firstName, lastName, accountId,
                account.name, mailingStreet, mailingCity, mailingState, mailingPostalCode, mailingCountry, email
                FROM Contact
                LIMIT 1000];
    }

    @AuraEnabled(cacheable=True)
    public static List<Contact> searchContact(String searchString){
       List<List<SObject>> contacts = [FIND :searchString IN ALL FIELDS RETURNING Contact(FirstName, LastName, Email, mailingStreet, 
       mailingCity, mailingCountry, mailingPostalCode, account.Name)];

       return (List<Contact>) contacts[0];
    }
}