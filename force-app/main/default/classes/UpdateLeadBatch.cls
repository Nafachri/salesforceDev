/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 31-01-2025
 * @last modified by  : npz
**/
global class UpdateLeadBatch implements Database.Batchable<SObject> {

    // start
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Status FROM Lead WHERE Status = \'Open - Not Contacted\''
        );
    }

    // execute
    global void execute(Database.BatchableContext bc, List<Lead> scope) {
        for (Lead lead : scope) {
            lead.Status = 'Working - Contacted';
        }
        update scope;
    }

    // finish
    global void finish(Database.BatchableContext bc) {  // Fix: Corrected 'Database' spelling
        System.debug('Batch job finished successfully');
    }
}


// cara menjalankan batch apexnya
// UpdateLeadBatch batch = new UpdateLeadBatch();
// Database.executeBatch(batch, 50); // 50 adalah jumlah record yang di proses per batch