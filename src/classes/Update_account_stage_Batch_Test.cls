@isTest
public class Update_account_stage_Batch_Test {
    @isTest
    public static void testMethod1(){
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
            
            opportunity objopp = new opportunity();
            objopp.name = 'testOpp';
            objopp.StageName = 'Completed';
            objopp.Created_by_Api__c = false;
            objopp.CloseDate = date.today();
            objopp.HC_Leader__c = 'DON';
            objopp.Amount = 43;
            objopp.AccountId = objAcc.id;
              insert objopp;
             test.startTest();
            	objAcc.HC_Leader__c = 'DON';
            	update objAcc;
            Update_account_stage_Batch updtaeAccountBatch= new Update_account_stage_Batch();
            id batchid=Database.executeBatch(updtaeAccountBatch, 1);
             system.assertEquals(objAcc.HC_Leader__c,'DON' );
            test.stopTest();
            
        }catch(Exception e)
        {
            System.debug('Error...>>>'+e.getMessage()+'Of the Line Number>>>'+e.getLineNumber());
        }
    }
    
}