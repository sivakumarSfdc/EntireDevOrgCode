({
	serverSideHelper : function(component,vDiceObj) {
		//alert('I am in  server side helper class');
		        //calling apex function
        var action= component.get("c.createRecord");
        //setting apex parameters
        action.setParams({
            diceObj : vDiceObj
        });
        action.setCallback(this,function(responce){
            var vState = responce.getState();
            if(vState == "SUCCESS"){
                var vCleraForum ={'sobjectType':'Dice_Job_Form__c',
                                   'First_Name__c':'',
                                   'Preferred_Country__c':'',
                                   'Experience__c':''
                                  };
               component.set("v.attDiceObjRec",vCleraForum);
               alert('record created successfully');
            }else{
               alert('Error in calling apex class');
            }
        });
        $A.enqueueAction(action);

	}
})