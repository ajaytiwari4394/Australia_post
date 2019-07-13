@isTest(seeAllData=true)
private class insertAccountOrOpportunityTest 
{
    static testMethod void insertAccountAndOpportunityForDuplicate() 
    {
        
        Id pricebookId = Test.getStandardPricebookId();
        system.debug('pricebookId&&&'+pricebookId);
        
        Product2 objProdforQA= new Product2(Name='QA Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='QA',Full_Price__c =10);//Family = 'Professional Certificate of Skin Cancer Medicine',
        insert objProdforQA;
        
        Product2 objProdforUAT= new Product2(Name='UAT Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='UAT',Full_Price__c =20);
        insert objProdforUAT;
        
        Account objAccount = commonClassTracker.accountRecord('Todd','Kingsford','868266776','regotestsf@vexill.com','Mr.','Mobile','12355',Date.Today(),'Moddle User','Moodle Pass','Doctor','Doctor','Yes');
        
        List<Opportunity> listOfOpportunity = new list<Opportunity>();
        
        Opportunity objOpportunity = commonClassTracker.opportunityRecord('QA',true,'Paid',Date.Today(),10000,'EnrolmentCompleted','ACDER','CPD Points Uploaded','test','ACRRM Newsletter','ACDER','American Express','Free of Charge','Facebook','Yes','Test UTM');
        listOfOpportunity.add(objOpportunity);
        
        Opportunity objOpportunity2 = commonClassTracker.opportunityRecord('UAT',true,'Paid',Date.Today(),10000,'EnrolmentCompleted','ACDER','CPD Points Uploaded','test','ACRRM Newsletter','ACDER','American Express','Free of Charge','Facebook','Yes','Test UTM');
        listOfOpportunity.add(objOpportunity2);
        
        insertAccountOrOpportunity.parseJson(objAccount,listOfOpportunity);
        
    }
    static testMethod void insertAccountAndOpportunity() 
    {
        
        Id pricebookId = Test.getStandardPricebookId();
        system.debug('pricebookId&&&'+pricebookId);
        
        Product2 objProdforQA= new Product2(Name='QA Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='QA',Full_Price__c =10);//Family = 'Professional Certificate of Skin Cancer Medicine',
        insert objProdforQA;
        
        Product2 objProdforUAT= new Product2(Name='UAT Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='UAT',Full_Price__c =20);
        insert objProdforUAT;
        
        Account objAccount = commonClassTracker.accountRecord('Test','Account','9212155244','regotestsf@vexill.com','Mr.','Mobile','12355',Date.Today(),'Moddle User','Moodle Pass','Doctor','Doctor','Yes');
        
        List<Opportunity> listOfOpportunity = new list<Opportunity>();
        
        Opportunity objOpportunity = commonClassTracker.opportunityRecord('QA',true,'Paid',Date.Today(),10000,'EnrolmentCompleted','ACDER','CPD Points Uploaded','test','ACRRM Newsletter','ACDER','American Express','Free of Charge','Facebook','Yes','Test UTM');
        listOfOpportunity.add(objOpportunity);
        
        Opportunity objOpportunity2 = commonClassTracker.opportunityRecord('UAT',true,'Paid',Date.Today(),10000,'EnrolmentCompleted','ACDER','CPD Points Uploaded','test','ACRRM Newsletter','ACDER','American Express','Free of Charge','Facebook','Yes','Test UTM');
        listOfOpportunity.add(objOpportunity2);
        
        insertAccountOrOpportunity.parseJson(objAccount,listOfOpportunity);
        
    }
}