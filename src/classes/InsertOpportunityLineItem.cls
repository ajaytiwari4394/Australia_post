public class InsertOpportunityLineItem 
{    
    /**
    * @author Lav - Health Cert
    * @date 03/10/2017
    *
    * @description This handler class will check the product Course ID and 
    * will auto create opportunityLineitem in order to make it searchable from opportunity.
    **/
    
    // This method will check product Course ID and tag that product to opportunity line item.
    public static list<OpportunityLineItem> linkProductToOpportunitylineitem(list<Opportunity> opportunityTriggerNew)
    {
        map<string,opportunity> mapOfcourseIdwithOpp = new map<string,opportunity>();
        map<string,List<OpportunityLineItem>> mapOfcourseIdwithOppLineItem = new map<string,List<OpportunityLineItem>>();
        set<Id> setOfOpportunityId = new set<id>();
        List<OpportunityLineItem> listOfOpportunitylineItem = new List<OpportunityLineItem>();
        for(Opportunity ObjOpportunity : opportunityTriggerNew)
        {
            if(ObjOpportunity.Name != null && ObjOpportunity.id == null)
            {
                mapOfcourseIdwithOpp.put(ObjOpportunity.Name,ObjOpportunity);
                system.debug('mapOfcourseIdwithOpp========='+mapOfcourseIdwithOpp);
            }
            if(ObjOpportunity.id != null)
            {
                setOfOpportunityId.add(ObjOpportunity.id);
                system.debug('setOfOpportunityId========='+setOfOpportunityId);
            }
        }
        
        if(setOfOpportunityId != null && setOfOpportunityId.size()>0)
        {
            List<Opportunity> LstOppWithOppLineItems =[SELECT Id, Name, Account.Name, (SELECT id,UnitPrice,PricebookEntry.Name, PricebookEntry.Product2.Family FROM OpportunityLineItems) FROM Opportunity WHERE Id In :setOfOpportunityId];
            system.debug('LstOppWithOppLineItems============'+LstOppWithOppLineItems);
            if(LstOppWithOppLineItems !=  null && LstOppWithOppLineItems.size()>0)
            {
            
                for(Opportunity objOpp : LstOppWithOppLineItems)
                {
                system.debug('objOpp============'+objOpp );
                    if(objOpp.OpportunityLineItems != null && objOpp.OpportunityLineItems.size()>0)
                    {
                        for(OpportunityLineItem objoppLineItem : objOpp.OpportunityLineItems)
                        {
                            system.debug('objoppLineItem============'+objoppLineItem );
                            if(mapOfcourseIdwithOppLineItem.get(objOpp.Name)== null)
                            {
                                mapOfcourseIdwithOppLineItem.put(objOpp.Name,new list<OpportunityLineItem>());
                            }
                            mapOfcourseIdwithOppLineItem.get(objOpp.Name).add(objoppLineItem);
                            system.debug('mapOfcourseIdwithOppLineItem============'+mapOfcourseIdwithOppLineItem);
                        }
                    }
                }
            }
        }
        system.debug('mapOfcourseIdwithOpp ***'+mapOfcourseIdwithOpp );
        if(mapOfcourseIdwithOpp != null && !mapOfcourseIdwithOpp.isEmpty())
        {
            List<PriceBookEntry> priceBookList = [SELECT Id,UnitPrice, Product2Id, Product2.Id, Product2.Name,Product2.Course_ID__c FROM PriceBookEntry WHERE Product2.Course_ID__c In: mapOfcourseIdwithOpp.keyset()];
            map<string,PriceBookEntry> mapCourseIdPBE = new map<string,PriceBookEntry>();
            if(priceBookList != null && priceBookList.size()>0)
            {
                for(PricebookEntry objPBE : priceBookList) {
                    if(mapCourseIdPBE.get(objPBE.Product2.Course_ID__c) == null) {
                        mapCourseIdPBE.put(objPBE.Product2.Course_ID__c,objPBE);
                    }
                        
                    
                }
            
                integer count = 0;
                for(Opportunity ObjOpportunity : opportunityTriggerNew)
                {
                    if(mapCourseIdPBE.containskey(ObjOpportunity.Name))
                    {
                        string timestamp = string.valueof(system.now());
                        Opportunity objOppty = new Opportunity(Oppty_ExternalId__c = timestamp+count);
                        
                        ObjOpportunity.Oppty_ExternalId__c = timestamp+count;
                        OpportunityLineItem objOpportunityLineItem = new OpportunityLineItem();
                        objOpportunityLineItem.Opportunity = objOppty;
                        objOpportunityLineItem.PricebookEntryId = mapCourseIdPBE.get(ObjOpportunity.Name).id;
                        objOpportunityLineItem.Quantity =1;
                        if(mapOfcourseIdwithOpp.get(ObjOpportunity.Name).Revenue__c != null)
                        {
                            objOpportunityLineItem.UnitPrice =mapOfcourseIdwithOpp.get(ObjOpportunity.Name).Revenue__c;
                        } 
                        listOfOpportunitylineItem.add(objOpportunityLineItem);
                        count++;
                    }
                }
            }
        }
        if(mapOfcourseIdwithOppLineItem != null && !mapOfcourseIdwithOppLineItem.isEmpty())
        {
            for(Opportunity ObjOpportunity : opportunityTriggerNew)
            {
                if(ObjOpportunity.id != null)
                {
                    system.debug('ObjOpportunity========'+ObjOpportunity);
                    if(mapOfcourseIdwithOppLineItem.containskey(ObjOpportunity.Name))
                    {
                        for(OpportunityLineItem ObjOppLineItem : mapOfcourseIdwithOppLineItem.get(ObjOpportunity.Name))
                        {
                            OpportunityLineItem objOpportunityLineItem = ObjOppLineItem;
                            objOpportunityLineItem.id = ObjOppLineItem.id;
                            objOpportunityLineItem.UnitPrice = ObjOpportunity.Revenue__c;
                            listOfOpportunitylineItem.add(objOpportunityLineItem);
                            system.debug('listOfOpportunitylineItem========'+listOfOpportunitylineItem);
                        }
                    }
                }    
            }
        }
        system.debug('listOfOpportunitylineItem ***'+listOfOpportunitylineItem );
        if(listOfOpportunitylineItem != null && listOfOpportunitylineItem.size()>0)
        {
            return listOfOpportunitylineItem;           
        }
        return null;
    }
}