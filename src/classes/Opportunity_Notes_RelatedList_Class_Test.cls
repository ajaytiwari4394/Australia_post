@isTest  
public class Opportunity_Notes_RelatedList_Class_Test {
    static testMethod void validateOpportunity_Notes_RelatedList_Class() {

        Opportunity_trigger_switch__c objTrigger = new Opportunity_trigger_switch__c();
        objTrigger.Name ='OpportunityTrigger';
        objTrigger.IsCheck__c =True;
        insert objTrigger;
        
     /*   Opportunity opp = New Opportunity();
        opp.Name = 'test Opportunity';
        opp.StageName = 'Completed';
        opp.Probability = 5;
        insert opp; */
        
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        
        Account objAccount = commonClassTracker.accountRecord('Todd','Kingsford','868266776','regotestsf@vexill.com','Mr.','Mobile','12355',Date.Today(),'Moddle User','Moodle Pass','Doctor','Doctor','Yes');
        objAccount.RecordTypeId = accRecordTypeId ;
        insert objAccount;
        
        Opportunity objOpportunity = commonClassTracker.opportunityRecord('QA',false,'Paid',Date.Today(),10000,'EnrolmentCompleted','ACDER','CPD Points Uploaded','test','ACRRM Newsletter','ACDER','American Express','Free of Charge','Facebook','Yes','Test UTM');
        objOpportunity.AccountId = objAccount.id;
        objOpportunity.Payment_Method__c = 'Credit Card';
        insert objOpportunity;

        Notes__c no = New Notes__c();
        no.opportunity__c = objOpportunity.Id;
        no.Body__c = 'This should be a big paragraph. This should be a big paragraph. This should be a big paragraph. This should be a big paragraph';
        insert no;
        
     /*   Opportunity opp1 = New Opportunity();
        opp1.Name = 'test Opportunity';
        opp1.StageName = 'Completed';
        opp1.Probability = 5;
        insert opp1; */
        
        Notes__c no1 = New Notes__c();
        no1.opportunity__c = objOpportunity.Id;
        no1.Body__c = 'This should be a big paragraph. This should be a big paragraph. This should be a big paragraph. This should be a big paragraph';
        insert no1;
        
        Opportunity objOpportunity1 = commonClassTracker.opportunityRecord('QA',false,'Paid',Date.Today(),10000,'EnrolmentCompleted','ACDER','CPD Points Uploaded','test','ACRRM Newsletter','ACDER','American Express','Free of Charge','Facebook','Yes','Test UTM');
        objOpportunity1.AccountId = objAccount.id;
        objOpportunity1.Payment_Method__c = 'Credit Card';
        try
        {
            insert objOpportunity1;
        }
        catch(exception ex)
        {
            system.debug('ex==========='+ex);
        }
        
        
        //delete no;
        
        Apexpages.StandardController sc = new Apexpages.StandardController(objOpportunity);

        Opportunity_Notes_RelatedList_Class nrlc = New Opportunity_Notes_RelatedList_Class(sc); 
        nrlc.newnotes();
        nrlc.editnotes();
        //nrlc.deletenotes();
        
        Apexpages.StandardController sc1 = new Apexpages.StandardController(objOpportunity);

        Opportunity_Notes_RelatedList_Class nrlc1 = New Opportunity_Notes_RelatedList_Class(sc1); 
        
        PageReference pageRef = Page.Opportunity_Notes_RelatedList;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('notes__cId',No1.id);
        nrlc1.deletenotes(); 
    }
}