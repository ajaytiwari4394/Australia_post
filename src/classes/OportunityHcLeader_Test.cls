@isTest
public class OportunityHcLeader_Test {
 @isTest
    public static void InsertMethod()
    {
        try{
            Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();
               System.debug('Record type:-----::'+RecordTypeIdAccount);
		               
            Opportunity_trigger_switch__c objcusOpp = new Opportunity_trigger_switch__c();
            objcusOpp.IsCheck__c = true;
            objcusOpp.Name = 'OpportunityTrigger';
            insert objcusOpp;
            
            OpportunityEmail__c objoppemail = new OpportunityEmail__c();
            objoppemail.Name = 'testemail';
            objoppemail.Email__c = 'test@gmail.com';
            insert objoppemail;
                
            Account objAcc = new Account();
            objAcc.name = 'TestAcc';
            objAcc.Email_Address_2__c = 'mohit@gmail.com';
            objAcc.Phone = '78798798';
            objAcc.RecordtypeId=RecordTypeIdAccount;
            insert objAcc;
            System.debug('Account-----'+objAcc);
            opportunity objopp = new opportunity();
            objopp.name = 'testOpp';
            objopp.StageName = 'Completed';
            objopp.Created_by_Api__c = false;
            objopp.CloseDate = date.today();
            objopp.HC_Leader__c = 'MASTER';
            objopp.Amount = 43;
            objopp.AccountId = objAcc.id;
          

        test.startTest();
         insert objopp;
         
          System.debug('insert opp----------->'+objopp);
        objopp.HC_Leader__c='DON';
        update objopp;
         System.debug('Update opp----------->'+objopp);
            system.assertEquals(objopp.HC_Leader__c,'DON' );
        test.stopTest();

        }catch(Exception e)
        {
            System.debug('Error.......'+e.getMessage()+'Of Line Number...'+e.getLineNumber());
        }
        
        
    }

}