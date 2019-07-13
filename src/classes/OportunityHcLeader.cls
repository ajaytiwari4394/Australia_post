public class OportunityHcLeader {
    public static void InsertOppunity(Opportunity opplist)
    {
        try{
         
            
            list<Account> AcclistUpdate =new list<Account>();
            Account Acc=[Select id, HC_Leader__c from Account where id=:opplist.Accountid];
            Acc.HC_Leader__c=opplist.HC_Leader__c;
            AcclistUpdate.Add(Acc);
            update AcclistUpdate;
        }catch(Exception e) 
        {
            System.debug('Error...'+e.getMessage()+' Of the Line Number..'+e.getLineNumber());
        }
        
    }
    
      public static void UpdateOppunity(list<Opportunity> oppnewlist , map<id,Opportunity> MapOpplist)
    {
        try{
            Map<id,string> maplist=new Map<id,String>();
            set<id> idlist=new set<id>();
            for(Opportunity opp: oppnewlist)
            {
                if(MapOpplist.get(opp.id).HC_Leader__c !=   opp.HC_Leader__c)
                {
                    idlist.add(opp.Accountid);
                    maplist.put(opp.Accountid,opp.HC_Leader__c);
                }
            }
            if(idlist.size()>0)
            {
            list<Account> Acclist=[select id,HC_Leader__c from Account where id=:idlist];
            list<Account> Accupdatelist=new list<Account>();
            for(Account Acc: Acclist)
            {
                if(maplist.containsKey(Acc.id))
                {
                Acc.HC_Leader__c=maplist.get(Acc.id);
                    Accupdatelist.add(Acc);
                }
            }
            update Accupdatelist;
            }
        }catch(Exception e) 
        {
            System.debug('Error...'+e.getMessage()+' Of the Line Number..'+e.getLineNumber());
        }
        
    }

}