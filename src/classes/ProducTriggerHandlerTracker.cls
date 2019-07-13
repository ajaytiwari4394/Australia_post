@isTest(seealldata=true)
public class ProducTriggerHandlerTracker {

    
    static testMethod void testProductUpdation() 
    {
 Product2 objProdforUAT1= new Product2(Name='UAT Test Product',Family = 'None',isActive=true,Course_ID__c ='UAT',Full_Price__c =20);
        insert objProdforUAT1;
           Pricebook2 spb=[select id, name from pricebook2 where Name='Standard Price Book'];

        objProdforUAT1.Full_Price__c=30;
        update objProdforUAT1;
    }
}