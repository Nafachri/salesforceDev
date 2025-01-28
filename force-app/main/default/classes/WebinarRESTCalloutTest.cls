/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 28-01-2025
 * @last modified by  : npz
**/
@isTest
public class WebinarRESTCalloutTest {

    private class MockWebinarHttpCallout implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"name":"Test Webinar","webinarDate":"2025-02-15","maxCapacity":100}]');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testGetWebinarCallout() {
        Test.setMock(HttpCalloutMock.class, new MockWebinarHttpCallout());

        Test.startTest();

        WebinarRESTCallout.getWebinarCallout();

        Test.stopTest();

        List<Webinar__c> insertedWebinars = [SELECT Name, Webinar_Date__c, Max_Capacity__c FROM Webinar__c];
        System.assertEquals(1, insertedWebinars.size());
        System.assertEquals('Test Webinar', insertedWebinars[0].Name);
        System.assertEquals(Date.newInstance(2025, 2, 15), insertedWebinars[0].Webinar_Date__c);
        System.assertEquals(100, insertedWebinars[0].Max_Capacity__c);
    }
}
