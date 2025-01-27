public with sharing class ProjectController {
    // For LWC and Aura (with @AuraEnabled)
    @AuraEnabled(cacheable=true)
    public static List<Project__c> getProjects() {
        return [SELECT Id, Name, Project_Budget__c, Start_Date__c, End_Date__c, Project_Status__c FROM Project__c];
    }

    // For Visualforce (no @AuraEnabled needed)
    public static List<Project__c> getProjectsForVF() {
        return [SELECT Id, Name, Project_Budget__c, Start_Date__c, End_Date__c, Project_Status__c FROM Project__c];
    }
}