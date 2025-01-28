/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 28-01-2025
 * @last modified by  : npz
**/
({
doInit: function (component, event, helper) {
component.set("v.isLoading", true)
component.set("v.statusOptions", [
    { label: "All", value: "" },
    { label: "Pending", value: "Pending" },
    { label: "Confirmed", value: "Confirmed" },
    { label: "Cancelled", value: "Cancelled" }
]);
component.set("v.columns", [
    { label: "Name", fieldName: "Name", type: "text", sortable: true  },
    { label: "Email", fieldName: "Email__c", type: "email" },
    { label: "Phone", fieldName: "Phone__c", type: "phone" },
    { label: "Ticket Status", fieldName: "Ticket_Status__c", type: "text", sortable: true},
    {type: "button",label: "Action",cellAttributes: { alignment: 'center' } ,
        typeAttributes: {
            label: "Edit",
            name: "edit",
            variant: "brand-outline",
        }
    }
]);

// simulasi isLoading untuk data yang banyak
setTimeout($A.getCallback(function () {
    helper.fetchTickets(component, "");    
    component.set("v.isLoading", false);
}), 2000);
},

handleStatusChange: function (component, event, helper) {
const selectedStatus = component.get("v.selectedStatus");
helper.fetchTickets(component, selectedStatus);
},

openModal: function (component, event, helper) {
component.set("v.isModalOpen", true);
component.set("v.modalTitle", "New Webinar Ticket");
component.set("v.selectedTicket", null);
},

closeModal: function (component, event, helper) {
component.set("v.isModalOpen", false);
},

handleTicketCreated: function (component, event, helper) {
helper.fetchTickets(component, "");
component.set("v.isModalOpen", false);
},
handleSort: function (component, event, helper) {
const fieldName = event.getParam('fieldName'); 
const sortDirection = event.getParam('sortDirection');


component.set('v.sortedBy', fieldName);
component.set('v.sortDirection', sortDirection);


const tickets = component.get('v.tickets');
helper.sortData(tickets, fieldName, sortDirection);
component.set('v.tickets', tickets);
},
handleRowAction: function(component, event, helper){
const action = event.getParam('action');
const row = event.getParam('row');

if (action.name === "edit") {
    component.set("v.modalTitle", "Edit Webinar Ticket");
    component.set("v.selectedTicket", row);
    component.set("v.isModalOpen", true);
}
}
})