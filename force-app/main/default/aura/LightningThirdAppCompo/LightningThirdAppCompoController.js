({
	processInput : function(component, event, helper) {
        
        var firstName = component.find("FN").get("v.value");
		var secondName = component.find("SN").get("v.value");
        component.find("Out").set("v.value",firstName+', '+secondName);

	}
})