({
	increaseCount : function(component, event, helper) {
        var action = component.get("c.increaseAdoptionCount");
        action.setParams({
            "feature" : component.get("v.feature"),
            "actionType" : component.get("v.action")
		});

        $A.enqueueAction(action);
        
		
	}
})
