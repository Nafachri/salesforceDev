public class AccountHandler {
    // Mengambil List/Array record object Account
    public static void assignCategory(List<Account> accounts) { 
        // Mengeluarkan record Account untuk di olah dan manipulasi
        for (Account acc : accounts) {
            if (acc.NumberOfEmployees < 50) {
                acc.Category__c = 'Small Business';
            } else if (acc.NumberOfEmployees >= 50 && acc.NumberOfEmployees <= 200) {
                acc.Category__c = 'Medium Business';
            } else if (acc.NumberOfEmployees > 200) {
                acc.Category__c = 'Enterprise';
            }
        }
    }
    
    // Mengambil List/Array record object Account
    public static void calculateRevenuePerEmployee(List<Account> accounts) {
        // Mengeluarkan record Account untuk di olah dan manipulasi
        for (Account acc : accounts) {
            if (acc.NumberOfEmployees != null && acc.NumberOfEmployees != 0 && acc.AnnualRevenue != null) {
                acc.Revenue_Per_Employee__c = acc.AnnualRevenue / acc.NumberOfEmployees;
            } else {
                acc.Revenue_Per_Employee__c = null; // Jika data tidak valid, set ke null
            }
        }
    }
}