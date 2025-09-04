({
handleLWCClose : function(component, event, helper) {
    let cb = component.get("v.vfCallback");
    if (typeof cb === 'function') {
        cb();
    }
    component.destroy();
}
})