({
	displayFullName : function(component, event, helper) {
        //"var" has ability to store any kind of data like string, integer, boolen....
        var FirstName = component.find("fName").get("v.value");
        //component.find("fName") get's control over initiated component elements
        var SecondName = component.find("sName").get("v.value");
        // for fetching the value we need to use "v.value" v>>refers to the component side
        component.find("outFullName").set("v.value",FirstName+" "+SecondName);
		
	},
    clearTheForm:function(component){
        component.find("fName").set("v.value","");
        component.find("sName").set("v.value","");
        component.find("outFullName").set("v.value","");
    }
})