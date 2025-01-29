/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 29-01-2025
 * @last modified by  : npz
**/
trigger WebinarTicketTrigger on Webinar_Ticket__c (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            WebinarTicketHandler.checkMaxCapacityInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            WebinarTicketHandler.checkMaxCapacityUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}