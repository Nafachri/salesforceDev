/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 24-01-2025
 * @last modified by  : npz
**/
trigger LeadTrigger on Lead (before insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            LeadHandler.changeLeadStatusByLeadSource(Trigger.new);
        }
    }
}