/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 24-01-2025
 * @last modified by  : npz
**/
public with sharing class LeadHandler {
    public static void changeLeadStatusByLeadSource(List<Lead> leads) {
        for (Lead leadsObj: leads) {
            if(leadsObj.LeadSource == 'Web'){
                leadsObj.Status = 'Working - Contacted';
            }else if(leadsObj.LeadSource == 'Phone Inquiry'){
                leadsObj.Status = 'Closed - Not Converted';
            }
        }
    }
}