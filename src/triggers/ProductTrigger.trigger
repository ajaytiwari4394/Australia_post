trigger ProductTrigger on Product2(after insert, after update,before insert) 
{
    
    ProductTriggerHandler handler = new ProductTriggerHandler();
    if(Trigger.isAfter && Trigger.isInsert)
    { 
       handler.afterInsert(trigger.New);
    }
    if(Trigger.isAfter && Trigger.isUpdate)
    { 
        handler.afterUpdate(trigger.newMap, trigger.oldMap);
    }      
    
    
}