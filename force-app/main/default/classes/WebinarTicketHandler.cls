/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 29-01-2025
 * @last modified by  : npz
**/
public with sharing class WebinarTicketHandler {
    public static void checkMaxCapacityInsert(List<Webinar_Ticket__c> newTickets) {
        Set<Id> webinarIds = new Set<Id>();
        
        for (Webinar_Ticket__c webinar : newTickets) {
            if (webinar.Webinar_Name__c != null) {
                webinarIds.add(webinar.Webinar_Name__c);
            }
        }

        if(webinarIds.isEmpty()) return;
        
        Map<Id, Webinar__c> webinarMap = new Map<Id, Webinar__c>([
            SELECT Id, Max_Capacity__c, (SELECT Id FROM Webinar_Tickets__r) 
            FROM Webinar__c 
            WHERE Id IN :webinarIds
        ]);

        for(Webinar_Ticket__c ticket: newTickets){
            Webinar__c webinar = webinarMap.get(ticket.Webinar_Name__c);

            if(webinar.Webinar_Tickets__r.size() >= webinar.Max_Capacity__c){
                ticket.addError('Webinar is full');
            }
        }
    }

    public static void checkMaxCapacityUpdate(List<Webinar_Ticket__c> updatedTickets, Map<Id, Webinar_Ticket__c> oldTickets) {
        Set<Id> webinarIds = new Set<Id>();
        for (Webinar_Ticket__c ticket : updatedTickets) {
            Webinar_Ticket__c oldTicket = oldTickets.get(ticket.Id);
            if (oldTicket != null && oldTicket.Ticket_Status__c != 'Confirmed' && ticket.Ticket_Status__c == 'Confirmed') {
                webinarIds.add(ticket.Webinar_Name__c);
            }
        }
        
        if (webinarIds.isEmpty()) return;
        
        Map<Id, Webinar__c> webinarMap = new Map<Id, Webinar__c>([ 
            SELECT Id, Max_Capacity__c, (SELECT Id FROM Webinar_Tickets__r) 
            FROM Webinar__c WHERE Id IN :webinarIds
        ]);
        
        for (Webinar_Ticket__c ticket : updatedTickets) {
            Webinar_Ticket__c oldTicket = oldTickets.get(ticket.Id);
            Webinar__c webinar = webinarMap.get(ticket.Webinar_Name__c);
            if (oldTicket != null && oldTicket.Ticket_Status__c != 'Confirmed' && ticket.Ticket_Status__c == 'Confirmed' &&
                webinar != null && webinar.Webinar_Tickets__r.size() >= webinar.Max_Capacity__c) {
                ticket.addError('Cannot confirm ticket, webinar is full');
            }
        }
    }
}