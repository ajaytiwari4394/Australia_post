@isTest(seealldata=true)
private class upsertAccountWithOpportunitiesTest 
{
    static testMethod void testPost() 
    {
        List<Json_Key_Object_Field_mapping__c> lstJsonKeyObject = new List<Json_Key_Object_Field_mapping__c>();
        Json_Key_Object_Field_mapping__c objJsonmapping = commonClassTracker.objJsonKeyObjectfieldMappingRecord('FIRST_NAME','Text','Account','FirstName');
        lstJsonKeyObject.add(objJsonmapping);
        
        Json_Key_Object_Field_mapping__c objJsonmapping1 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('MRMRS','Text','Account','Salutation');
        lstJsonKeyObject.add(objJsonmapping1);
        
        Json_Key_Object_Field_mapping__c objJsonmapping2 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('E-mail_Address','Text','Account','PersonEmail');
        lstJsonKeyObject.add(objJsonmapping2);
        
        Json_Key_Object_Field_mapping__c objJsonmapping3 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('PHONE_1','Text','Account','Phone');
        lstJsonKeyObject.add(objJsonmapping3);
        
        Json_Key_Object_Field_mapping__c objJsonmapping4 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('PHONE_1_DESCRIPTION','Text','Account','Phone_Type__c');
        lstJsonKeyObject.add(objJsonmapping4);
        
        Json_Key_Object_Field_mapping__c objJsonmapping5 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('WEB-ID','Text','Account','WEB_ID__c');
        lstJsonKeyObject.add(objJsonmapping5);
        
        Json_Key_Object_Field_mapping__c objJsonmapping6 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Registration Date','Date','Account','Registration_Date__c');
        lstJsonKeyObject.add(objJsonmapping6);
        
        Json_Key_Object_Field_mapping__c objJsonmapping7 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('MoodleUser','Text','Account','MoodleUser__c');
        lstJsonKeyObject.add(objJsonmapping7);
        
        Json_Key_Object_Field_mapping__c objJsonmapping8 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('MoodlePass','Text','Account','MoodlePass__c');
        lstJsonKeyObject.add(objJsonmapping8);
        
        Json_Key_Object_Field_mapping__c objJsonmapping9 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Profession','Text','Account','Profession__c');
        lstJsonKeyObject.add(objJsonmapping9);
        
        Json_Key_Object_Field_mapping__c objJsonmapping10 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Category','Text','Account','Category__c');
        lstJsonKeyObject.add(objJsonmapping10);
        
        Json_Key_Object_Field_mapping__c objJsonmapping11 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Sync With HubSpot','Text','Account','Sync_With_HubSpot__c');
        lstJsonKeyObject.add(objJsonmapping11);
        
        Json_Key_Object_Field_mapping__c objJsonmapping12 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ACC_ID','Id','Account','Id');
        lstJsonKeyObject.add(objJsonmapping12);
        
        Json_Key_Object_Field_mapping__c objJsonmapping13 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('LAST_NAME','Text','Account','LastName');
        lstJsonKeyObject.add(objJsonmapping13);
        
        Json_Key_Object_Field_mapping__c objJsonmapping14 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('OPPSTATUS','Text','Opportunity','OppStatus__c');
        lstJsonKeyObject.add(objJsonmapping14);
        
        Json_Key_Object_Field_mapping__c objJsonmapping15 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Course Selected','Text','Opportunity','Courses_Interested_In__c');
        lstJsonKeyObject.add(objJsonmapping15);
        
        Json_Key_Object_Field_mapping__c objJsonmapping16 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Workshop Selected','Text','Opportunity','Conf_Workshop_1__c');
        lstJsonKeyObject.add(objJsonmapping16);
        
        Json_Key_Object_Field_mapping__c objJsonmapping17 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('WorkbookFormat','Text','Opportunity','WorkbookFormat__c');
        lstJsonKeyObject.add(objJsonmapping17);
        
        Json_Key_Object_Field_mapping__c objJsonmapping18 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('REVENUE','Number','Opportunity','Revenue__c');
        lstJsonKeyObject.add(objJsonmapping18);
        
        Json_Key_Object_Field_mapping__c objJsonmapping19 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Source of Enquiry or Registration','Text','Opportunity','Source_of_Enquiry_or_Registration__c');
        lstJsonKeyObject.add(objJsonmapping19);
        
        Json_Key_Object_Field_mapping__c objJsonmapping20 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Course Code','Text','Opportunity','Course_Code__c');
        lstJsonKeyObject.add(objJsonmapping20);
        
        Json_Key_Object_Field_mapping__c objJsonmapping21 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Payment Method','Text','Opportunity','Payment_Method__c');
        lstJsonKeyObject.add(objJsonmapping21);
        
        Json_Key_Object_Field_mapping__c objJsonmapping22 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Payment Status','Text','Opportunity','Payment_Status__c');
        lstJsonKeyObject.add(objJsonmapping22);
        
        Json_Key_Object_Field_mapping__c objJsonmapping23 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Opportunity Source','Text','Opportunity','LeadSource');
        lstJsonKeyObject.add(objJsonmapping23);
        
        Json_Key_Object_Field_mapping__c objJsonmapping24 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('PartnerMarketing','Text','Opportunity','PartnerMarketing__c');
        lstJsonKeyObject.add(objJsonmapping24);
        
        Json_Key_Object_Field_mapping__c objJsonmapping25 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Opportunity UTM','Text','Opportunity','Opportunity_UTM__c');
        lstJsonKeyObject.add(objJsonmapping25);
        
        Json_Key_Object_Field_mapping__c objJsonmapping26 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Course ID','Text','Opportunity','Name');
        lstJsonKeyObject.add(objJsonmapping26);
        
        Json_Key_Object_Field_mapping__c objJsonmapping27 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('OPP_ID','Id','Opportunity','Id');
        lstJsonKeyObject.add(objJsonmapping27);
        
        Json_Key_Object_Field_mapping__c objJsonmapping28 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Opp_Stage','Text','Opportunity','StageName');
        lstJsonKeyObject.add(objJsonmapping28);
        
        Json_Key_Object_Field_mapping__c objJsonmapping29 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('OPP_CloseDate','Date','Opportunity','CloseDate');
        lstJsonKeyObject.add(objJsonmapping29);
        
        //insert lstJsonKeyObject;
         Id pricebookId = Test.getStandardPricebookId();
        system.debug('pricebookId&&&'+pricebookId);
        
        Product2 objProdforQA= new Product2(Name='QA Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='QA',Full_Price__c =10);//Family = 'Professional Certificate of Skin Cancer Medicine',
        insert objProdforQA;
        
        update objProdforQA;
        
        Product2 objProdforUAT= new Product2(Name='UAT Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='UAT',Full_Price__c =20);
        insert objProdforUAT;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        String jsonbody ='{"Account": {"FIRST_NAME": "Todd","LAST_NAME": "Kingsford","PHONE_1": "868266776","E-mail_Address": "regotestsf@vexill.com","MRMRS" : "Mr.","PHONE_1_DESCRIPTION" : "Mobile","WEB-ID" : "12355","Registration Date" : "2017-10-25","MoodleUser" : "Moddle User","MoodlePass" : "Moodle Pass","Profession" : "Doctor","Category" : "Doctor","Sync With HubSpot" : "Yes"},"Opportunities": [{"Course ID": "QA","OPP_CloseDate": "2017-10-04","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"},{"Course ID": "UAT","OPP_CloseDate": "2017-10-03","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM","Test":"1234"}]}';
        
        req.requestURI = '/services/apexrest/OpportunityService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;

        upsertAccountWithOpportunities.upsertAccount();
        CommonClass.getSobjectFieldMap('Account');
        CommonClass.IsNullOrEmptyString('');
        CommonClass.GetRecordTypeId('Account','');
    }
    static testMethod void testPost1() 
    {
        
        Id pricebookId = Test.getStandardPricebookId();
        system.debug('pricebookId&&&'+pricebookId);
        
        Product2 objProdforQA= new Product2(Name='QA Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='QA',Full_Price__c =10);//Family = 'Professional Certificate of Skin Cancer Medicine',
        insert objProdforQA;
        
        Product2 objProdforUAT= new Product2(Name='UAT Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='UAT',Full_Price__c =20);
        insert objProdforUAT;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        String jsonbody ='{"Account": {"FIRST_NAME": "Test","LAST_NAME": "Account","PHONE_1": "8774662223","E-mail_Address": "123121stsf@vexill.com","MRMRS" : "Mr.","PHONE_1_DESCRIPTION" : "Mobile","WEB-ID" : "12355","Registration Date" : "2017-10-25","MoodleUser" : "Moddle User","MoodlePass" : "Moodle Pass","Profession" : "Doctor","Category" : "Doctor","Sync With HubSpot" : "Yes"},"Opportunities": [{"Course ID": "QA","OPP_CloseDate": "2017-10-04","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"},{"Course ID": "UAT","OPP_CloseDate": "2017-10-03","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"}]}';
        
        req.requestURI = '/services/apexrest/OpportunityService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;

        upsertAccountWithOpportunities.upsertAccount();
    }
    static testMethod void testPost2() 
    {
        
        Id pricebookId = Test.getStandardPricebookId();
        system.debug('pricebookId&&&'+pricebookId);
        
        Product2 objProdforQA= new Product2(Name='QA Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='QA',Full_Price__c =10);//Family = 'Professional Certificate of Skin Cancer Medicine',
        insert objProdforQA;
        
        Product2 objProdforUAT= new Product2(Name='UAT Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='UAT',Full_Price__c =20);
        insert objProdforUAT;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        String jsonbody ='{"Account": {"FIRST_NAME": "Test","LAST_NAME": "Account","PHONE_1": "8774662223","E-mail_Address": "123121stsf@vexill.com","MRMRS" : "Mr.","PHONE_1_DESCRIPTION" : "Mobile","WEB-ID" : "12355","Registration Date" : "2017-10-25","MoodleUser" : "Moddle User","MoodlePass" : "Moodle Pass","Profession" : "Doctor","Category" : "Doctor","Sync With HubSpot" : "Yes"},"Opportunities": [{"Course ID": "Q1A","OPP_CloseDate": "2017-10-04","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"},{"Course ID": "U1AT","OPP_CloseDate": "2017-10-03","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"}]}';
        
        req.requestURI = '/services/apexrest/OpportunityService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;

        upsertAccountWithOpportunities.upsertAccount();
    }
    static testMethod void testPost3() 
    {
        
        Id pricebookId = Test.getStandardPricebookId();
        system.debug('pricebookId&&&'+pricebookId);
        
        Product2 objProdforQA= new Product2(Name='QA Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='QA',Full_Price__c =10);//Family = 'Professional Certificate of Skin Cancer Medicine',
        insert objProdforQA;
        
        Product2 objProdforUAT= new Product2(Name='UAT Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='UAT',Full_Price__c =20);
        insert objProdforUAT;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        String jsonbody ='{"Account": {"FIRST_NAME": "Test","LAST_NAME": "Account","PHONE_1": "8774662223","E-mail_Address": "123121stsf@vexill.com","MRMRS" : "Mr.","PHONE_1_DESCRIPTION" : "Mobile","WEB-ID" : "12355","Registration Date" : "2017-10-25","MoodleUser" : "Moddle User","MoodlePass" : "Moodle Pass","Profession" : "Doctor","Category" : "Doctor","Sync With HubSpot" : "Yes"},"Opportunities": [{"Course ID": "QA","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"}]}';
        
        req.requestURI = '/services/apexrest/OpportunityService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;

        upsertAccountWithOpportunities.upsertAccount();
    }
    static testMethod void testPost4() 
    {
        
        Id pricebookId = Test.getStandardPricebookId();
        system.debug('pricebookId&&&'+pricebookId);
        
        Product2 objProdforQA= new Product2(Name='QA Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='QA',Full_Price__c =10);//Family = 'Professional Certificate of Skin Cancer Medicine',
        insert objProdforQA;
        
        Product2 objProdforUAT= new Product2(Name='UAT Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='UAT',Full_Price__c =20);
        insert objProdforUAT;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        String jsonbody ='{"Account": {"FIRST_NAME": "Test","LAST_NAME": "Account","PHONE_1": "8774662223","E-mail_Address": "123121stsf@vexill.com","MRMRS" : "Mr.","PHONE_1_DESCRIPTION" : "Mobile","WEB-ID" : "12355","Registration Date" : "2017-10-25","MoodleUser" : "Moddle User","MoodlePass" : "Moodle Pass","Profession" : "Doctor","Category" : "Doctor","Sync With HubSpot" : "Yes"},"Opportunities": [{"Course ID": "Q11A","OPP_CloseDate": "2017-10-04","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"},{"Course ID": "UAT","OPP_CloseDate": "2017-10-03","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"}]}';
        
        req.requestURI = '/services/apexrest/OpportunityService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;

        upsertAccountWithOpportunities.upsertAccount();
    }
    static testMethod void testPost5() 
    {
        Id pricebookId = Test.getStandardPricebookId();
        system.debug('pricebookId&&&'+pricebookId);
        
        Product2 objProdforQA= new Product2(Name='QA Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='QA',Full_Price__c =10);//Family = 'Professional Certificate of Skin Cancer Medicine',
        insert objProdforQA;
        
        Product2 objProdforUAT= new Product2(Name='UAT Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='UAT',Full_Price__c =20);
        insert objProdforUAT;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        String jsonbody ='{"Account": {"FIRST_NAME": "Todd","LAST_NAME": "Kingsford","PHONE_1": "868266776","E-mail_Address": "regotestsf@vexill.com","MRMRS" : "Mr.","PHONE_1_DESCRIPTION" : "Mobile","WEB-ID" : "12355","Registration Date" : "2017-10-25","MoodleUser" : "Moddle User","MoodlePass" : "Moodle Pass","Profession" : "Doctor","Category" : "Doctor","Sync With HubSpot" : "Yes"},"Opportunities": [{"Course ID": "Q11A","OPP_CloseDate": "2017-10-04","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"},{"Course ID": "UAT","OPP_CloseDate": "2017-10-03","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"}]}';
        
        req.requestURI = '/services/apexrest/OpportunityService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;

        upsertAccountWithOpportunities.upsertAccount();
    }
    static testMethod void testPost6() 
    {
        Id pricebookId = Test.getStandardPricebookId();
        system.debug('pricebookId&&&'+pricebookId);
        
        Product2 objProdforQA= new Product2(Name='QA Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='QA',Full_Price__c =10);//Family = 'Professional Certificate of Skin Cancer Medicine',
        insert objProdforQA;
        
        Product2 objProdforUAT= new Product2(Name='UAT Test Product',Family = 'Professional Certificate of Skin Cancer Medicine',isActive=true,Course_ID__c ='UAT',Full_Price__c =20);
        insert objProdforUAT;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        String jsonbody ='{"Account": {"FIRST_NAME": "Todd","LAST_NAME": "Kingsford","PHONE_1": "868266776","E-mail_Address": "regotestsf@vexill.com","MRMRS" : "Mr.","PHONE_1_DESCRIPTION" : "Mobile","WEB-ID" : "12355","Registration Date" : "2017-10-25","MoodleUser" : "Moddle User","MoodlePass" : "Moodle Pass","Profession" : "Doctor","Category" : "Doctor","Sync With HubSpot" : "Yes"},"Opportunities": [{"Course ID": "U111AT","OPP_Revenue": "10000","OPPSTATUS": "EnrolmentCompleted","Course Selected": "ACDER","Workshop Selected": "CPD Points Uploaded","WorkbookFormat": "test","Source of Enquiry or Registration": "ACRRM Newsletter","Course Code": "ACDER","Payment Method" : "American Express","Payment Status" : "Free of Charge","Opportunity Source" : "Facebook","Opportunity UTM" : "Test UTM"}]}';
        
        req.requestURI = '/services/apexrest/OpportunityService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;

        upsertAccountWithOpportunities.upsertAccount();
    }
}