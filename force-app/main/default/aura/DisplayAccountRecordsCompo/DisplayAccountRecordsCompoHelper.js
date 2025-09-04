({
	fetchAccRecords : function(component) {
		var action=component.get("c.getAccountRecords");
        action.setCallback(this,function(response){
            var state = response.getState();
            console.log('State ='+state);
            if(component.isValid() && state === 'SUCCESS'){
                console.log('response.getReturnValue() ='+response.getReturnValue());
                component.set("v.attAccList",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}
})