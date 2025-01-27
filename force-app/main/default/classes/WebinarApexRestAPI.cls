/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 26-01-2025
 * @last modified by  : npz
**/
@RestResource(urlMapping='/Webinars/*')

global with sharing class WebinarApexRestAPI {
    @HttpGet
    global static Webinar_Ticket__c getWebinarById() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String webinarId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        Webinar_Ticket__c webinarTicket = [Select Id, Webinar_Name__c, Phone__c, Full_Name__c, Email__c FROM Webinar_Ticket__c WHERE Id = :webinarId];
        return webinarTicket;
    }

    @HttpPost
    global static String createWebinarTicket(String fullName, String email, String phone, String webinarId){
        Webinar_Ticket__c webinar = new Webinar_Ticket__c (
            Full_Name__c = fullName,
            Email__c = email,
            Phone__c = phone,
            Webinar_Name__c = webinarId
        );
        insert webinar;
        return 'Webinar Ticket Created with ID: ' + webinar.Id;
    }
}