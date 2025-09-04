({
	HandlerJsControler : function(component, event, helper) {
		var vReceivedMsg =event.getParam("message");
        component.set("v.attDisMsgFromNotifier",vReceivedMsg);
        var numEventsHandled=parseInt(component.get("v.attDisplayClickEventNo"))+1;
        component.set("v.attDisplayClickEventNo",numEventsHandled);
	}
})