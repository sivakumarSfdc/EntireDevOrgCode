({
	CSCCreateRecord : function(component, event, helper) {
		var vClientobj = component.get("v.attParkerObj");
        
        if($A.util.isEmpty(vClientobj.Name) || $A.util.isUndefined(vClientobj.Name)){
            alert('Name is required');
            return;
        }
        if($A.util.isEmpty(vClientobj.Price__c) || $A.util.isUndefined(vClientobj.Price__c)){
            alert('Price is required');
            return;
        }
        if($A.util.isEmpty(vClientobj.UID__c) || $A.util.isUndefined(vClientobj.UID__c)){
            alert('UID is required');
            return;
        }
        if($A.util.isEmpty(vClientobj.Oracle_Ext_ID__c) || $A.util.isUndefined(vClientobj.Oracle_Ext_ID__c)){
            alert('Oracle Ext ID is required');
            return;
        }
        helper.HelperMethodCreateRec(component);
    },
    CSCUpdateRecord:function(component, event, helper){
        var vClientobj = component.get("v.attParkerObj");
        var a,b,c;
        if($A.util.isEmpty(vClientobj.Name) || $A.util.isUndefined(vClientobj.Name)){
            a=true;
        }
        if($A.util.isEmpty(vClientobj.Price__c) || $A.util.isUndefined(vClientobj.Price__c)){
            b= true;
        }
        if($A.util.isEmpty(vClientobj.UID__c) || $A.util.isUndefined(vClientobj.UID__c)){
            alert('UID is required');
            return;
        }
        if($A.util.isEmpty(vClientobj.Oracle_Ext_ID__c) || $A.util.isUndefined(vClientobj.Oracle_Ext_ID__c)){
            c=true;
        }
        if(a==true && b===true && c==true){
            alert('enter something to update');
            return;
        }
        try{
         var price =parseInt(vClientobj.Price__c) ;
        }catch(err){
            alert('Error Msg ='+err.message());
            return;
        }
        helper.HelperMethodUpdateRec(component);

    },
    CSCDeleteRecord:function(component,event,helper){
          var vClientobj = component.get("v.attParkerObj");
          if($A.util.isEmpty(vClientobj.UID__c) || $A.util.isUndefined(vClientobj.UID__c)){
            alert('UID is required');
            return;
        }
        
        helper.HelperMethodDelete(component);


    }
    
})