/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 31-01-2025
 * @last modified by  : npz
**/
global class UpdateAccountBatch implements Database.Batchable<SObject> {

    // start

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Name, Active__c FROM Account WHERE Name LIKE \'Account%\''
        );
    }

    // execute

    global void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            acc.Active__c = 'false';
        }
        update scope;
    }

    // finish
    
    global void finish(Database.BatchableContext bc) { 
        System.debug('Batch job finished successfully');
    }
}

// cara menjalankan batch apexnya
// UpdateLeadBatch batch = new UpdateLeadBatch();
// Database.executeBatch(batch, 50); // 50 adalah jumlah record yang di proses per batch