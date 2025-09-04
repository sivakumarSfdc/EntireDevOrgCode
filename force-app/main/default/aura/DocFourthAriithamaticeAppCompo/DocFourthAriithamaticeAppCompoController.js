({
	getResult : function(component, event, helper) {
		
        var vFirstNumber = component.find("FNumber").get("v.value");
        var vSecondNumber = component.find("SNumber").get("v.value");
       // var vButtonId = event.getSource().getLocalId();
         var vButtonName = event.getSource().get("v.name");
        if($A.util.isEmpty(vFirstNumber) && $A.util.isUndefined(vFirstNumber)){
            alert('First Number is required');
            return;
        }
        if($A.util.isEmpty(vSecondNumber) && $A.util.isUndefined(vSecondNumber)){
            alert('Second Number is required');
            return;
        }
        
        try{
            var varA = parseInt(vFirstNumber);
            var varB = parseInt(vSecondNumber);
            switch(vButtonName){
                case 'sum':
                    helper.getSum(component, event, helper,varA,varB);
                    break;
                case 'mul':
                    helper.getMul(component, event, helper,varA,varB);
                    break;
                case 'div':
                    helper.getDiv(component, event, helper,varA,varB);
                    break;
                case 'sub':
                    helper.getSub(component, event, helper,varA,varB);
                    break;
                    
                default:
                    break;

            }
        }catch(err){
            alert('Error Msg ='+err.message);
        }
        

	}
})