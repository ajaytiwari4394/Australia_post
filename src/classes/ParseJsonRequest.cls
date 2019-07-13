public with sharing class ParseJsonRequest {
    
    public static RestResponse parseJson(string jsonBody) 
    {
        //String strObjectId;
        //Id recordTypeId = CommonClass.GetRecordTypeId('Account','Person Account');
        RestResponse res = RestContext.response; 
        //set<id> setDupAccountId = new set<id>();
        //string strResponse;
        List<ErrorResponse> lstErrorResponse = new list<ErrorResponse>();
        if(String.isNotEmpty(jsonBody)) {
            
            Map<String,Json_Key_Object_Field_mapping__c> csAllFieldMapping = Json_Key_Object_Field_mapping__c.getAll();
            system.debug('csAllFieldMapping***'+csAllFieldMapping);
            JSONParser jsonParser = JSON.createParser(jsonBody);
            sObject sObjectInstance;
            if(jsonParser.getCurrentToken() == null && jsonParser.nextToken() != null) {
                
                if(jsonParser.getCurrentToken() == JSONToken.START_OBJECT) {
                    while(jsonParser.nextToken() != null){
                    
                        if(jsonParser.getCurrentToken() == JSONToken.FIELD_NAME && string.isNotEmpty(jsonParser.getText()) && 
                            csAllFieldMapping.get(jsonParser.getText()) != null && csAllFieldMapping.get(jsonParser.getText()).Object_Name__c != null &&
                            csAllFieldMapping.get(jsonParser.getText()).SF_Field_Api__c != null) {
                            
                            sObjectInstance =InitializeSobjectInstance.getOpportunityInstance(csAllFieldMapping.get(jsonParser.getText()).Object_Name__c);
                            
                            string fieldApi = csAllFieldMapping.get(jsonParser.getText()).SF_Field_Api__c;
                            string objectName = csAllFieldMapping.get(jsonParser.getText()).Object_Name__c;
                            string dataType= csAllFieldMapping.get(jsonParser.getText()).Data_Type__c;
                            jsonParser.nextToken();
                            if(jsonParser.getCurrentToken() == JSONToken.VALUE_STRING) 
                            {
                                if(dataType =='Date') 
                                {
                                    sObjectInstance.put(fieldApi,date.valueof(jsonParser.getText()));
                                }
                                if(dataType =='Number' || dataType =='Currency') 
                                {
                                    sObjectInstance.put(fieldApi,decimal.valueof(jsonParser.getText()));
                                }
                                else if(dataType !='Number' && dataType !='Currency' && dataType !='Date')
                                {
                                    sObjectInstance.put(fieldApi,jsonParser.getText());
                                }
                            }
                            system.debug(sObjectInstance+'----sObjectInstance');
                        }
                    }
                }
                if(sObjectInstance != null) 
                {
                    res = insertAccountOrOpportunity.parseJson(sObjectInstance,null);
                }
            }
         
        }
        system.debug(res+'-----res');
        return res; 
    }
    
    
    
}