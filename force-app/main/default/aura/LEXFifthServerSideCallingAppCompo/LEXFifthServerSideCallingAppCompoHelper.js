({
	GetServerSideHelper : function(component) {
		var action= component.get("c.getMapData");
        action.setCallback(this,function(responce){
           // alert('Responce From Apex ='+responce);
           var state= responce.getState();
           // alert('state ='+state);
            if(state=='SUCCESS'){
                var result= responce.getReturnValue();
                var key;
                var vArrayMap= [];
                for(key in result){
                  // alert('Return Value ='+key+'Result in key ='+result[key]);
                    vArrayMap.push({Token:key,data:result[key]});
                }
                component.set("v.attMapValues",vArrayMap);
            }
        });
        $A.enqueueAction(action);
	}
})