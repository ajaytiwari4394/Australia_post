public with sharing class ParseOpportunityJsonRequest {
    
    public static RestResponse parseJson(string jsonBody) 
    {
        //String strObjectId;
        //Id recordTypeId = CommonClass.GetRecordTypeId('Account','Person Account');
        RestResponse res = RestContext.response; 
        //set<id> setDupAccountId = new set<id>();
        //string strResponse;
        boolean endArray = false;
        List<ErrorResponse> lstErrorResponse = new list<ErrorResponse>();
        if(String.isNotEmpty(jsonBody)) {
            
            Map<String,Json_Key_Object_Field_mapping__c> csAllFieldMapping = Json_Key_Object_Field_mapping__c.getAll();
            Map<string, StageMapping__c> oppStageMapping = StageMapping__c.getAll();
            JSONParser jsonParser = JSON.createParser(jsonBody);
            sObject sObjectInstance;
            sObject objOpportunity;
            list<sobject> lstOpportunity = new list<Opportunity>();
            list<SuccessJson> lstSuccessJson = new list<SuccessJson>();
            if(jsonParser.getCurrentToken() == null && jsonParser.nextToken() != null) {
                
                if(jsonParser.getCurrentToken() == JSONToken.START_OBJECT) {
                    while(jsonParser.nextToken() != null){
                   
                        if(jsonParser.getText() == 'Account') {
                            if(jsonParser.getCurrentToken() == JSONToken.FIELD_NAME && string.isNotEmpty(jsonParser.getText())) {
                                if(jsonParser.nextToken() == JSONToken.START_OBJECT) {
                                    
                                    while(jsonParser.nextToken() != null){ 
                                        
                                        if(csAllFieldMapping.get(jsonParser.getText()) != null && jsonParser.getText() != 'Opportunities' ) {
                                            sObjectInstance =InitializeSobjectInstance.getObjectInstance(csAllFieldMapping.get(jsonParser.getText()).Object_Name__c);
                                    
                                            string fieldApi = csAllFieldMapping.get(jsonParser.getText()).SF_Field_Api__c;
                                            string objectName = csAllFieldMapping.get(jsonParser.getText()).Object_Name__c;
                                            string dataType= csAllFieldMapping.get(jsonParser.getText()).Data_Type__c;
                                            jsonParser.nextToken();
                                            
                                            if(jsonParser.getCurrentToken() == JSONToken.VALUE_STRING && 
                                                objectName == 'Account') {
                                                if(dataType =='Date') 
                                                {
                                                    system.debug('DateValue----'+date.valueof(jsonParser.getText()));
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
                                                
                                                //sObjectInstance.put(fieldApi,jsonParser.getText());
                                            }
                                            system.debug(sObjectInstance+'----sObjectInstance');
                                        }
                                        if(jsonParser.getText() == 'Opportunities') {
                                            
                                            while(jsonParser.nextToken() != null) {
                                                
                                                if(jsonParser.getCurrentToken() == JSONToken.END_ARRAY) {
                                                    endArray = true;
                                                }
                                                if(jsonParser.getCurrentToken() == JSONToken.FIELD_NAME && string.isNotEmpty(jsonParser.getText()) &&
                                                	csAllFieldMapping.get(jsonParser.getText()) != null) {
                                                    
                                                    objOpportunity =InitializeSobjectInstance.getOpportunityInstance(csAllFieldMapping.get(jsonParser.getText()).Object_Name__c);
                                                    
                                                    string fieldApi = csAllFieldMapping.get(jsonParser.getText()).SF_Field_Api__c;
                                                    string objectName = csAllFieldMapping.get(jsonParser.getText()).Object_Name__c;
                                                    string dataType= csAllFieldMapping.get(jsonParser.getText()).Data_Type__c;
                                                    jsonParser.nextToken();
                                                    
                                                    if(jsonParser.getCurrentToken() == JSONToken.VALUE_STRING && objectName == 'Opportunity') {
                                                        
                                                        if(dataType =='Date') {
                                                            system.debug('DateValue----'+date.valueof(jsonParser.getText()));
                                                            objOpportunity.put(fieldApi,date.valueof(jsonParser.getText()));
                                                        }
                                                        if(dataType =='Number' || dataType =='Currency') {
                                                            objOpportunity.put(fieldApi,decimal.valueof(jsonParser.getText()));
                                                        }
                                                        else if(dataType !='Number' && dataType !='Currency' && dataType !='Date') {
                                                            if(fieldApi =='OppStatus__c') {
                                                                system.debug('fieldApi***'+fieldApi);
                                                                objOpportunity.put(fieldApi,jsonParser.getText().trim());
                                                                
                                                                if(objOpportunity.get(fieldApi) == null)
                                                                {
                                                                    objOpportunity.put('StageName','Clicked Enroled');
                                                                }
                                                                else
                                                                {
                                                                    string strStage = string.valueof(objOpportunity.get(fieldApi));
                                                                    if(oppStageMapping.containskey(strStage))
                                                                    {
                                                                        objOpportunity.put('StageName',oppStageMapping.get(strStage).Stage__c);
                                                                    }
                                                                    else
                                                                    {
                                                                        if(oppStageMapping.containskey('Default'))
                                                                        objOpportunity.put('StageName',oppStageMapping.get('Default').Stage__c);
                                                                    }
                                                                }
                                                            }
                                                            objOpportunity.put(fieldApi,jsonParser.getText());  
                                                             
                                                        }
                                                        //mark created by api checkbox as true
                                                        objOpportunity.put('Created_by_Api__c',true);
                                                       
                                                    }
                                                    system.debug(objOpportunity+'----objOpportunity');
                                                }
                                                else {
                                                	if(jsonParser.getText() != '[' && jsonParser.getText() != ']' &&
                                                		jsonParser.getText() != '{' && jsonParser.getText() != '}') {
                                                			SuccessJson objSuccessOptyJson = new SuccessJson();
								                            objSuccessOptyJson.id =null;
								                            objSuccessOptyJson.objectType = 'Opportunity';
								                            objSuccessOptyJson.success = false;
								                            
								                            objSuccessOptyJson.errors = new list<string>();
								                            objSuccessOptyJson.warnings = new list<string>();
								                            string fieldToken = 'Field Token - '+jsonParser.getText()+' does not exist in custom setting. Please add and try again.';
								                            objSuccessOptyJson.Errors.add(fieldToken);
								                            lstSuccessJson.add(objSuccessOptyJson);
								                            res.responseBody = blob.valueof(Json.serialize(lstSuccessJson));
                                                		}
                                                	
                                                }
                                                if(jsonParser.getCurrentToken() == JSONTOken.END_OBJECT && !endArray) {
                                                    Sobject objOppty = new Opportunity();
                                                    objOppty = objOpportunity.clone(true,true,false,false);
                                                    lstOpportunity.add(objOppty);
                                                    system.debug(lstOpportunity+'-------------lstOpportunity');
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                    }
                }
                if(sObjectInstance != null && lstSuccessJson != null && lstSuccessJson.size() == 0) 
                {
                    system.debug('lstOpportunity==============='+lstOpportunity);
                    system.debug('sObjectInstance==============='+sObjectInstance);
                    res = insertAccountOrOpportunity.parseJson(sObjectInstance,lstOpportunity);
                }
                        
            }
        }
        system.debug(res+'-----res');
        return res;  
    }
}