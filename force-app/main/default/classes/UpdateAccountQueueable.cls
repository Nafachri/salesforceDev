/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 31-01-2025
 * @last modified by  : npz
**/
public class UpdateAccountQueueable implements Queueable{
    
    private List<Id> accountIds;

    public UpdateAccountQueueable(List<Id> accountIds){
        this.accountIds = accountIds;
    }

    public void execute(QueueableContext context) {
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id IN :accountIds];
        for(Account account : accounts){
            account.Name = account.Name + ' - Updated';
        }
        System.debug(accounts);
        update accounts;
    }
}

// cara memanggilnya dan mengambil Id dari Account

// List<Account> accounts = [SELECT Id, Name FROM Account];
// List<Id> newAccounts = new List<Id>();

// for(Account acc : accounts){
//     newAccounts.add(acc.Id);
// }

// System.enqueueJob(new UpdateAccountQueueable(newAccounts));