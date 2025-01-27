/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 27-01-2025
 * @last modified by  : npz
**/
({
    doInit: function (component, event, helper) {
        component.set("v.statusOptions", [
            { label: "All", value: "" },
            { label: "Pending", value: "Pending" },
            { label: "Confirmed", value: "Confirmed" },
            { label: "Cancelled", value: "Cancelled" }
        ]);
        component.set("v.columns", [
            { label: "Name", fieldName: "Name", type: "text" },
            { label: "Email", fieldName: "Email__c", type: "email" },
            { label: "Phone", fieldName: "Phone__c", type: "text" },
            { label: "Ticket Status", fieldName: "Ticket_Status__c", type: "text" }
        ]);

        helper.fetchTickets(component, ""); // Fetch all tickets initially
    },

    handleStatusChange: function (component, event, helper) {
        const selectedStatus = component.get("v.selectedStatus");
        helper.fetchTickets(component, selectedStatus);
    },

    openModal: function (component, event, helper) {
        component.set("v.isModalOpen", true);
        console.log('open modal', component.get('v.isModalOpen'));
    },

    closeModal: function (component, event, helper) {
        component.set("v.isModalOpen", false);
        console.log('Modal closed:', component.get('v.isModalOpen'));
    },

    handleTicketCreated: function (component, event, helper) {
        // Refresh the table after a ticket is created
        helper.fetchTickets(component, "");
        component.set("v.isModalOpen", false);
    }
})