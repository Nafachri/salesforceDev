/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 27-01-2025
 * @last modified by  : npz
**/
public with sharing class WebinarRESTCallout {
@future(callout=true)
@AuraEnabled(cacheable=true)

public static void getWebinarCallout() {
try {
    String endpoint = 'https://run.mocky.io/v3/92a41bb8-f3c7-483c-b67a-6ecde6b2e3c8';

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('GET');

    HttpResponse response = http.send(request);

    if(response.getStatusCode() == 200){
        List<WebinarDTO> webinarList = (List<WebinarDTO>) JSON.deserialize(response.getBody(), List<WebinarDTO>.class);

        List<Webinar__c> webinarRecords = new List<Webinar__c>();

        for (WebinarDTO webinar : webinarList) {
            Webinar__c newWebinar = new Webinar__c();
            newWebinar.Name = webinar.name;
            newWebinar.Webinar_Date__c = Date.valueOf(webinar.webinarDate);
            newWebinar.Max_Capacity__c = webinar.maxCapacity;

            webinarRecords.add(newWebinar);
        }

        System.debug(webinarRecords);

        if (!webinarRecords.isEmpty()) {
            insert webinarRecords;
        }
    }

} catch (Exception e) {
    System.debug('Exception during API callout :' + e.getMessage());
}
// DTO class to map the JSON response        
}
public class WebinarDTO {
    public String name;
    public String webinarDate;
            public Integer maxCapacity;
}
}