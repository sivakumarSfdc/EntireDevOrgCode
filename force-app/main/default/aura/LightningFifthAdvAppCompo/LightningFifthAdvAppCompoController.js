({
    callClientSideController : function(component, event, helper) {
        var vDiceObj = component.get("v.attDiceObjRec");
        console.log('inside client side controller :'+vDiceObj);
        if($A.util.isEmpty(vDiceObj.First_Name__c) || $A.util.isUndefined(vDiceObj.First_Name__c)){
            alert('First Name is Required');
            return;
        }
        if($A.util.isEmpty(vDiceObj.Preferred_Country__c) || $A.util.isUndefined(vDiceObj.Preferred_Country__c)){
            alert('Country is Required');
            return;
        }
        if($A.util.isEmpty(vDiceObj.Experience__c) || $A.util.isUndefined(vDiceObj.Experience__c)){
            alert('Experience is Required');
            return;
        }
        //calling helper
        helper.serverSideHelper(component,vDiceObj);

	}

    
})