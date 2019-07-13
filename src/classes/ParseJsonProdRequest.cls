public class ParseJsonProdRequest {
    
    
    //parse the json response into salesforce objects
    public static RestResponse parseProductJson(string jsonBody) 
    {   
        RestResponse res = RestContext.response; 
        boolean endArray = false; //used for multiple products in response
        sObject sObjectInstance; // for storing json response in single product case
        sObject sObjectInstance1; //for storing json response in multiple product case
        List<ErrorResponse> lstErrorResponse = new list<ErrorResponse>();
        list<sObject> sObjectInstancelist = new list<sobject>();
         Map<String,Json_Key_Object_Field_mapping__c> csAllFieldMapping = new     Map<String,Json_Key_Object_Field_mapping__c> ();
        if(String.isNotEmpty(jsonBody)) {
         
            
          csAllFieldMapping = Json_Key_Object_Field_mapping__c.getAll();
            
            system.debug('csAllFieldMapping+++'+csAllFieldMapping);
                JSONParser jsonParser = JSON.createParser(jsonBody);
                        system.debug('jsonParser='+jsonParser);

            list<sobject> lstProduct = new list<Product2>();
            list<SuccessJson> lstSuccessJson = new list<SuccessJson>();
            if(jsonParser.getCurrentToken() == null && jsonParser.nextToken() != null) {
                while(jsonParser.getCurrentToken() != JSONToken.START_OBJECT){
                    jsonParser.nextToken();
                }
                if(jsonParser.getCurrentToken() == JSONToken.START_OBJECT) {
                    while(jsonParser.nextToken() != null){
                        if(jsonParser.getText() == 'Products') {     
                            while(jsonParser.nextToken() != null) {
                                if(jsonParser.getCurrentToken() == JSONToken.END_ARRAY) 
                                { 
                                    endArray = true;
                                }
                                if(jsonParser.getCurrentToken() == JSONToken.FIELD_NAME && string.isNotEmpty(jsonParser.getText()) &&
                                   csAllFieldMapping.get(jsonParser.getText()) != null) 
                                {
                                    sObjectInstance1 =InitializeSobjectInstance.getOpportunityInstance(csAllFieldMapping.get(jsonParser.getText()).Object_Name__c);
                                    string fieldApi = csAllFieldMapping.get(jsonParser.getText()).SF_Field_Api__c;
                                    string objectName = csAllFieldMapping.get(jsonParser.getText()).Object_Name__c;
                                    string dataType= csAllFieldMapping.get(jsonParser.getText()).Data_Type__c;
                                    jsonParser.nextToken();
                                    if(jsonParser.getCurrentToken() == JSONToken.VALUE_STRING && objectName == 'Product2') 
                                    {
                                        if(dataType =='TextArea') 
                                        {
                                            sObjectInstance1.put(fieldApi,(String.valueOf(jsonParser.getText())));
                                        }
                                        if(dataType =='Currency') 
                                        {
                                            if(fieldApi =='Full_Price__c') 
                                            {
                                                sObjectInstance1.put(fieldApi,decimal.valueof(jsonParser.getText()));
                                            }
                                            if(fieldApi =='Early_Price__c') 
                                            {
                                                sObjectInstance1.put(fieldApi,decimal.valueof(jsonParser.getText()));
                                            }
                                        }
                                        if(dataType =='Date') 
                                        {                                               
                                            sObjectInstance1.put(fieldApi,Date.valueof(jsonParser.getText()));
                                        }
                                        else if(dataType=='Text') 
                                        {
                                            if(fieldApi =='Family') 
                                            {
                                                if(String.valueOf(jsonParser.getText())==null ||String.valueOf(jsonParser.getText())=='' )
                                                {
                                                    sObjectInstance1.put(fieldApi,'None');  
                                                }
                                                else {sObjectInstance1.put(fieldApi,(String.valueOf(jsonParser.getText())));  }
                                                
                                            }
                                            else if(fieldApi =='DisplayUrl')
                                            {
                                                sObjectInstance1.put(fieldApi,String.valueOf(jsonParser.getText())); 
                                            }
                                            else if(fieldApi =='Location__c')
                                            {
                                                sObjectInstance1.put(fieldApi,String.valueOf(jsonParser.getText())); 
                                            }
                                            else if(fieldApi =='ShortName__c')
                                            {
                                                sObjectInstance1.put(fieldApi,String.valueOf(jsonParser.getText())); 
                                            }
                                            else if(fieldApi =='ProductCode')
                                            {
                                                sObjectInstance1.put(fieldApi,String.valueOf(jsonParser.getText())); 
                                            }
                                            else   if(fieldApi =='Description')
                                            {
                                                sObjectInstance1.put(fieldApi,String.valueOf(jsonParser.getText())); 
                                            }
                                            else if(fieldApi == 'Course_ID__c')
                                            {
                                                sObjectInstance1.put(fieldApi,jsonParser.getText()); 
                                                
                                            }
                                            else if(fieldApi == 'Name')
                                            {
                                                sObjectInstance1.put(fieldApi,String.valueof(jsonParser.getText())); 
                                            }
                                        }
                                        else if(fieldApi == 'IsActive')
                                        {
                                            sObjectInstance1.put(fieldApi,Boolean.valueOf(jsonParser.getText())); 
                                        }
                                    }
                                }
                                else {
                                    if(jsonParser.getText() != '[' && jsonParser.getText() != ']' &&
                                       jsonParser.getText() != '{' && jsonParser.getText() != '}') 
                                    {
                                        SuccessJson objSuccessOptyJson = new SuccessJson();
                                        objSuccessOptyJson.id =null;
                                        objSuccessOptyJson.objectType = 'Product2';
                                        objSuccessOptyJson.success = false;
                                        objSuccessOptyJson.errors = new list<string>();
                                        objSuccessOptyJson.warnings = new list<string>();
                                        string fieldToken = 'Field Token - '+jsonParser.getText()+' does not exist in custom setting. Please add and try again.';
                                        objSuccessOptyJson.Errors.add(fieldToken);
                                        lstSuccessJson.add(objSuccessOptyJson);
                                        system.debug('lstSuccessJson'+lstSuccessJson);
                                        res.responseBody = blob.valueof(Json.serialize(lstSuccessJson));
                                        system.debug('res'+res);
                                    }
                                    
                                }
                                if(jsonParser.getCurrentToken() == JSONTOken.END_OBJECT && !endArray) 
                                {
                                    Sobject objProduct1 = new Product2();
                                    if(sObjectInstance1!=null){
                                    objProduct1 = sObjectInstance1.clone(true,true,false,false);
                                    sObjectInstancelist.add(objProduct1);  
                                }
                                }
                            }
                        }
                        else  if(jsonParser.getText() == 'Product')
                        {     
                                                                                                sObjectInstance =Schema.getGlobalDescribe().get('Product2').newSObject() ;

                            while(jsonParser.nextToken() != null)
                            {
                                system.debug(jsonParser.getText());

                                if(jsonParser.getCurrentToken() == JSONToken.FIELD_NAME && string.isNotEmpty(jsonParser.getText()) && 
                                   csAllFieldMapping.get(jsonParser.getText()) != null && csAllFieldMapping.get(jsonParser.getText()).Object_Name__c != null &&
                                   csAllFieldMapping.get(jsonParser.getText()).SF_Field_Api__c != null) 
                                {
                                    system.debug('object initialization');
                                    string fieldApi = csAllFieldMapping.get(jsonParser.getText()).SF_Field_Api__c;
                                    string objectName = csAllFieldMapping.get(jsonParser.getText()).Object_Name__c;
                                    string dataType= csAllFieldMapping.get(jsonParser.getText()).Data_Type__c;
                                    jsonParser.nextToken();
                                    if(jsonParser.getCurrentToken() == JSONToken.VALUE_STRING) 
                                    {
                                        if(dataType =='TextArea') 
                                        {
                                            sObjectInstance.put(fieldApi,jsonParser.getText());
                                        }
                                        if(dataType =='Currency') 
                                        {
                                            if(fieldApi =='Full_Price__c') 
                                            {
                                                sObjectInstance.put(fieldApi,decimal.valueof(jsonParser.getText()));
                                            }
                                            else  if(fieldApi =='Early_Price__c') 
                                            {
                                                sObjectInstance.put(fieldApi,decimal.valueof(jsonParser.getText()));
                                            }
                                        }
                                        if(dataType =='Date') 
                                        {
                                            sObjectInstance.put(fieldApi,Date.valueof(jsonParser.getText()));
                                        }
                                        if(dataType =='Text')
                                        {
                                            if(fieldApi =='Family') 
                                            {
                                               
                                                 if(String.valueOf(jsonParser.getText())==null ||String.valueOf(jsonParser.getText())=='' )
                                                {
                                                    sObjectInstance.put(fieldApi,'None');  
                                                }
                                                else {sObjectInstance.put(fieldApi,(String.valueOf(jsonParser.getText())));  }                                           
                                            }
                                            else if(fieldApi =='DisplayUrl')
                                            {
                                                sObjectInstance.put(fieldApi,String.valueOf(jsonParser.getText())); 
                                            }
                                            else if(fieldApi =='Location__c')
                                            {
                                                sObjectInstance.put(fieldApi,String.valueOf(jsonParser.getText())); 
                                            }
                                            else if(fieldApi =='ShortName__c')
                                            {
                                                sObjectInstance.put(fieldApi,String.valueOf(jsonParser.getText())); 
                                            }
                                            else if(fieldApi =='Description')
                                            {
                                                sObjectInstance.put(fieldApi,String.valueOf(jsonParser.getText())); 
                                            }
                                            else if(fieldApi =='ProductCode')
                                            {
                                                sObjectInstance.put(fieldApi,String.valueof(jsonParser.getText()));                                                 
                                            }
                                            else if(fieldApi == 'Course_ID__c')
                                            {
                                                sObjectInstance.put(fieldApi,String.valueof(jsonParser.getText())); 
                                            }
                                            else if(fieldApi == 'Name')
                                            {
                                                sObjectInstance.put(fieldApi,String.valueof(jsonParser.getText()));                                                
                                            }
                                        }
                                        else if(fieldApi == 'IsActive')
                                        {
                                            sObjectInstance.put(fieldApi,Boolean.valueOf(jsonParser.getText()));
                                        }
                                    }
                                }
                            }
                            system.debug('sObjectInstance'+sObjectInstance);
                            sObjectInstancelist.add(sObjectInstance);
                            system.debug('sObjectInstancelist'+sObjectInstancelist);
                        }
                    }
                }
            }
        }
        if(sObjectInstancelist!=null && sObjectInstancelist.size()>0){
        res = InsertProduct.parseJson(sObjectInstancelist);
        }
        return res;  
    }
}