public with sharing class WebinarTicketController {
    @AuraEnabled
    public static List<Webinar_Ticket__c> getTickets(String status) {
        String query = 'SELECT Name, Email__c, Phone__c, Ticket_Status__c FROM Webinar_Ticket__c';

        // Filter by status if provided
        if (status != null && status != '') {
            query += ' WHERE Ticket_Status__c = :status';
        }

        return Database.query(query);
    }
}