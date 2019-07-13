@isTest(seealldata=true)
public class ProductWebServiceTest {
    
    static testMethod void testMultipleResp() 
    {
        
        List<Json_Key_Object_Field_mapping__c> lstJsonKeyObject = new List<Json_Key_Object_Field_mapping__c>();
        Json_Key_Object_Field_mapping__c objJsonmapping = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Active','Checkbox','Product2','IsActive');
        lstJsonKeyObject.add(objJsonmapping);
        
        Json_Key_Object_Field_mapping__c objJsonmapping1 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('DisplayUrl','Text','Product2','DisplayUrl');
        lstJsonKeyObject.add(objJsonmapping1);
        
        Json_Key_Object_Field_mapping__c objJsonmapping2 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductCode','Text','Product2','ProductCode');
        lstJsonKeyObject.add(objJsonmapping2);
        
        Json_Key_Object_Field_mapping__c objJsonmapping3 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductFamily','Text','Product2','Family');
        lstJsonKeyObject.add(objJsonmapping3);
        
        Json_Key_Object_Field_mapping__c objJsonmapping4 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Full_Price','Currency','Product2','Full_Price__c');
        lstJsonKeyObject.add(objJsonmapping4);
        
        Json_Key_Object_Field_mapping__c objJsonmapping5 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Course_ID','Text','Product2','Course_ID__c');
        lstJsonKeyObject.add(objJsonmapping5);
        
        Json_Key_Object_Field_mapping__c objJsonmapping6 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Name','Text','Product2','Name');
        lstJsonKeyObject.add(objJsonmapping6);
        
        Json_Key_Object_Field_mapping__c objJsonmapping7 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Price','Currency','Product2','Early_Price__c');
        lstJsonKeyObject.add(objJsonmapping7);
        
        Json_Key_Object_Field_mapping__c objJsonmapping8 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Bird_Date','Date','Product2','Early_Bird_Date__c');
        lstJsonKeyObject.add(objJsonmapping8);
        
        Json_Key_Object_Field_mapping__c objJsonmapping9 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Location','Text','Product2','Location__c');
        lstJsonKeyObject.add(objJsonmapping9);
        
        Json_Key_Object_Field_mapping__c objJsonmapping10 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ShortName','Text','Product2','ShortName__c');
        lstJsonKeyObject.add(objJsonmapping10);
        
        Json_Key_Object_Field_mapping__c objJsonmapping11 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Description','Text','Product2','Description');
        lstJsonKeyObject.add(objJsonmapping11);
        
  //insert objJsonmapping;

        //do request
         Product2 objProd= new Product2();
        objProd.Course_ID__c='1402-SC-MEL-ADERM1111';
        objProd.Family='None';
        objProd.Full_Price__c=1200;
        objProd.IsActive=true;
        objProd.Name='Test';
        objProd.Description='Test';
        insert objProd;
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        String jsonbody ='{"Products": [{"Name":"Test Prod","Active":"true","Course_ID":"1402-SC-MEL-ADERM1111","Description":"testing product","ProductFamily":"None"},{"Name":"Test Prod","Active":"true","Course_ID":"1511-SC-PER-SCSUG12","Description":"testing product","Full_Price":"800","ProductFamily":"None"}]}';
        req.requestURI = '/services/apexrest/ProductService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        ProductWebService.upsertProduct();
    }
    
    
     static testMethod void testMultipleResp2() 
    {
         List<Json_Key_Object_Field_mapping__c> lstJsonKeyObject = new List<Json_Key_Object_Field_mapping__c>();
        Json_Key_Object_Field_mapping__c objJsonmapping = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Active','Checkbox','Product2','IsActive');
        lstJsonKeyObject.add(objJsonmapping);
        
        Json_Key_Object_Field_mapping__c objJsonmapping1 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('DisplayUrl','Text','Product2','DisplayUrl');
        lstJsonKeyObject.add(objJsonmapping1);
        
        Json_Key_Object_Field_mapping__c objJsonmapping2 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductCode','Text','Product2','ProductCode');
        lstJsonKeyObject.add(objJsonmapping2);
        
        Json_Key_Object_Field_mapping__c objJsonmapping3 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductFamily','Text','Product2','Family');
        lstJsonKeyObject.add(objJsonmapping3);
        
        Json_Key_Object_Field_mapping__c objJsonmapping4 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Full_Price','Currency','Product2','Full_Price__c');
        lstJsonKeyObject.add(objJsonmapping4);
        
        Json_Key_Object_Field_mapping__c objJsonmapping5 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Course_ID','Text','Product2','Course_ID__c');
        lstJsonKeyObject.add(objJsonmapping5);
        
        Json_Key_Object_Field_mapping__c objJsonmapping6 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Name','Text','Product2','Name');
        lstJsonKeyObject.add(objJsonmapping6);
        
        Json_Key_Object_Field_mapping__c objJsonmapping7 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Price','Currency','Product2','Early_Price__c');
        lstJsonKeyObject.add(objJsonmapping7);
        
        Json_Key_Object_Field_mapping__c objJsonmapping8 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Bird_Date','Date','Product2','Early_Bird_Date__c');
        lstJsonKeyObject.add(objJsonmapping8);
        
        Json_Key_Object_Field_mapping__c objJsonmapping9 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Location','Text','Product2','Location__c');
        lstJsonKeyObject.add(objJsonmapping9);
        
        Json_Key_Object_Field_mapping__c objJsonmapping10 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ShortName','Text','Product2','ShortName__c');
        lstJsonKeyObject.add(objJsonmapping10);
        
        Json_Key_Object_Field_mapping__c objJsonmapping11 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Description','Text','Product2','Description');
        lstJsonKeyObject.add(objJsonmapping11);
        
        //insert objJsonmapping;
        //do request
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        String jsonbody ='{"Products": [{"Name":"Test Prod","Active":"true","Course_ID":"Test34","Description":"testing product","Full_Price":"800","ProductFamily":"None"},{"Name":"Test Prod","Active":"true","Course_ID":"Test01","Description":"testing product","Full_Price":"800","ProductFamily":"None"}]}';
        req.requestURI = '/services/apexrest/ProductService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        ProductWebService.upsertProduct();
    }
    
