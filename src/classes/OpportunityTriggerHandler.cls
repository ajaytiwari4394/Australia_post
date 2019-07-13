public class OpportunityTriggerHandler 
{    
    /**
* @author Lav - Health Cert
* @date 03/10/2017
*
* @description This handler class will check the duplicate  
* opportunity on the basis of Course ID and email.
**/
    //This method called on after insert of trigger
    
    public void beforeInsert(list<opportunity> opportunityTriggerNew)
    {
        Map<String,Opportunity_trigger_switch__c> opportunityTriggerSwitch = Opportunity_trigger_switch__c.getAll();
        system.debug('opportunityTriggerSwitch>>>>>>>'+opportunityTriggerSwitch);
        system.debug('opportunityTriggerSwitch.getdfsdf>>>>>df'+opportunityTriggerSwitch.get('OpportunityTrigger'));
        if(opportunityTriggerSwitch.get('OpportunityTrigger').IsCheck__c == True)
        {
            ManageDuplicate DuplicateOpportunity = new ManageDuplicate();  
            DuplicateOpportunity.getManualDuplicateopportunity(opportunityTriggerNew);              
            system.debug('opportunityTriggerSwitch>>>>>>>'+opportunityTriggerSwitch);
        }
        
    }
    
    //created by ANjali
    public void addOLI(list<Opportunity> opportunityTriggerNew)
    {
        map<string,opportunity> mapOfcourseIdwithOpp = new map<string,opportunity>();
        map<string,List<OpportunityLineItem>> mapOfcourseIdwithOppLineItem = new map<string,List<OpportunityLineItem>>();
        set<String> setOfOpportunityCourseId = new set<String>();
        List<OpportunityLineItem> listOfOpportunitylineItem = new List<OpportunityLineItem>();
        for(Opportunity objOpp : opportunityTriggerNew){
            setOfOpportunityCourseId.add(objOpp.name);
        }
        
        List<PriceBookEntry> priceBookList = [SELECT Id,UnitPrice, Product2Id, Product2.Id, Product2.Name,Product2.Course_ID__c FROM PriceBookEntry WHERE Product2.Course_ID__c In:setOfOpportunityCourseId];
        map<string,PriceBookEntry> mapCourseIdPBE = new map<string,PriceBookEntry>();
        if(priceBookList != null && priceBookList.size()>0)
        {
            for(PricebookEntry objPBE : priceBookList) {
                if(mapCourseIdPBE.get(objPBE.Product2.Course_ID__c) == null) {
                    mapCourseIdPBE.put(objPBE.Product2.Course_ID__c,objPBE);
                }
                
                
            }
        }
        list<Product2> productList= [SELECT Course_ID__c,Description,DisplayUrl,Early_Bird__c,Early_Price__c,ExternalDataSourceId,ExternalId,Family,Full_Price__c,Id,IsActive,Location__c,Name,PriceBook__c,ProductCode,ShortName__c FROM Product2 where Course_ID__c in :setOfOpportunityCourseId LIMIT 1 ];
        
        
        
        map<String, Product2> mapCourseIdProd = new map<String, Product2>();
        
        for( Product2 objProduct : productList )
        {
            if(mapCourseIdProd.get(objProduct.Course_ID__c) == null) {
                mapCourseIdProd.put(objProduct.Course_ID__c,objProduct);
            }
            
        }           
        for(Opportunity objOpp: opportunityTriggerNew ){
            system.debug('objOpp'+objOpp);
            if(objOpp.created_by_API__c==false){
                OpportunityLineItem objOpportunityLineItem = new OpportunityLineItem();
                system.debug('objOpp.Amount'+objOpp.Amount);
                if(objOpp.Amount!=null && objOpp.Amount!=0 ){
                    
                    system.debug('objOpp.Amount'+objOpp.Amount);
                    objOpportunityLineItem.UnitPrice = objOpp.Amount;
                }
                else if(objOpp.Revenue__c!=null && objOpp.Revenue__c!=0){
                    system.debug('bjOpp.Revenue__c'+objOpp.Revenue__c);
                    objOpportunityLineItem.UnitPrice = objOpp.Revenue__c;
                }
                else
                {
                    objOpportunityLineItem.UnitPrice = 0.0;
                }
                system.debug(objOpportunityLineItem.UnitPrice);
                objOpportunityLineItem.OpportunityID= objOpp.id;
                system.debug(' objOpportunityLineItem.Opportunity '+ objOpportunityLineItem.OpportunityID);
                system.debug('mapCourseIdPBE'+mapCourseIdPBE);
                if(mapCourseIdPBE!=null && ((mapCourseIdPBE.get(objOpp.Name)))!=null){
                    objOpportunityLineItem.PricebookEntryID = (mapCourseIdPBE.get(objOpp.Name).id);
                    system.debug(' objOpportunityLineItem.PricebookEntry '+ objOpportunityLineItem.PricebookEntryID );
                }
                else
                {
                    system.debug('(mapCourseIdPBE.get(objOpp.Name)).id + ');
                }
                objOpportunityLineItem.Quantity =1;
                if(mapCourseIdProd!=null && mapCourseIdProd.get(objOpp.Name)!=null){
                    objOpportunityLineItem.Product2Id=mapCourseIdProd.get(objOpp.Name).id;
                }
                else
                {
                    system.debug('mapCourseIdProd.get(objOpp.Name).id+'+mapCourseIdProd);
                }
                listOfOpportunitylineItem.add(objOpportunityLineItem);
            }
            
        }
        
        
        if(listOfOpportunitylineItem!=null && listOfOpportunitylineItem.size()>0)
        {
            if(!Test.isRunningTest()){
                try{
                    insert listOfOpportunitylineItem;
                    
                }
                catch(Exception ex)
                {
                    System.debug('getting erroron line number-->' +ex.getLineNUmber() +' error is'+ex.getMessage());
                    opportunityTriggerNew[0].addError('please make sure - active product exists in the system with price book entry');
                    
                }
            }
        }
        
        
    }
    
    
    //created by ANjali
    public void updateOLI(Map<ID, Opportunity> triggerNewMap,Map<ID, Opportunity> triggerOldMap,list<Opportunity> opportunityTriggerNew )
    {
        system.debug('triggerNewMap    ----'+ triggerNewMap);
        system.debug('triggerOldMap    ----'+ triggerOldMap);
        
        system.debug('entered updateOLI+++++++++++++++');       
        //  List<OpportunityLineItem> listToBeDeleted =new   List<OpportunityLineItem>();
        map<ID, OpportunityLineItem> mapOppWithOli = new map<ID, OpportunityLineItem>();
        List<OpportunityLineItem> existedOppLineItemList =new   List<OpportunityLineItem>();
        map<string,opportunity> mapOfcourseIdwithOpp = new map<string,opportunity>();
        map<string,List<OpportunityLineItem>> mapOfcourseIdwithOppLineItem = new map<string,List<OpportunityLineItem>>();
        set<String> setOfOpportunityCourseId = new set<String>();
        list<ID> setOfOpportunityIDs = new list<ID>();
        
        
        List<OpportunityLineItem> listOfOpportunitylineItem = new List<OpportunityLineItem>();
        
        
        for(ID oppID : triggerNewMap.keySet()){
            setOfOpportunityIDs.add(oppID);
        }
        
        
        system.debug('setOfOpportunityIDs===='+setOfOpportunityIDs);
        for(Opportunity objOpp : opportunityTriggerNew){
            setOfOpportunityCourseId.add(objOpp.name);
        }
        
        system.debug('setOfOpportunityCourseId'+setOfOpportunityCourseId);
        List<PriceBookEntry> priceBookList = [SELECT Id,UnitPrice, Product2Id, Product2.Id, Product2.Name,Product2.Course_ID__c FROM PriceBookEntry WHERE Product2.Course_ID__c IN :setOfOpportunityCourseId];
        
        system.debug('priceBookList>>>>>>>>'+priceBookList);
        
        map<string,PriceBookEntry> mapCourseIdPBE = new map<string,PriceBookEntry>();
        if(priceBookList != null && priceBookList.size()>0)
        {
            for(PricebookEntry objPBE : priceBookList) {
                if(mapCourseIdPBE.get(objPBE.Product2.Course_ID__c) == null) {
                    mapCourseIdPBE.put(objPBE.Product2.Course_ID__c,objPBE);
                }
            }
        }
        
        system.debug('mapCourseIdPBE >>>>>>>>>'+mapCourseIdPBE);
        
        list<Product2> productList= [SELECT Course_ID__c,Description,DisplayUrl,Early_Bird__c,Early_Price__c,ExternalDataSourceId,ExternalId,Family,Full_Price__c,Id,IsActive,Location__c,Name,PriceBook__c,ProductCode,ShortName__c FROM Product2 where Course_ID__c in :setOfOpportunityCourseId ];
        
        
        
        map<String, Product2> mapCourseIdProd = new map<String, Product2>();
        
        for( Product2 objProduct : productList )
        {
            if(mapCourseIdProd.get(objProduct.Course_ID__c) == null) {
                mapCourseIdProd.put(objProduct.Course_ID__c,objProduct);
            }
            
        }   
        //ID oppID= setOfOpportunityIDs[0];
        
        if(triggerNewMap!=null && triggerOldMap!=null && triggerNewMap!=triggerOldMap){
            
            system.debug('setOfOpportunityIDs yeh dekho ye hai'+setOfOpportunityIDs);
            existedOppLineItemList   =[Select id, Product2id, PricebookEntryId,UnitPrice,Quantity, OpportunityId from 
                                       OpportunityLineItem where OpportunityId = :setOfOpportunityIDs ];
            
            for(OpportunityLineItem objOLI : existedOppLineItemList)
            {
                if(mapOppWithOli.get(objOLI.opportunityID)==null){
                    mapOppWithOli.put(objOLI.opportunityID, objOLI);
                }
            }
            
            System.debug('existedOppLineItemList++++++++'+ existedOppLineItemList);
            system.debug('opportunityTriggerNew+'+opportunityTriggerNew);
            for(Opportunity objOpp: opportunityTriggerNew ){
                system.debug('objopp='+objOpp);
                
                
                if(mapOppWithOli.get(objOpp.id)==null){
                    
                    
                    OpportunityLineItem objOpportunityLineItem = new OpportunityLineItem();
                    system.debug('triggerNewMap.get(objOpp.id).Amount!=triggerOldMap.get(objOpp.id).Amount'+triggerNewMap.get(objOpp.id).Amount+ '  '+ triggerOldMap.get(objOpp.id).Amount);
                    if(objOpp.Amount!=null && objOpp.Amount!=0 ){
                        
                        system.debug('objOpp.Amount'+objOpp.Amount);
                        objOpportunityLineItem.UnitPrice = objOpp.Amount;
                    }
                    else if(objOpp.Revenue__c!=null && objOpp.Revenue__c!=0){
                        system.debug('bjOpp.Revenue__c'+objOpp.Revenue__c);
                        objOpportunityLineItem.UnitPrice = objOpp.Revenue__c;
                    }
                    else
                    {
                        objOpportunityLineItem.UnitPrice = 0.0;
                    }
                    system.debug(objOpportunityLineItem.UnitPrice);
                    objOpportunityLineItem.OpportunityID= objOpp.id;
                    system.debug(' objOpportunityLineItem.Opportunity '+ objOpportunityLineItem.Opportunity);
                    system.debug('mapCourseIdPBE _------'+mapCourseIdPBE);               
                        system.debug('(objOpp.Name).id+'+(mapCourseIdPBE.get(objOpp.Name)).id);
                        objOpportunityLineItem.PricebookEntryId = (mapCourseIdPBE.get(objOpp.Name)).id;
                        
                        objOpportunityLineItem.Quantity =1;
                        objOpportunityLineItem.Product2Id=mapCourseIdProd.get(objOpp.Name).id;
                        listOfOpportunitylineItem.add(objOpportunityLineItem);
           
                }
                
            }
            
            if(listOfOpportunitylineItem!=null && listOfOpportunitylineItem.size()>0)
            {
                system.debug('oli insert');
                if(!Test.isRunningTest()){
                    try{
                        insert listOfOpportunitylineItem; 
                    } 
                    catch(Exception ex)
                    {
                        system.debug('Exception '+ ex.getMessage());
                        opportunityTriggerNew[0].addError('please make sure - active product exists in the system with price book Entry');
                        
                    }   
                }
                
            }
            
        }
        
        
    }
}