/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 28-01-2025
 * @last modified by  : npz
**/
@isTest
public class WebinarApexRestAPITest {
    
    @isTest
    static void testGetWebinarById() {

        Webinar__c testWebinar = new Webinar__c(Name = 'Test Webinar');
        insert testWebinar;

        Webinar_Ticket__c testWebinarTicket = new Webinar_Ticket__c(
            Full_Name__c = 'John Doe',
            Email__c = 'johndoe@example.com',
            Phone__c = '1234567890',
            Webinar_Name__c = testWebinar.Id
        );
        insert testWebinarTicket;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/Webinars/' + testWebinarTicket.Id;
        req.httpMethod = 'GET';

        RestContext.request = req;
        RestContext.response = res;

        Webinar_Ticket__c result = WebinarApexRestAPI.getWebinarById();

        System.assertNotEquals(null, result);
        System.assertEquals(testWebinarTicket.Id, result.Id);
        System.assertEquals('John Doe', result.Full_Name__c);
        System.assertEquals('johndoe@example.com', result.Email__c);
        System.assertEquals('1234567890', result.Phone__c);
        System.assertEquals(testWebinar.Id, result.Webinar_Name__c);
    }

    @isTest
    static void testCreateWebinarTicket() {

        Webinar__c testWebinar = new Webinar__c(Name = 'Test Webinar');
        insert testWebinar;

        String requestBody = '{"fullName": "Jane Doe", "email": "janedoe@example.com", "phone": "0987654321", "webinarId": "' + testWebinar.Id + '"}';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.httpMethod = 'POST';
        req.requestURI = '/services/apexrest/Webinars/';
        req.requestBody = Blob.valueOf(requestBody);

        RestContext.request = req;
        RestContext.response = res;

        String result = WebinarApexRestAPI.createWebinarTicket(
            'Jane Doe',
            'janedoe@example.com',
            '0987654321',
            testWebinar.Id
        );

        System.assert(result.startsWith('Webinar Ticket Created with ID: '));
        
        Webinar_Ticket__c insertedTicket = [SELECT Id, Full_Name__c, Email__c, Phone__c, Webinar_Name__c FROM Webinar_Ticket__c WHERE Webinar_Name__c = :testWebinar.Id LIMIT 1];
        System.assertEquals('Jane Doe', insertedTicket.Full_Name__c);
        System.assertEquals('janedoe@example.com', insertedTicket.Email__c);
        System.assertEquals('0987654321', insertedTicket.Phone__c);
        System.assertEquals(testWebinar.Id, insertedTicket.Webinar_Name__c); 
    }
}