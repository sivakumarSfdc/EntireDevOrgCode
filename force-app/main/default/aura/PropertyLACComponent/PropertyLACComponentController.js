({
	insertProperty : function(component, event, helper) {
        var vHomeType = component.find("hometype").get("v.value");
        component.set("v.attPropertyObj.Type__c",vHomeType);
        var vPropertyObject = component.get("v.attPropertyObj");
        
        if($A.util.isEmpty(vPropertyObject.Price__c) || $A.util.isUndefined(vPropertyObject.Price__c)){
            alert('price required');
            return;
        }
        if($A.util.isEmpty(vPropertyObject.Type__c) || $A.util.isUndefined(vPropertyObject.Type__c)){
            alert('Home Type required');
            return;
        }
        
        helper.helperPropertyCreate(component);	
	},
    displayRecords : function(component,event,helper){
        helper.helperFetchRecords(component,event);
        
    }
})