    static testMethod void testSingleResp() 
    {
        
        List<Json_Key_Object_Field_mapping__c> lstJsonKeyObject = new List<Json_Key_Object_Field_mapping__c>();
        Json_Key_Object_Field_mapping__c objJsonmapping = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Active','Checkbox','Product2','IsActive');
        lstJsonKeyObject.add(objJsonmapping);
        
        Json_Key_Object_Field_mapping__c objJsonmapping1 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('DisplayUrl','Text','Product2','DisplayUrl');
        lstJsonKeyObject.add(objJsonmapping1);
        
        Json_Key_Object_Field_mapping__c objJsonmapping2 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductCode','Text','Product2','ProductCode');
        lstJsonKeyObject.add(objJsonmapping2);
        
        Json_Key_Object_Field_mapping__c objJsonmapping3 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductFamily','Text','Product2','Family');
        lstJsonKeyObject.add(objJsonmapping3);
        
        Json_Key_Object_Field_mapping__c objJsonmapping4 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Full_Price','Currency','Product2','Full_Price__c');
        lstJsonKeyObject.add(objJsonmapping4);
        
        Json_Key_Object_Field_mapping__c objJsonmapping5 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Course_ID','Text','Product2','Course_ID__c');
        lstJsonKeyObject.add(objJsonmapping5);
        
        Json_Key_Object_Field_mapping__c objJsonmapping6 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Name','Text','Product2','Name');
        lstJsonKeyObject.add(objJsonmapping6);
        
        Json_Key_Object_Field_mapping__c objJsonmapping7 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Price','Currency','Product2','Early_Price__c');
        lstJsonKeyObject.add(objJsonmapping7);
        
        Json_Key_Object_Field_mapping__c objJsonmapping8 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Bird_Date','Date','Product2','Early_Bird_Date__c');
        lstJsonKeyObject.add(objJsonmapping8);
        
        Json_Key_Object_Field_mapping__c objJsonmapping9 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Location','Text','Product2','Location__c');
        lstJsonKeyObject.add(objJsonmapping9);
        
        Json_Key_Object_Field_mapping__c objJsonmapping10 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ShortName','Text','Product2','ShortName__c');
        lstJsonKeyObject.add(objJsonmapping10);
        
        Json_Key_Object_Field_mapping__c objJsonmapping11 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Description','Text','Product2','Description');
        lstJsonKeyObject.add(objJsonmapping11);
        
               Product2 objProd= new Product2();
        objProd.Course_ID__c='1402-SC-MEL-ADERM1';
        objProd.Family='None';
        objProd.Full_Price__c=1200;
        objProd.IsActive=true;
        objProd.Name='Test1';
        objProd.Description='Test';
        insert objProd;
//do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        String  jsonbody ='{"Product": {"Name":"S","Active":"true","Course_ID":"1402-SC-MEL-ADERM1","Description":"testing product","Full_Price":"801","ProductFamily":"None"}}';
        req.requestURI = '/services/apexrest/ProductService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        ProductWebService.upsertProduct();               
    }    
    
