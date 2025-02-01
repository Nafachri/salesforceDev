/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 01-02-2025
 * @last modified by  : npz
**/
global class SubscriptionScheduler implements Schedulable{
    // change Subscription Status from 'Close' to 'Open' after 09.00 o'clock
    // change Subscription Status from 'Open' to 'Close' after 17.00 o'clock
    global void execute(SchedulableContext sc) {
        List<Subscription__c> subscription = new List<Subscription__c>();
        
    }
}