({
	fireNotifierCompoController : function(component, event, helper) {
        var vAppEventReference = $A.get("e.c:LEX_ApplicationEvent");
        vAppEventReference.setParams({
            "att_AppEvent_value_holder":"An application event is fired via Notifier Component"
        });
        vAppEventReference.fire();
	}
})