({
    getSum : function(component, event, helper, varA, varB) {
        console.log('Variable A ='+varA);
        console.log('Variable B ='+varB);
        console.log('SUM ='+ (varA+varB));
        alert('Before Result Debugger in action click F8 to get Result');
        debugger;
		component.find("out").set("v.value",varA+varB);
        alert(' Result ='+(varA+varB));

	},
	getMul : function(component, event, helper, varA, varB) {
        console.log('Variable A ='+varA);
        console.log('Variable B ='+varB);
        console.log('Mul ='+ (varA*varB));

	   component.find("out").set("v.value",varA*varB);

	},
	getDiv : function(component, event, helper, varA, varB) {
        console.log('Variable A ='+varA);
        console.log('Variable B ='+varB);
        console.log('DIV ='+ (varA/varB));

	   component.find("out").set("v.value",varA/varB);

	},
	getSub : function(component, event, helper, varA, varB) {
        console.log('Variable A ='+varA);
        console.log('Variable B ='+varB);
        console.log('SUB ='+ (varA-varB));

	   component.find("out").set("v.value",varA-varB);

	}

})