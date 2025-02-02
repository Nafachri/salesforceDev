/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 02-02-2025
 * @last modified by  : npz
**/
global class SubscriptionScheduler implements Schedulable{
    // change Subscription Status from 'Close' to 'Open' after 09.00 o'clock
    // change Subscription Status from 'Open' to 'Close' after 17.00 o'clock
    global void execute(SchedulableContext sc) {
        List<Subscription__c> subscriptions = [SELECT Id, Time_Status__c FROM Subscription__c];
        for(Subscription__c sub : subscriptions) {
            if(sub.Time_Status__c == null){
                if(System.now().time() == Time.newInstance(9, 0, 0, 0)){
                    sub.Time_Status__c = 'Open';
                }else if(System.now().time() == Time.newInstance(17, 0, 0, 0)){
                    sub.Time_Status__c = 'Closed';
                }
            } else if (sub.Time_Status__c == 'Closed'){
                sub.Time_Status__c = 'Open';
            } else {
                sub.Time_Status__c = 'Closed';
            }
        }
        if(!subscriptions.isEmpty()){
            update subscriptions;
        }
    }
}