/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 28-01-2025
 * @last modified by  : npz
**/
public with sharing class WebinarTicketController {
    @AuraEnabled
    public static List<Webinar_Ticket__c> getTickets(String status) {
        String query = 'SELECT Name, Email__c, Phone__c, Ticket_Status__c FROM Webinar_Ticket__c';

        if (status != null && status != '') {
            query += ' WHERE Ticket_Status__c = :status';
        }

        return Database.query(query);
    }
}