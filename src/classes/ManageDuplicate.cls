public class ManageDuplicate
{
    public set<Id> getDuplicateAccountId (Database.UpsertResult sr) {
        Set<Id> setDuplicateIds = new Set<id>();
        if (!sr.isSuccess()) {
            
            Datacloud.DuplicateResult duplicateResult;
    
            // Insertion failed due to duplicate detected
            for(Database.Error duplicateError : sr.getErrors()){
    
                duplicateResult = ((Database.DuplicateError)duplicateError).getDuplicateResult();
            }
    
        // Fetch the Ids of the existing duplicate records
            for(Datacloud.MatchResult duplicateMatchResult : duplicateResult.getMatchResults()) {
    
                for(Datacloud.MatchRecord duplicateMatchRecord : duplicateMatchResult.getMatchRecords()) {
    
                    setDuplicateIds.add(duplicateMatchRecord.getRecord().Id);
                }
            }
        }
        return setDuplicateIds;
    }
   
    public list<opportunity> getDuplicateopportunity(string accountEmail,List<opportunity>listOfOpportunity) 
    { 
        map<string,opportunity> mapofEmailAndCourseId = new map<string,opportunity>();
        map<string,opportunity> mapofDuplicateOpportunity = new map<string,opportunity>();
        map<string,Decimal> mapOfstageWithProbability = new map<string,Decimal>();
        list<OpportunityStage> listOfOpportunityStage =[select id,ApiName,isactive,DefaultProbability from OpportunityStage where isactive = true];
        Map<string, StageProbability__c> oppStageProbability = StageProbability__c.getAll();
        set<Opportunity> setOfNewOpportunity = new set<Opportunity>();
        List<Opportunity> listOfNewOpportunity = new List<Opportunity>();
        if(listOfOpportunityStage != null && listOfOpportunityStage.size()>0)
        {
            for(OpportunityStage oppStage : listOfOpportunityStage)
            {
                mapOfstageWithProbability.put(oppStage.ApiName,oppStage.DefaultProbability);
            }
        }
        system.debug('accountEmail==============='+accountEmail);
        system.debug('listOfOpportunity==============='+listOfOpportunity);
        if(accountEmail != '' && listOfOpportunity != null && listOfOpportunity.size()>0)
        {
            for(opportunity objOpportunity : listOfOpportunity)
            {
                mapofEmailAndCourseId.put(objOpportunity.Name+accountEmail,objOpportunity);
                system.debug('mapofEmailAndCourseId==============='+mapofEmailAndCourseId);
            }
            if(mapofEmailAndCourseId != null && !mapofEmailAndCourseId.isEmpty())
            {
                List<Opportunity> listOfDuplicateOpportunity =[select id,Accountid,Revenue__c,Account.personemail,stageName,Name,Duplicate_Key__c from opportunity where Duplicate_Key__c in: mapofEmailAndCourseId.keyset() ORDER BY LastModifiedDate DESC];
                system.debug('listOfDuplicateOpportunity==============='+listOfDuplicateOpportunity);
                if(listOfDuplicateOpportunity != null && listOfDuplicateOpportunity.size()>0)
                {
                    for(Opportunity objdupOpportunity :listOfDuplicateOpportunity)
                    {
                        if(mapofDuplicateOpportunity.get(objdupOpportunity.Duplicate_Key__c)== null)
                        {
                            mapofDuplicateOpportunity.put(objdupOpportunity.Duplicate_Key__c,objdupOpportunity);
                        }
                    }  
                    system.debug('mapofDuplicateOpportunity==============='+mapofDuplicateOpportunity); 
                    if(mapofDuplicateOpportunity != null && !mapofDuplicateOpportunity.isEmpty())
                    {
                        for(opportunity objOpportunity : listOfOpportunity)
                        {
                            system.debug('objOpportunity==============='+objOpportunity); 
                            if(mapofDuplicateOpportunity.containskey(objOpportunity.Name+accountEmail) && objOpportunity.id == null)
                            {
                                if(mapOfstageWithProbability.get(objOpportunity.stageName) >= mapOfstageWithProbability.get(mapofDuplicateOpportunity.get(objOpportunity.Name+accountEmail).stageName) && mapOfstageWithProbability.get(mapofDuplicateOpportunity.get(objOpportunity.Name+accountEmail).stageName) <= oppStageProbability.get('3').Probability__c)
                                {
                                    Opportunity existingOpportunity = objOpportunity;
                                    existingOpportunity.id=mapofDuplicateOpportunity.get(objOpportunity.Name+accountEmail).id;
                                    setOfNewOpportunity.add(existingOpportunity);
                                    system.debug('setOfNewOpportunity111=========='+setOfNewOpportunity);
                                }
                                if((mapOfstageWithProbability.get(objOpportunity.stageName) < mapOfstageWithProbability.get(mapofDuplicateOpportunity.get(objOpportunity.Name+accountEmail).stageName) && mapOfstageWithProbability.get(mapofDuplicateOpportunity.get(objOpportunity.Name+accountEmail).stageName) <= oppStageProbability.get('3').Probability__c) || (mapOfstageWithProbability.get(mapofDuplicateOpportunity.get(objOpportunity.Name+accountEmail).stageName) == oppStageProbability.get('4').Probability__c && mapOfstageWithProbability.get(objOpportunity.stageName) <= oppStageProbability.get('3').Probability__c))
                                {
                                    system.debug('mapOfstageWithProbability1================='+objOpportunity);
                                    objOpportunity.Opportunity_Status__c = 'No Change Required';
                                    setOfNewOpportunity.add(objOpportunity);
                                }
                                if((mapOfstageWithProbability.get(objOpportunity.stageName) == oppStageProbability.get('4').Probability__c && mapOfstageWithProbability.get(mapofDuplicateOpportunity.get(objOpportunity.Name+accountEmail).stageName) == oppStageProbability.get('4').Probability__c) || (mapOfstageWithProbability.get(objOpportunity.stageName) < mapOfstageWithProbability.get(mapofDuplicateOpportunity.get(objOpportunity.Name+accountEmail).stageName) && mapOfstageWithProbability.get(mapofDuplicateOpportunity.get(objOpportunity.Name+accountEmail).stageName) > oppStageProbability.get('4').Probability__c))
                                {
                                    setOfNewOpportunity.add(objOpportunity);
                                    system.debug('listOfNewOpportunitykhkh==================='+setOfNewOpportunity);
                                }
                            }
                            else
                            {
                                system.debug('objOpportunity==============='+objOpportunity);
                                setOfNewOpportunity.add(objOpportunity);
                            }
                        }
                    }               
                }
                else
                {
                    system.debug('listOfOpportunity================='+listOfOpportunity);
                    listOfNewOpportunity.addall(listOfOpportunity);
                }
            }
        }
        system.debug('setOfNewOpportunity================='+setOfNewOpportunity);
        listOfNewOpportunity.addAll(setOfNewOpportunity);
        system.debug('listOfNewOpportunity================='+listOfNewOpportunity);
        return listOfNewOpportunity;
        
    }
    // Duplicate check on manual creation of opportunity
    public void getManualDuplicateopportunity(List<opportunity> listOfManualOpportunity) 
    {
        set<string> setOfManualOpportunity = new set<string>();
        set<Id> setOfDuplicateId = new set<Id>();
        map<id,string> mapOfaccountIdWithEmail = new map<id,string>();
        map<string,opportunity> mapOfDuplicateopportunity = new map<string,opportunity>();
        for(Opportunity manualOpp : listOfManualOpportunity)
        {
            if(manualOpp.Created_by_Api__c == false && manualOpp.AccountId != null)
            {
                setOfDuplicateId.add(manualOpp.AccountId);
            }
        }
        if(setOfDuplicateId != null && setOfDuplicateId.size()>0)
        {
            list<Account> lstOfAccount =[select id,PersonEmail from Account where id in : setOfDuplicateId ];
            if(lstOfAccount != null && lstOfAccount.size()>0)
            {
                for(Account ObjAcc : lstOfAccount )
                {
                    mapOfaccountIdWithEmail.put(ObjAcc.Id,ObjAcc.PersonEmail);
                }
            }
        }
        for(Opportunity manualOpp : listOfManualOpportunity)
        {
            if(manualOpp.Created_by_Api__c == false && manualOpp.AccountId != null)
            {
                if(mapOfaccountIdWithEmail != null && !mapOfaccountIdWithEmail.isempty() && mapOfaccountIdWithEmail.containskey(manualOpp.AccountId))
                {
                    setOfManualOpportunity.add(manualOpp.Name+mapOfaccountIdWithEmail.get(manualOpp.AccountId));
                }
            }
        }
        if(setOfManualOpportunity != null && setOfManualOpportunity.size()>0)
        {
            list<opportunity> lstOfOpportunity = [select id,Name,Duplicate_Key__c,Account.PersonEmail from Opportunity where Duplicate_Key__c in: setOfManualOpportunity];
            if(lstOfOpportunity != null && lstOfOpportunity.size()>0)
            {
                for(Opportunity objDupOpp : lstOfOpportunity)
                {
                    mapOfDuplicateopportunity.put(objDupOpp.Name+objDupOpp.Account.PersonEmail,objDupOpp);
                }
            }
        }
        if(mapOfDuplicateopportunity != null && !mapOfDuplicateopportunity .isEmpty())
        {
            for(Opportunity manualOpp : listOfManualOpportunity)
            {
                if(manualOpp.Created_by_Api__c == false && manualOpp.AccountId != null)
                {
                    if(mapOfDuplicateopportunity.containskey(manualOpp.Name+mapOfaccountIdWithEmail.get(manualOpp.AccountId)))
                    {
                        manualOpp.adderror(String.valueof(Label.Duplicate_Message));
                    }
                }
            }
        }
    }
}