trigger UpdateOpportunity on Opportunity (after update) {
    if(trigger.Isafter && trigger.isUpdate) {
        system.debug('Inside trigger >>>>>');
        UpdateOpportunity_Helper.updateOpportunityField(Trigger.newMap, trigger.oldMap, trigger.new);
    }
}