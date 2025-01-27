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
    }
});