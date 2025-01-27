public with sharing class CustomWebinarTicketController {
 public List<Webinar_Ticket__c> webinarTickets {get; set;}
    
    public CustomWebinarTicketController() {
        webinarTickets = [SELECT Name, Phone__c, Email__c, Ticket_Status__c FROM Webinar_Ticket__c];
    }
}