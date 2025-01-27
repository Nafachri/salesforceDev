@isTest
public class ProjectHandlerTest {
	@isTest
    static void testProjectHandler() {
        // membuat project baru
        Id projectId = ProjectHandler.createProject('IDStar Salesforce Bootcamp', 'Belum Dimulai', 500000000, Date.today(), Date.today().addDays(30));
        System.assertNotEquals(null, projectId, 'Project harus berhasil dibuat');
        
        // memperbarui project 
        ProjectHandler.updateProject(projectId, 'Selesai');
        Project__c updatedProject = [SELECT Project_Status__c FROM Project__c WHERE Id = :projectId];
        System.assertEquals('Selesai', updatedProject.Project_Status__c, 'Status harus menjadi Selesai');
        
        // mengambil daftar project
        List<Project__c> projects = ProjectHandler.getProjectsByStatus('Selesai');
        System.assert(projects.size() > 0, 'Harus ada project yang berstatus selesai');
    }
}