    static testMethod void testUpdateResp() 
    {
 List<Json_Key_Object_Field_mapping__c> lstJsonKeyObject = new List<Json_Key_Object_Field_mapping__c>();
        Json_Key_Object_Field_mapping__c objJsonmapping = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Active','Checkbox','Product2','IsActive');
        lstJsonKeyObject.add(objJsonmapping);
        
        Json_Key_Object_Field_mapping__c objJsonmapping1 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('DisplayUrl','Text','Product2','DisplayUrl');
        lstJsonKeyObject.add(objJsonmapping1);
        
        Json_Key_Object_Field_mapping__c objJsonmapping2 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductCode','Text','Product2','ProductCode');
        lstJsonKeyObject.add(objJsonmapping2);
        
        Json_Key_Object_Field_mapping__c objJsonmapping3 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductFamily','Text','Product2','Family');
        lstJsonKeyObject.add(objJsonmapping3);
        
        Json_Key_Object_Field_mapping__c objJsonmapping4 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Full_Price','Currency','Product2','Full_Price__c');
        lstJsonKeyObject.add(objJsonmapping4);
        
        Json_Key_Object_Field_mapping__c objJsonmapping5 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Course_ID','Text','Product2','Course_ID__c');
        lstJsonKeyObject.add(objJsonmapping5);
        
        Json_Key_Object_Field_mapping__c objJsonmapping6 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Name','Text','Product2','Name');
        lstJsonKeyObject.add(objJsonmapping6);
        
        Json_Key_Object_Field_mapping__c objJsonmapping7 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Price','Currency','Product2','Early_Price__c');
        lstJsonKeyObject.add(objJsonmapping7);
        
        Json_Key_Object_Field_mapping__c objJsonmapping8 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Bird_Date','Date','Product2','Early_Bird_Date__c');
        lstJsonKeyObject.add(objJsonmapping8);
        
        Json_Key_Object_Field_mapping__c objJsonmapping9 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Location','Text','Product2','Location__c');
        lstJsonKeyObject.add(objJsonmapping9);
        
        Json_Key_Object_Field_mapping__c objJsonmapping10 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ShortName','Text','Product2','ShortName__c');
        lstJsonKeyObject.add(objJsonmapping10);
        
        Json_Key_Object_Field_mapping__c objJsonmapping11 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Description','Text','Product2','Description');
        lstJsonKeyObject.add(objJsonmapping11);
        
  //insert objJsonmapping;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        //Product2 objProd= [Select id , Course_Id__c, Name, Full_Price__c from Product2 Limit 1];
        //
        
       String  jsonbody ='{"Product": {"Name":"S","Active":"true","Course_ID": "test", "Description":"testing product","Full_Price":"1","ProductFamily":"None"}}';
        req.requestURI = '/services/apexrest/ProductService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        ProductWebService.upsertProduct();
    }
    
    
    
    
    static testMethod void testProdExistInInactive() 
    {
         List<Json_Key_Object_Field_mapping__c> lstJsonKeyObject = new List<Json_Key_Object_Field_mapping__c>();
        Json_Key_Object_Field_mapping__c objJsonmapping = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Active','Checkbox','Product2','IsActive');
        lstJsonKeyObject.add(objJsonmapping);
        
        Json_Key_Object_Field_mapping__c objJsonmapping1 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('DisplayUrl','Text','Product2','DisplayUrl');
        lstJsonKeyObject.add(objJsonmapping1);
        
        Json_Key_Object_Field_mapping__c objJsonmapping2 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductCode','Text','Product2','ProductCode');
        lstJsonKeyObject.add(objJsonmapping2);
        
        Json_Key_Object_Field_mapping__c objJsonmapping3 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductFamily','Text','Product2','Family');
        lstJsonKeyObject.add(objJsonmapping3);
        
        Json_Key_Object_Field_mapping__c objJsonmapping4 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Full_Price','Currency','Product2','Full_Price__c');
        lstJsonKeyObject.add(objJsonmapping4);
        
        Json_Key_Object_Field_mapping__c objJsonmapping5 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Course_ID','Text','Product2','Course_ID__c');
        lstJsonKeyObject.add(objJsonmapping5);
        
        Json_Key_Object_Field_mapping__c objJsonmapping6 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Name','Text','Product2','Name');
        lstJsonKeyObject.add(objJsonmapping6);
        
        Json_Key_Object_Field_mapping__c objJsonmapping7 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Price','Currency','Product2','Early_Price__c');
        lstJsonKeyObject.add(objJsonmapping7);
        
        Json_Key_Object_Field_mapping__c objJsonmapping8 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Bird_Date','Date','Product2','Early_Bird_Date__c');
        lstJsonKeyObject.add(objJsonmapping8);
        
        Json_Key_Object_Field_mapping__c objJsonmapping9 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Location','Text','Product2','Location__c');
        lstJsonKeyObject.add(objJsonmapping9);
        
        Json_Key_Object_Field_mapping__c objJsonmapping10 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ShortName','Text','Product2','ShortName__c');
        lstJsonKeyObject.add(objJsonmapping10);
        
        Json_Key_Object_Field_mapping__c objJsonmapping11 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Description','Text','Product2','Description');
        lstJsonKeyObject.add(objJsonmapping11);
                //insert objJsonmapping;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
            Product2 objProd= new Product2();
        objProd.Course_ID__c='1402-SC-MEL-ADERM1';
        objProd.Family='None';
        objProd.Full_Price__c=1200;
        objProd.IsActive=false;
        objProd.Name='Test';
        objProd.Description='Test';
        insert objProd;
//do request
       
       String  jsonbody ='{"Product": {"Name":"S","Active":"true","Course_ID": "'+objProd.Course_ID__c+'", "Description":"testing product"}}';
        req.requestURI = '/services/apexrest/ProductService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        ProductWebService.upsertProduct();
    }
    
