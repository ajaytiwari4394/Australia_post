@isTest(seealldata=true)
private class AccountWebServiceTest 
{
    static testMethod void testPost() 
    {
        Json_Key_Object_Field_mapping__c objJsonmapping = commonClassTracker.objJsonKeyObjectfieldMappingRecord('FIRST_NAME','Text','Account','FirstName');
        //insert objJsonmapping;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        String jsonbody ='{"Account": {"FIRST_NAME": "Todd12","LAST_NAME": "Kingsford","PHONE_1": "868266776","E-mail_Address": "test1@sf.com","MRMRS" : "Mr.","PHONE_1_DESCRIPTION" : "Mobile","WEB-ID" : "12355","Registration Date" : "2017-10-25","MoodleUser" : "Moddle User","MoodlePass" : "Moodle Pass","Profession" : "Doctor","Category" : "Doctor","Sync With HubSpot" : "Yes","Company Name" :"Test"}}';
        
        req.requestURI = '/services/apexrest/AccountService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        Account objAccount = commonClassTracker.accountRecord('Todd','Kingsford','868266776','regotestsf@vexill.com','Mr.','Mobile','12355',Date.Today(),'Moddle User','Moodle Pass','Doctor','Doctor','Yes');
        
        
        //
        AccountWebService.upsertAccount();
    }
    
    
    static testMethod void testPost1() 
    {
        Json_Key_Object_Field_mapping__c objJsonmapping = commonClassTracker.objJsonKeyObjectfieldMappingRecord('FIRST_NAME','Text','Account','FirstName');
        //insert objJsonmapping;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        String jsonbody ='{"Account": {"FIRST_NAME": "Todd12","LAST_NAME": "Kingsford","PHONE_1": "868266776","E-mail_Address": "test1@sf.com","MRMRS" : "Mr.","PHONE_1_DESCRIPTION" : "Mobile","WEB-ID" : "1235","Registration Date" : "2017-10-25","MoodleUser" : "Moddle User","MoodlePass" : "Moodle Pass","Profession" : "Doctor","Category" : "Doctor","Sync With HubSpot" : "Yes","Company Name" :"Test"}}';
        
        req.requestURI = '/services/apexrest/AccountService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        Account objAccount = commonClassTracker.accountRecord('Todd','Kingsford','868266776','regotestsf@vexill.com','Mr.','Mobile','12355',Date.Today(),'Moddle User','Moodle Pass','Doctor','Doctor','Yes');
        
        
        //
        AccountWebService.upsertAccount();
    }
}