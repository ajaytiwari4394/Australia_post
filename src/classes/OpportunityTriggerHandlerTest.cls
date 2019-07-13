@isTest
private class OpportunityTriggerHandlerTest 
{
    static testMethod void testrecord() 
    {
        Opportunity_trigger_switch__c objTrigger = new Opportunity_trigger_switch__c();
        objTrigger.Name ='OpportunityTrigger';
        objTrigger.IsCheck__c =True;
        insert objTrigger;
        
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        
        Account objAccount = commonClassTracker.accountRecord('Todd','Kingsford','868266776','regotestsf@vexill.com','Mr.','Mobile','12355',Date.Today(),'Moddle User','Moodle Pass','Doctor','Doctor','Yes');
        objAccount.RecordTypeId = accRecordTypeId ;
        insert objAccount;
        
       // List<Opportunity> listOfOpportunity = new list<Opportunity>();
        
        Product2 objProd= commonClassTracker.productRecord('QA','QA','Test code',1000,'Test Description','None',true);
         insert objProd;
        
        PriceBookEntry objPBE= commonClassTracker.addProductToPriceBook(objProd);
        insert objPBE;
        
        Opportunity objOpportunity = commonClassTracker.opportunityRecord('QA',true,'Paid',Date.Today(),10000,'EnrolmentCompleted','ACDER','CPD Points Uploaded','test','ACRRM Newsletter','ACDER','Cheque','Free of Charge','Facebook','Yes','Test UTM');
        objOpportunity.AccountId = objAccount.id;
        insert objOpportunity;
        
        objOpportunity.Revenue__c=5;
        update objOpportunity;
       
       
    }
    
    
    
    
    
     static testMethod void testrecord1() 
    {
        Opportunity_trigger_switch__c objTrigger = new Opportunity_trigger_switch__c();
        objTrigger.Name ='OpportunityTrigger';
        objTrigger.IsCheck__c =True;
        insert objTrigger;
        
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        
        Account objAccount = commonClassTracker.accountRecord('Todd','Kingsford','868266776','regotestsf@vexill.com','Mr.','Mobile','12355',Date.Today(),'Moddle User','Moodle Pass','Doctor','Doctor','Yes');
        objAccount.RecordTypeId = accRecordTypeId ;
        insert objAccount;
        
       // List<Opportunity> listOfOpportunity = new list<Opportunity>();
        
        Product2 objProd= commonClassTracker.productRecord('QA','QA','Test code',1000,'Test Description','None',true);
         insert objProd;
        
        PriceBookEntry objPBE= commonClassTracker.addProductToPriceBook(objProd);
        insert objPBE;
        
        Opportunity objOpportunity = commonClassTracker.opportunityRecord('QA',false,'Paid',Date.Today(),10000,'EnrolmentCompleted','ACDER','CPD Points Uploaded','test','ACRRM Newsletter','ACDER','Cheque','Free of Charge','Facebook','Yes','Test UTM');
        objOpportunity.AccountId = objAccount.id;
        objOpportunity.Created_by_Api__c=false;
        
        insert objOpportunity;
        
        objOpportunity.Revenue__c=5;
        update objOpportunity;
       
        
    }
}