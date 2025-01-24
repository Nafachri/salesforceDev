trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
        	AccountHandler.assignCategory(Trigger.new);
            AccountHandler.calculateRevenuePerEmployee(Trigger.new);
        }
    }
} 

/*
// Trigger ini akan jalan pada saat user ingin menambahkan record baru dan user ingin mengubah data record
 trigger AccountTrigger on Account (before insert, before update) {
    // Trigger ini akan jalan sebelum data hasil insert/update masuk ke database/record Account
    if(Trigger.isBefore) { 
        List<Account> newDataAccounts = new List<Account>();
        // Trigger ini akan jalan untuk data yang di update dari record lama, dan memastikan jalan hanya ketika field NumberOfEmployees dan Annual Revenue berubah
        if(Trigger.isUpdate){ 
            // Trigger.new = data baru hasil update-an
            for(Account acc : Trigger.new) { 
                // Trigger.oldMap = data lama sebelum user merubah record dan biasanya edit itu harus ada parameter berdasarkan apa ngeditnya sesuatu yang unique seperti Id
                Account oldAcc = Trigger.oldMap.get(acc.Id); 
                // Ini untuk memastikan bahwa apabila field NumberOfEmployees dan Annual Revenue berubah maka diganti dengan data hasil perubahannya
                if(acc.NumberOfEmployees != oldAcc.NumberOfEmployees || acc.AnnualRevenue != oldAcc.AnnualRevenue){ 
                    newDataAccounts.add(acc);
                }
            }
          // Trigger ini akan jalan saat user mencoba menambahkan record/data baru ke Object Account
        } else if (Trigger.isInsert){ 
            // Trigger.new = data baru pada saat membuat record/data Account baru
            newDataAccounts = Trigger.new; 
        }
        // ini maksudnya sebagai validasi apakah newDataAccounts itu ada isinya/tidak
        if(!newDataAccounts.isEmpty()){
            AccountHandler.assignCategory(newDataAccounts);
            AccountHandler.calculateRevenuePerEmployee(newDataAccounts);
        }
    }
}
    */