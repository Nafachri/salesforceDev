/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 31-01-2025
 * @last modified by  : npz
**/
global class UpdateAccountBatch implements Database.Batchable<SObject> {
    // , Database.AllowsCallouts untuk bisa memungkinkan melakukan callout
    // , Database.Stateful untuk bisa menyimpan state
    // , Database.RaisesPlatformEvents untuk bisa mengirim platform event
    // , Database.Schedulable untuk bisa menjalankan batch apex secara schedule

    // Constructor with parameter

    // public List<Account> accountList;
    // public Integer numberData;

    // public UpdateAccountBatch(List<Account> accountList) {
    //     this.accountList = accountList;
    //     this.numberData = 0;
    // }

    // public Iterable<Account> start(Database.BatchableContext bc) {
    //     accountList = new List<Account>();
    //     numberData = 0;
    //     return accountList;
    // }

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
// UpdateLeadBatch batch = new UpdateLeadBatch(accountList);
// Database.executeBatch(batch, 50); // 50 adalah jumlah record yang di proses per batch