     static testMethod void testProdExistInactive() 
    {
         List<Json_Key_Object_Field_mapping__c> lstJsonKeyObject = new List<Json_Key_Object_Field_mapping__c>();
        Json_Key_Object_Field_mapping__c objJsonmapping = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Active','Checkbox','Product2','IsActive');
        lstJsonKeyObject.add(objJsonmapping);
        
        Json_Key_Object_Field_mapping__c objJsonmapping1 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('DisplayUrl','Text','Product2','DisplayUrl');
        lstJsonKeyObject.add(objJsonmapping1);
        
        Json_Key_Object_Field_mapping__c objJsonmapping2 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductCode','Text','Product2','ProductCode');
        lstJsonKeyObject.add(objJsonmapping2);
        
        Json_Key_Object_Field_mapping__c objJsonmapping3 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ProductFamily','Text','Product2','Family');
        lstJsonKeyObject.add(objJsonmapping3);
        
        Json_Key_Object_Field_mapping__c objJsonmapping4 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Full_Price','Currency','Product2','Full_Price__c');
        lstJsonKeyObject.add(objJsonmapping4);
        
        Json_Key_Object_Field_mapping__c objJsonmapping5 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Course_ID','Text','Product2','Course_ID__c');
        lstJsonKeyObject.add(objJsonmapping5);
        
        Json_Key_Object_Field_mapping__c objJsonmapping6 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Name','Text','Product2','Name');
        lstJsonKeyObject.add(objJsonmapping6);
        
        Json_Key_Object_Field_mapping__c objJsonmapping7 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Price','Currency','Product2','Early_Price__c');
        lstJsonKeyObject.add(objJsonmapping7);
        
        Json_Key_Object_Field_mapping__c objJsonmapping8 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Early_Bird_Date','Date','Product2','Early_Bird_Date__c');
        lstJsonKeyObject.add(objJsonmapping8);
        
        Json_Key_Object_Field_mapping__c objJsonmapping9 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Location','Text','Product2','Location__c');
        lstJsonKeyObject.add(objJsonmapping9);
        
        Json_Key_Object_Field_mapping__c objJsonmapping10 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('ShortName','Text','Product2','ShortName__c');
        lstJsonKeyObject.add(objJsonmapping10);
        
        Json_Key_Object_Field_mapping__c objJsonmapping11 = commonClassTracker.objJsonKeyObjectfieldMappingRecord('Description','Text','Product2','Description');
        lstJsonKeyObject.add(objJsonmapping11);
                //insert objJsonmapping;
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
            Product2 objProd= new Product2();
        objProd.Course_ID__c='1402-SC-MEL-ADERM1';
        objProd.Family='None';
        objProd.Full_Price__c=1200;
        objProd.IsActive=true;
        objProd.Name='Test';
        objProd.Description='Test';
        insert objProd;
//do request
       
       String  jsonbody ='{"Product": {"Name":"S","Active":"true","Course_ID": "'+objProd.Course_ID__c+'", "Description":"testing product"}}';
        req.requestURI = '/services/apexrest/ProductService';  
        req.requestBody = Blob.valueof(jsonbody);
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        ProductWebService.upsertProduct();
    }
   
}