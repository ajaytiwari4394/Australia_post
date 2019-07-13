trigger OpportunityTrigger on Opportunity (before Insert, after Insert,after Update) 
{
    OpportunityTriggerHandler handler = new OpportunityTriggerHandler();
    if(Trigger.isbefore && Trigger.isInsert)
    { 
        handler.beforeInsert(trigger.New);
        
    }
    
     if(Trigger.isafter && Trigger.isInsert)
    { 
        
             handler.addOLI(trigger.New);

    }
    
     if(Trigger.isafter && Trigger.isUpdate)
    { 
        if(AvoidRecursion.isFirstRun() ){
        Boolean isApiCall= (String.valueOf(System.URL.getCurrentRequestUrl().getPath())).toLowerCase().contains('services');
           system.debug('isApiCall='+isApiCall);
            if(!isApiCall){
              handler.updateOLI(trigger.newMap, trigger.oldMap, trigger.New );
           }
    }
        else if(Test.isRunningTest()){
                       handler.updateOLI(trigger.newMap, trigger.oldMap, trigger.New );

        }
    }
    
    
}