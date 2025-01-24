@RestResource(urlMapping='/AccountAPI/*')
global with sharing class AccountRestAPI {
    // GET METHOD: Retrieve Account by ID 
    @HttpGet
    global static Account getAccountById(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        // Get ID from URL
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        Account acc = [SELECT Id, Name, Industry, AnnualRevenue FROM Account WHERE Id = :accountId LIMIT 1];
        return acc;
    }
    
    // POST METHOD: Create a new Account
    @HttpPost
    global static String createAccount(String name, String industry, Decimal annualRevenue) {
        Account acc = new Account (
        Name = name,
        Industry = industry,
        AnnualRevenue = annualRevenue
       );
       insert acc;
       return 'Account Created with ID: ' + acc.Id;
    }
    
    // DELETE METHOD : Delete Account by ID
    global static String deleteAccount() {
        RestREquest req = RestContext.request;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        
        Account acc = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
        delete acc;
        return 'Account Deleted with ID: ' + accountId;
    }
}