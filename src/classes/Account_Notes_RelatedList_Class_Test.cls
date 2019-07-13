@isTest  
public class Account_Notes_RelatedList_Class_Test {
    static testMethod void validateAccount_Notes_RelatedList_Class() {
        Account acc = New Account();
        acc.Name = 'test Account';
        acc.Phone = '9848012345';
        insert acc;
        
        Notes__c no = New Notes__c();
        no.Account__c = acc.Id;
        no.Body__c = 'This should be a big paragraph. This should be a big paragraph. This should be a big paragraph. This should be a big paragraph';
        insert no;
        
         Account acc1 = New Account();
        acc1.Name = 'test Account1';
        acc1.Phone = '9848012346';
        insert acc1;
        
        Notes__c no1 = New Notes__c();
        no1.Account__c = acc1.Id;
        no1.Body__c = 'This should be a big paragraph. This should be a big paragraph. This should be a big paragraph. This should be a big paragraph';
        insert no1;
        
        //delete no;
        
        Apexpages.StandardController sc = new Apexpages.StandardController(acc);

        Account_Notes_RelatedList_Class nrlc = New Account_Notes_RelatedList_Class(sc); 
        nrlc.newnotes();
        nrlc.editnotes();
        //nrlc.deletenotes();
        
        Apexpages.StandardController sc1 = new Apexpages.StandardController(acc1);

        Account_Notes_RelatedList_Class nrlc1 = New Account_Notes_RelatedList_Class(sc1); 
        
        PageReference pageRef = Page.Account_Notes_RelatedList;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('notes__cId',No1.id);
        nrlc1.deletenotes();
        
        
        
        
    }
}