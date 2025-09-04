({
	callHelper : function(component) {
		var action = component.get("c.getAccountRecords");
        action.setCallback(this,function(responce){
            var state =responce.getState();
            if(component.isValid() && state == "SUCCESS"){
                component.set("v.attAccList",responce.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
	}
})