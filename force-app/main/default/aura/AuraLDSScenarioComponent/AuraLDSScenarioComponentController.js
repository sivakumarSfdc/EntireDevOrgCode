({
	handleDelete : function(component, event, helper) {
        
        component.find("EmployeeRecDelete").deleteRecord($A.getCallback(function(deleteResult){
            
            if(deleteResult.state === 'SUCCESS' ||deleteResult.state === 'DRAFT' ){
                console.log('Record Deleted successfully');
                component.set("v.attRecordError","Success");
            }else if(deleteResult.state === 'INCOMPLETE' ){
                console.log('User offline');
                component.set("v.attRecordError","User offline");

            }else if(deleteResult.state === 'ERROR' ){
                console.log('Error ='+JSON.Stringify(deleteResult.ERROR));
                component.set("v.attRecordError",JSON.Stringify(deleteResult.ERROR));

            }
            
        }));
		
	}
})