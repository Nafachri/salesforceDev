/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 29-01-2025
 * @last modified by  : npz
**/
@isTest
private class WebinarTicketHandlerTest {
    @testSetup
    static void setupTestData() {
        Webinar__c webinar = new Webinar__c(Name = 'Salesforce Webinar', Max_Capacity__c = 2);
        insert webinar;
        
        Webinar_Ticket__c ticket1 = new Webinar_Ticket__c(Webinar_Name__c = webinar.Id, Ticket_Status__c = 'Pending');
        Webinar_Ticket__c ticket2 = new Webinar_Ticket__c(Webinar_Name__c = webinar.Id, Ticket_Status__c = 'Pending');
        insert new List<Webinar_Ticket__c>{ticket1, ticket2};
    }
    
    @isTest
    static void testCheckMaxCapacityInsert() {
        Test.startTest();
        Webinar__c webinar = [SELECT Id FROM Webinar__c LIMIT 1];
        
        Webinar_Ticket__c ticket = new Webinar_Ticket__c(Webinar_Name__c = webinar.Id, Ticket_Status__c = 'Pending');
        
        try {
            insert ticket;
            System.assert(false, 'Expected DMLException was not thrown');
        } catch (DMLException e) {
            System.assert(e.getMessage().contains('Webinar is full'), 'Unexpected error message: ' + e.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void testCheckMaxCapacityUpdate() {
        Test.startTest();
        Webinar_Ticket__c ticket = [SELECT Id, Ticket_Status__c FROM Webinar_Ticket__c LIMIT 1];
        ticket.Ticket_Status__c = 'Confirmed';
        
        try {
            update ticket;
            System.assert(false, 'Expected DMLException was not thrown');
        } catch (DMLException e) {
            System.assert(e.getMessage().contains('Cannot confirm ticket, webinar is full'), 'Unexpected error message: ' + e.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void testInsertTicketBelowCapacity() {
        Webinar__c newWebinar = new Webinar__c(Name = 'New Webinar', Max_Capacity__c = 5);
        insert newWebinar;
        
        Test.startTest();
        Webinar_Ticket__c ticket = new Webinar_Ticket__c(Webinar_Name__c = newWebinar.Id, Ticket_Status__c = 'Pending');
        insert ticket;
        Test.stopTest();
        
        System.assertEquals(1, [SELECT COUNT() FROM Webinar_Ticket__c WHERE Webinar_Name__c = :newWebinar.Id]);
    }
}
