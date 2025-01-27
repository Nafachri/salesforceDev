/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 27-01-2025
 * @last modified by  : npz
**/
trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
        	AccountHandler.assignCategory(Trigger.new);
            AccountHandler.calculateRevenuePerEmployee(Trigger.new);
        }
    }
} 