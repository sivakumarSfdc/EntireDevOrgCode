({
	FireNotifierSideJSCode : function(component, event, helper) {
		var vCompEvent= component.getEvent("attNotifierCompoEvent");
        vCompEvent.setParams({
            "message" :"Messages is passed from child Notifier Component to Parent Handler Component via ComponetEvent"
        });
        vCompEvent.fire();
	}
})