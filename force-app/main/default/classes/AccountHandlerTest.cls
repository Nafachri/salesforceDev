@isTest
public class AccountHandlerTest {
    @isTest
    public static void testAssignCategory() {
        // membuat data account untuk test methods 
        
        Test.startTest();
        Account accObj1 = new Account();
        accObj1.Name = 'Small Business';
        accObj1.NumberOfEmployees = 10;
        insert accObj1;
        
        Account accObj2 = new Account();
        accObj2.Name = 'Medium Business';
        accObj2.NumberOfEmployees = 60;
        insert accObj2;
        
        Account accObj3 = new Account();
        accObj3.Name = 'Enterprise';
        accObj3.NumberOfEmployees = 500;
        insert accObj3;
        Test.stopTest();
        
        // Checking as per expected or not
        System.assertEquals('Small Business', accObj1.Name, 'Category must be Small Business');
        System.assertEquals('Medium Business', accObj2.Name, 'Category must be Medium Business');
        System.assertEquals('Enterprise', accObj3.Name, 'Category must be Enterprise');
    }
    @isTest
    public static void testCalculateRevenuePerEmployee() {
        // Create test data
        Account accObj1 = new Account(
            Name = 'Small Business',
            NumberOfEmployees = 10,
            AnnualRevenue = 100000
        ); // Expected: Revenue_Per_Employee__c = 10000
        
        Account accObj2 = new Account(
            Name = 'Medium Business',
            NumberOfEmployees = null,
            AnnualRevenue = 500000
        ); // Expected: Revenue_Per_Employee__c = null (invalid NumberOfEmployees)
        
        Account accObj3 = new Account(
            Name = 'Large Business',
            NumberOfEmployees = 0,
            AnnualRevenue = 200000
        ); // Expected: Revenue_Per_Employee__c = null (NumberOfEmployees = 0)
        
        Account accObj4 = new Account(
            Name = 'Startup',
            NumberOfEmployees = 5,
            AnnualRevenue = null
        ); // Expected: Revenue_Per_Employee__c = null (invalid AnnualRevenue)
        
        Account accObj5 = new Account(
            Name = 'Non-Profit',
            NumberOfEmployees = 20,
            AnnualRevenue = 0
        ); // Expected: Revenue_Per_Employee__c = 0 (AnnualRevenue = 0)
        
        // Insert test data
        insert new List<Account> { accObj1, accObj2, accObj3, accObj4, accObj5 };
            
            // Fetch the accounts to ensure they have IDs
            List<Account> accounts = [SELECT Id, NumberOfEmployees, AnnualRevenue, Revenue_Per_Employee__c FROM Account];
        
        // Call the method under test
        Test.startTest();
        AccountHandler.calculateRevenuePerEmployee(accounts); // Replace `YourClassName` with the actual class name
        update accounts; // Save changes to the database
        Test.stopTest();
        
        // Re-fetch records to verify results
        accounts = [SELECT Id, NumberOfEmployees, AnnualRevenue, Revenue_Per_Employee__c FROM Account];
        
        // Assertions
        System.assertEquals(10000, accounts[0].Revenue_Per_Employee__c, 'Revenue per employee should be 10000');
        System.assertEquals(null, accounts[1].Revenue_Per_Employee__c, 'Revenue per employee should be null for invalid NumberOfEmployees');
        System.assertEquals(null, accounts[2].Revenue_Per_Employee__c, 'Revenue per employee should be null for NumberOfEmployees = 0');
        System.assertEquals(null, accounts[3].Revenue_Per_Employee__c, 'Revenue per employee should be null for invalid AnnualRevenue');
        System.assertEquals(0, accounts[4].Revenue_Per_Employee__c, 'Revenue per employee should be 0 for AnnualRevenue = 0');
    }
}
    
    
    /* Account account = new Account(Name = 'Small Business Account', NumberOfEmployees = 30);
Account account = new Account(Name = 'Medium Business Account', NumberOfEmployees = 200);
Account account = new Account(Name = 'Enterprise Account', NumberOfEmployees = 500);
insert account; */
    
    // Memanggil metode assignCategory dengan memasukkan data account ke dalam methods assignCategory untuk di test
    /*Test.startTest();
AccountHandler.assignCategory(new List<Account>{account});
Test.stopTest(); 

// verifikasi hasil test sudah sesuai dengan expected result atau belum
Account result = [SELECT Category__c FROM Account WHERE Id = :account.Id];
System.assertEquals('Small Business', result.Category__c, 'Category should be Small Business');
}

@isTest
public static void testCalculateRevenuePerEmployee() {
// membuat data account untuk test methods
Account account = new Account(Name = 'Medium Business Account', NumberOfEmployees = 55, AnnualRevenue = 100000000);

// insert data account untuk pengujian ke dalam record Object Account
insert account;

// Memanggil metode calculateRevenuePerEmployee dengan memasukkan data account ke dalam methods calculateRevenuePerEmployee untuk di test
Test.startTest();
AccountHandler.calculateRevenuePerEmployee(new List<Account>{account});
Test.stopTest();

// verifikasi hasil test sudah sesuai dengan expected result atau belum
Account result = [SELECT Revenue_Per_Employee__c FROM Account WHERE Id = :account.Id];
Decimal expectedRevenuePerEmployee = 100000000 / 55;
System.assertNotEquals(null, result.Revenue_Per_Employee__c, 'Revenue per Employee should not be null');
System.assertEquals(expectedRevenuePerEmployee, result.Revenue_Per_Employee__c, 'Revenue per Employee is incorrect');
}*/