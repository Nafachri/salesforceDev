// rest resource mendefinisikan endpoint REST
// urlMapping menentukan URL endpoint yang akan digunakan
@RestResource(urlMapping='/Cases/*') 
global with sharing class CaseManager {
    @HttpGet
    global static case getCaseById() {
        RestRequest request = RestContext.request;

        // ambil caseId dari akhir URL
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/') + 1
        );
        Case result = [SELECT CaseNumber, Subject, Status, Origin, Priority FROM Case WHERE Id = :caseId];
        return result;
    }

    @HttpPost
    global static ID createCase(String subject, String status, String origin, String priority) {
        Case thisCase = new Case(Subject=subject, Status=status, Origin=origin, Priority=priority);
        insert thisCase;
        return thisCase.Id;
    }

    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/') + 1
        );
        Case thisCase = [SELECT Id From Case WHERE Id = :caseId];
        delete thisCase;
    }

    @HttpPut
    global static ID upsertCase(String subject, String status, String origin, String priority, String id) {
        Case thisCase = new Case(
            Id=id,
            Subject=subject,
            Status=status, 
            Origin=origin, 
            Priority=priority);
        upsert thisCase;

        return thisCase.Id;
    }
    
}