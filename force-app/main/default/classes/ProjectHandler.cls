public class ProjectHandler {
    // Method untuk membuat Project baru
    public static Id createProject(String projectName, String status, Decimal budget, Date startDate, Date endDate) {
        Project__c newProject = new Project__c(
            Name = projectName,
            Project_Status__c  = status,
            Project_Budget__c = budget,
            Start_Date__c = startDate,
            End_Date__c = endDate
        );
        insert newProject;
        return newProject.Id;
    }
    
    // Method untuk memperbarui project
    public static void updateProject(Id projectId, String newStatus) {
        Project__c projectToUpdate = [Select Id, Project_Status__c FROM Project__c WHERE Id = :projectId LIMIT 1];
        ProjectToUpdate.Project_Status__c = newStatus;
        update projectToUpdate;
    }
    
    // Method untuk mengambil daftar project berdasarkan status
    public static List<Project__c> getProjectsByStatus(String status) {
        return [SELECT Id, Name, Project_Status__c, Start_Date__c, End_Date__c
                FROM Project__c
                WHERE Project_Status__c = :status];
    }
}