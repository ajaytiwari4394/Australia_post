/**
* @author Vipin - Health Cert
* @date 28/09/2017
*
* @group Accounts
* @group-content ../../ApexDocContent/Products.htm
*
* @description This handler class will check pricebook and 
* will auto create pricebookentry in order to make it searchable from opportunity.
**/

public class ProductTriggerHandler {  
    
    //This method called on after insert of trigger
    public static List<Product2> listOfExistingProductToUpdate = new List<Product2>();
    public void afterInsert(list<Product2> productTriggerNew)
    {
        linkProductToPriceBook(productTriggerNew);        
    }
    
    //This method called on after update of trigger
    public void afterUpdate( Map<ID, Product2> triggerNewMap,Map<ID, Product2> triggerOldMap)
    {
        updateProductToPriceBook(triggerNewMap, triggerOldMap);        
    }
    
    // This method will check pricebook entered by user or coming from API and tag product to given pricebook
    // If pricebook field on product is empty then 
    private void linkProductToPriceBook(list<Product2> productTriggerNew)
    {
      
        // price book entry list that need to insert.
        list<PriceBookEntry> listPriceBookEntry= new list<PriceBookEntry>();
        
        //map of pricebook list in system.
        map<String, PriceBook2> mapPriceBook=new map<String, PriceBook2>();
        //map of pricebook list on product.
        map<String, PriceBook2> mapPriceBookOnProduct=new map<String, PriceBook2>();
        
        //map of pricebook list on product.
        map<String, Product2> mapProduct=new map<String, Product2>();
        //fetch standard price book
       
            for(Pricebook2 pb:[select id, name from pricebook2])
        {
            mapPriceBook.put(pb.name,pb);
        }
        system.debug('mapPriceBook***'+mapPriceBook);
        //set map with pricebook Id.
        for(Product2 prod: productTriggerNew)
        {
            system.debug('prod.Family***'+prod.Family);
            if(prod.Family!=null && mapPriceBook.containsKey(prod.Family)) 
            {
                mapPriceBookOnProduct.put(prod.Id,mapPriceBook.get(prod.Family));
                system.debug('enter here**** if');
            }
            else 
            {
                system.debug('enter here**** else');
                mapPriceBookOnProduct.put(prod.Id,mapPriceBook.get('Standard Price Book'));
            }
            mapProduct.put(prod.Id,prod);
        }
        system.debug('mapPriceBookOnProduct***'+mapPriceBookOnProduct);
        for(String prodId : mapPriceBookOnProduct.KeySet())
        {
            PriceBookEntry pbe=new PriceBookEntry();
            pbe.Product2Id=prodId;
            pbe.Pricebook2Id= mapPriceBookOnProduct.get(prodId).id;
            pbe.UnitPrice=mapProduct.get(prodId).Full_Price__c;
            pbe.Early_Bird__c=mapProduct.get(prodId).Early_Bird__c;
            pbe.Early_Price__c=mapProduct.get(prodId).Early_Price__c;
            pbe.IsActive=true;
            listPriceBookEntry.add(pbe);
        }
        system.debug('++++'+listPriceBookEntry);
        if(listPriceBookEntry!=null  && listPriceBookEntry.size()>0) 
            insert listPriceBookEntry;
        
    }
    
    // created by anjali gairola
    // This method will update price book entry on product updation
    private void updateProductToPriceBook( Map<ID, Product2> triggerNewMap,Map<ID, Product2> triggerOldMap)
    {
        
        // price book entry list that need to insert.
        list<PriceBookEntry> listPriceBookEntry= new list<PriceBookEntry>();
        //fetch standard price book
        Pricebook2 pb=[select id, name from pricebook2 where Name='Standard Price Book' limit 1];
        Set<ID> setOfProductIDs = new set<ID>();
        for(ID objProductID :triggerNewMap.keySet())
        {
            setOfProductIDs.add(objProductID);
        }
        List<PricebookEntry> priceBookEntryList= [Select id, Product2Id,
                                                  Pricebook2Id, UnitPrice, Early_Bird__c, Early_Price__c, IsActive from PriceBookEntry where Product2Id in :setOfProductIDs
                                                  and Pricebook2Id = :pb.id];
        Map<ID, PriceBookEntry> mapProductOnPBE = new Map<ID, PriceBookEntry>();
        for(PricebookEntry pbeObj:priceBookEntryList )
        {
            mapProductOnPBE.put(pbeObj.Product2Id,pbeObj);
        }
        for(ID prodId : triggerNewMap.keySet())
        {
            if(triggerNewMap.get(prodId).Full_Price__c!=triggerOldMap.get(prodId).Full_Price__c||
               triggerNewMap.get(prodId).Early_Bird__c!=triggerOldMap.get(prodId).Early_Bird__c||
               triggerNewMap.get(prodId).Early_Price__c!=triggerOldMap.get(prodId).Early_Price__c||
               triggerNewMap!= triggerOldMap)
            {
                PriceBookEntry pbe=mapProductOnPBE.get(prodId);
                pbe.UnitPrice=triggerNewMap.get(prodId).Full_Price__c;
                pbe.Early_Bird__c=triggerNewMap.get(prodId).Early_Bird__c;
                pbe.Early_Price__c=triggerNewMap.get(prodId).Early_Price__c;
                pbe.IsActive=true;
                listPriceBookEntry.add(pbe);
            }
        }
        if(listPriceBookEntry.size()>0)
        {
            update listPriceBookEntry;
        }
    }
}