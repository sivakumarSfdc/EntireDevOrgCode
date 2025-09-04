({
	HelperMethodCreateRec : function(component) {
        var clientObj =component.get("v.attParkerObj");
		var action = component.get("c.CreateRecord");
        action.setParams({
            parkerPenObj: clientObj
        });
        
        action.setCallback(this,function(responce){
            var state= responce.getState();
            if(state == 'SUCCESS'){
             alert('Record Created successfully');
                var newEmptyClientRec = {'sObjectType':'Parker_Pen__c',
                                          'Name':'',
                                          'Price__c':'',
                                          'UID__c':'',
                                          'Oracle_Ext_ID__c':''};
                component.set("v.attParkerObj",newEmptyClientRec);
            }else if(state =='ERROR'){
                var Error = action.getError();
              alert('responce ='+Error[0].message);
            }
        });
        $A.enqueueAction(action);
        
	},
   HelperMethodUpdateRec : function(component) {
        var clientObj =component.get("v.attParkerObj");
		var action = component.get("c.UpdateRecord");
        action.setParams({
            parkerPenObj: clientObj
        });
        
        action.setCallback(this,function(responce){
            var state= responce.getState();
            if(state == 'SUCCESS'){
             alert('Record Updated successfully');
                var newEmptyClientRec = {'sObjectType':'Parker_Pen__c',
                                          'Name':'',
                                          'Price__c':'',
                                          'UID__c':'',
                                          'Oracle_Ext_ID__c':''};
                                component.set("v.attParkerObj",newEmptyClientRec);
            }else if(state =='ERROR'){
                var Error = action.getError();
              alert('responce ='+Error[0].message);
            }
        });
        $A.enqueueAction(action);

	},
    HelperMethodDelete : function(component) {
        var clientObj =component.get("v.attParkerObj");
		var action = component.get("c.DeleteRecord");
        action.setParams({
            parkerPenObj: clientObj
        });
        
        action.setCallback(this,function(responce){
            var state= responce.getState();
            if(state == 'SUCCESS'){
             alert('Record Deleted successfully');
                var newEmptyClientRec = {'sObjectType':'Parker_Pen__c',
                                          'Name':'',
                                          'Price__c':'',
                                          'UID__c':'',
                                          'Oracle_Ext_ID__c':''};
                                component.set("v.attParkerObj",newEmptyClientRec);
            }else if(state =='ERROR'){
                var Error= action.getError();
              alert('responce ='+Error[0].message);
            }
        });
         $A.enqueueAction(action);

	}
})