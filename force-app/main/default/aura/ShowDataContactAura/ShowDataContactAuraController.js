({
    doInit : function(component, event, helper) {
        
        component.set("v.columns", [
            { label: "Name", fieldName: "Name", type: "text" },
            { label: "Email", fieldName: "Email", type: "email" }
        ]);
        
        var action = component.get("c.getContacts");
        action.setCallback(this, (res) => {
            if(res.getState() === "SUCCESS"){
            console.log('debug', res.getReturnValue())
            
            component.set('v.contacts', res.getReturnValue());
        }
                           })
        $A.enqueueAction(action);
    },
    /* getSelectedName: function (cmp, event) {
        console.log(event.getParam('selectedRows'));
        var selectedRows = event.getParam('selectedRows');
        // Display that fieldName of the selected rows
        for (var i = 0; i < selectedRows.length; i++){
            alert("You selected: " + selectedRows[i].Name);
        }
    } */
})