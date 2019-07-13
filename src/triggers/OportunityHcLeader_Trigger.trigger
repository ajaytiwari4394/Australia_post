trigger OportunityHcLeader_Trigger on Opportunity (before insert, before update) {
    
    if(Trigger.isBefore && Trigger.isInsert)
    {
        for(Opportunity opp:Trigger.New)
        {
            if(opp.AccountId!=null)
            {
                OportunityHcLeader.InsertOppunity(opp);
            }
        }
        
    }
    else if(Trigger.isBefore && Trigger.isupdate)
    {    
    
        OportunityHcLeader.UpdateOppunity(Trigger.New,Trigger.oldmap);
    }
   
}