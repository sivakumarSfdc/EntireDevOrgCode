({
    doInit: function(component, event, helper) {
        var recordIds = component.get("v.recordIds");

        if (recordIds && recordIds.length > 0) {
            console.log('Inside delete Compo :', recordIds);

            var action = component.get("c.delAccounts");

            // recordIds might already be a List from Lightning Action
            var idsArray = Array.isArray(recordIds) ? recordIds : recordIds.split(',');

            action.setParams({ listOfAccIds: idsArray });

            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    alert("Selected accounts have been deleted successfully.");
                    $A.get("e.force:closeQuickAction").fire();
                    $A.get("e.force:refreshView").fire();
                } else {
                    var errors = response.getError();
                    alert("Error: " + (errors && errors[0] ? errors[0].message : 'Unknown error'));
                }
            });

            $A.enqueueAction(action);
        } else {
            console.log('Empty Record Ids:', recordIds);
        }
    }
})