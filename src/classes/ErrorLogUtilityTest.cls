/**
* @author Lav Singh
* @date 24/10/2017
*
* @group Error
* @group-content ../../ApexDocContent/Error.htm
*
* @description Test class for ErrorLogUtility class
**/
@isTest(seeAllData = false)
public class ErrorLogUtilityTest {
    /**
    * @description below test all  method
    **/
    @isTest 
    static void testMethodException() 
    {
        // start Test
           test.startTest();
           List<Account> lstOfAccount =new list<Account>();
           Account objAcc = new Account();
           objAcc.Name ='';
           lstOfAccount.add(objAcc);
           list<Database.UpsertResult> LstDatabaseUpsertOptyLIresult = Database.upsert(lstOfAccount, false);
           for(Database.UpsertResult objOpptyLIUpsertResult : LstDatabaseUpsertOptyLIresult) 
           {
                if(objOpptyLIUpsertResult.isSuccess()) 
                {
                    
                }
                else 
                {
                    for(Database.Error err1 : objOpptyLIUpsertResult.getErrors()) 
                    {
                        ErrorLogUtility.logError('Test Class - ErrorLogUtilityTest','Test Method - testMethodException',err1,'','','','','');
                        ErrorLogUtility.logDebug('Test Class - ErrorLogUtilityTest','Test Method - testMethodException','Debug Message','','','','');
                        ErrorLogUtility.logInfo('Test Class - ErrorLogUtilityTest','Test Method - testMethodException','Log Message','','','','');
                        ErrorLogUtility.logWarn('Test Class - ErrorLogUtilityTest','Test Method - testMethodException','Log Message','','','','');
                        ErrorLogUtility.commitLog();
                        Error_Log__c errLog = [SELECT id, Source__c,Source_Function__c FROM Error_Log__c WHERE Source_Function__c = 'Test Method - testMethodException' LIMIT 1];
                    }
                    
                                                                
                }
           }

        test.stopTest();
    }
}