({
	helperPropertyCreate : function(component) {
        
        var vHeleperPropertObject = component.get("v.attPropertyObj");
        
        var action = component.get("c.insertPropertyRecord");
        action.setParams({
            propertyObject : vHeleperPropertObject
        });
        
        action.setCallback(this,function(responce){
            var state= responce.getState();
            if(state == 'SUCCESS'){
             alert('Record Created successfully');
                var newPropertyRec = {'sobjectType':'Property__c',
                                          'Price__c':'',
                                          'Type__c':''
                                        };
                component.set("v.attPropertyObj",newPropertyRec);
                component.find("hometype").set("v.value","");
            }else if(state =='ERROR'){
                var Error = action.getError();
              alert('responce ='+Error[0].message);
            }
        });
        $A.enqueueAction(action);
		
	},
    helperFetchRecords : function(component,event){
       var action = component.get("c.getListOfPropertyRecords");
       action.setCallback(this,function(responce){
            var state= responce.getState();
            if(state == 'SUCCESS' && component.isValid()){
                
                var returnRecords = responce.getReturnValue();
                component.set("v.attListOfRecords",returnRecords);
                component.set("v.attRefreshClick",true);

                
            }else if(state =='ERROR'){
                var Error = action.getError();
              alert('responce ='+Error[0].message);
            }
        });
        $A.enqueueAction(action);

    }
})