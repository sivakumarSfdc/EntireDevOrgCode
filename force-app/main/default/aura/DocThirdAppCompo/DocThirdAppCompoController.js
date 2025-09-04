({
	GetFullName : function(component, event, helper) {
		var vFirstName = component.find("FName").get("v.value");
        var vSecondName = component.find("SName").get("v.value");
        var vGender = component.find("pl_gender").get("v.value");
        
        if($A.util.isEmpty(vFirstName) && $A.util.isUndefined(vFirstName)){
            alert('First Name is required');
            return;
        }
        if($A.util.isEmpty(vSecondName) &&  $A.util.isUndefined(vSecondName)){
            alert('Second Name is required');
            return;
        }
        if($A.util.isEmpty(vGender) &&  $A.util.isUndefined(vGender)){
            alert('Gender is required');
            return;
        }
        if(vGender == "M"){
            component.find("FullName").set("v.value",'Mr.'+vFirstName+' '+vSecondName);
        }else if(vGender == "F"){
            component.find("FullName").set("v.value",'Miss.'+vFirstName+' '+vSecondName);
        }else{
            component.find("FullName").set("v.value",'Invalid Gender');
        }

	}
})