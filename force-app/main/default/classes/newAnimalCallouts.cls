public with sharing class newAnimalCallouts {
public static HttpResponse getCallout() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
    request.setMethod('GET');
    HttpResponse response = http.send(request);

    // parse JSON from response to primitice data types yaitu Map (key, values)
    if(response.getStatusCode() == 200) {
        System.debug(response.getBody());
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        System.debug(result);
        // masukan data key value tersebut kedalam List dengan mendapatkan 'key' nya
        List<Object> animals = (List<Object>) result.get('animals');
        System.debug(animals);
        System.debug('received the following animals');
        for(Object animal : animals) {
            System.debug(animal);
        }
    }
    return response;
}
public static HttpResponse postCallout(String animalName) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
    request.setMethod('POST');
    request.setHeader('Content-Type', 'application/json;charset=UTF-8');

    // Dynamic Input
    System.debug(animalName);
    Map<String, String> bodyParams = new Map<String, String>();
    bodyParams.put('name', animalName);
    System.debug(bodyParams);

    // ubah object ke JSON String
    String requestBody = JSON.serialize(bodyParams);
    System.debug(requestBody);

    // inputan animalName dimasukan ke dalam body untuk request  ke API
    request.setBody(requestBody);

    HttpResponse response = http.send(request);

        // Parse JSON response and check if the status code is 201 (created)
    if(response.getStatusCode() != 201) {
        System.debug('The status code returned was not expected: ' +
            response.getStatusCode() + ' ' + response.getStatus());
    } else {
        System.debug(response.getBody());
    }
    return response;

    // Fix Input
    
    // request.setBody('{"name":"kucing"}');
    // HttpResponse response = http.send(request);
    //     // Parse JSON response dan check apakah status nya 201 (data created)
    //     if(response.getStatusCode() != 201) {
    //     System.debug('The status code returned was not expected: ' +
    //         response.getStatusCode() + ' ' + response.getStatus());
    // } else {
    //     System.debug(response.getBody());
    // }
    // return response;
}

}