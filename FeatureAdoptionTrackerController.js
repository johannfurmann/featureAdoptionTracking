({
    doInit: function(component, event, helper) {
        if(component.get("v.fireOnInit")){
			helper.increaseCount(component, event, helper);
        }
     },
    
    increaseCount: function(component, event, helper) {
		helper.increaseCount(component, event, helper);
     },    
})
