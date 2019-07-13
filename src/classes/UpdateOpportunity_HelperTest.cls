@isTest
public class UpdateOpportunity_HelperTest {
    
    @isTest
    public static void updateOpportunity(){
        try {
                       
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
            insert objAcc;
            
            opportunity objopp = new opportunity();
            objopp.name = 'testOpp';
            objopp.StageName = 'Completed';
            objopp.Created_by_Api__c = false;
            objopp.CloseDate = date.today();
            objopp.HC_Leader__c = 'BOYD';
            objopp.Amount = 43;
            objopp.AccountId = objAcc.id;
            insert objopp;
          
            Test.startTest();                  
            objopp.HC_Leader__c = 'LUCY';
            update objopp;
            Test.startTest();
            
        }
        catch(Exception Ex){
            
            System.debug('Error>>>>>>>>>>>'+Ex.getMessage()+'At line number'+Ex.getLineNumber());
        }
    }
}