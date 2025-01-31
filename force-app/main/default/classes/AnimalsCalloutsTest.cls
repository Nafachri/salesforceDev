/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 31-01-2025
 * @last modified by  : npz
**/
@isTest
private class AnimalsCalloutsTest {
    @isTest static void testGetCallout() {
        // Create the mock response based on the static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        HttpResponse result = AnimalsCallouts.makeGetCallout();
        // Verify mock response is not null 
        Assert.areNotEqual(null, result, 'The callout returned a null response.');
        // Verify status code
        Assert.AreEqual(200, result.getStatusCode(), 'The status code is not 200.');
        // Verify content type
        Assert.AreEqual('application/json;charset=UTF-8',
            result.getHeader('Content-Type'),
            'The content type value is not expected.');
        // Verify the array contains 3 items
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        Assert.areEqual(3, animals.size(), 'The array should only contain 3 items.');
    }
    @isTest
    static void testPostCallout() {
       	// Set mock callout class
       	Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
        // This cause a fake response to be sent
        // from the class that implements HttpCalloutMock
        HttpResponse response = AnimalsCallouts.makePostCallout();
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        Assert.isTrue(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        Assert.areEqual(expectedValue, actualValue);
        Assert.areEqual(200, response.getStatusCode());
    }
}