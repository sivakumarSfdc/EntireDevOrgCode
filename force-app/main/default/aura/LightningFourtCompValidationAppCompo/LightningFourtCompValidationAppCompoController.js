({
	getValidorNot : function(component, event, helper) {
		var vAge = component.find("CAge").get("v.value");
        component.set("v.isButtonPressed",true);
        if(vAge >=18){
            component.set("v.isValidorNot",true);
        }else{
            component.set("v.isValidorNot",false); 
        }
	}
})