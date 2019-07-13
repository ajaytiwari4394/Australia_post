trigger LeadAutoConvert on Lead (after insert) {    
    
    if(trigger.isInsert && trigger.isAfter){
        LeadAutoConvertHelper.ConvertLeadHelperMethod(trigger.new);
    }
}