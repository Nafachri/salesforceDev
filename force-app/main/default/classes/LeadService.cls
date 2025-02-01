/*public with sharing class LeadService {
    public static List<Leads> getAllLeads(){
        return[SELECT Id, FirstName, LastName, Company, Status FROM Leads];
    } 
	
    public static List<Leads> getLeadsByStatus(String Status){
        return[SELECT Id, FirstName, LastName, Company, Status FROM Leads WHERE status = :status];
        
    }
    public static void updateLeadsStatus(set<Id> String new Status){
                
    }
    
}*/

public with sharing class LeadService {
    
    // Mengambil semua Leads
    public static List<Lead> getAllLeads() {
        return [SELECT Id, FirstName, LastName, Company, Status FROM Lead];
    }

    // Mengambil Leads berdasarkan Status
    public static List<Lead> getLeadsByStatus(String status) {
        return [SELECT Id, FirstName, LastName, Company, Status FROM Lead WHERE Status = :status];
    }

    // Memperbarui Status Lead berdasarkan ID
    public static void updateLeadsStatus(Set<Id> leadIds, String newStatus) {
        List<Lead> leadsToUpdate = [SELECT Id, Status FROM Lead WHERE Id IN :leadIds];
        
        for (Lead lead : leadsToUpdate) {
            lead.Status = newStatus;
        }
        
        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }

    // Membuat Leads baru
    public static void createLead(String firstName, String lastName, String company, String status) {
        Lead newLead = new Lead(
            FirstName = firstName,
            LastName = lastName,
            Company = company,
            Status = status
        );
        insert newLead;
    }
}