({
	fetchDataFromAppEvent : function(component, event, helper) {
		var vgetInfoAppEvent = event.getParam("att_AppEvent_value_holder");
        
        component.set("v.att_msg",vgetInfoAppEvent);
        component.set("v.att_no_of_events",parseInt(component.get("v.att_no_of_events"))+1);
	}
})