/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 28-01-2025
 * @last modified by  : npz
**/
({
    fetchTickets: function (component, status) {
        const action = component.get("c.getTickets");
        action.setParams({ status: status });

        action.setCallback(this, function (response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.tickets", response.getReturnValue());
            } else {
                console.error("Failed to fetch tickets: ", response.getError());
            }
        });

        $A.enqueueAction(action);
    },
    sortData: function (data,  fieldName, sortDirection){

        const customOrder = {
            Confirmed: 1,
            Pending: 2,
            Cancelled: 3
        };

        const reverse = sortDirection === 'asc' ? 1 : -1;

        data.sort((a, b) => {
            let valA = a[fieldName] || '';
            let valB = b[fieldName] || '';

            if (fieldName === 'Ticket_Status__c') {
                if (customOrder[valA] !== undefined && customOrder[valB] !== undefined) {
                    return reverse * (customOrder[valA] - customOrder[valB]);
                }
            }

           
            if (typeof valA === 'string') {
                valA = valA.toLowerCase();
            }
            if (typeof valB === 'string') {
                valB = valB.toLowerCase();
            }

            return reverse * ((valA > valB) - (valA < valB));
        });
    }
});