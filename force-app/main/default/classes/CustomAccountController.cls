public with sharing class CustomAccountController {
    public List<Account> accounts {get; set;}
    
    public CustomAccountController() {
        accounts = [SELECT Name, Industry FROM Account];
    }
    
    public void onRowClick() {
        System.debug('This button is clicked');
    }
}