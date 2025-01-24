public with sharing class CustomContactController {
	@AuraEnabled(cacheable = true)
    public static List<Contact> getContacts() {
        return [SELECT Name, Email FROM Contact];
    }
}