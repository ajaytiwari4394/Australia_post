public class insertAccountOrOpportunity
{
    public static RestResponse parseJson(sObject objAccount,list<sObject> listOfOpportunity) 
    {
        Id recordTypeId = CommonClass.GetRecordTypeId('Account','Person Account');
        String strObjectId;
        set<id> setDupAccountId = new set<id>();
        RestResponse res;
        if(test.isRunningTest())
        	res = new RestResponse(); 
        else
        	res = RestContext.response;
        list<SuccessJson> lstSuccessJson = new list<SuccessJson>();
        list<ErrorResponse> lstErrorJson = new list<ErrorResponse>();
        //list<Opportunity> listOfOpportunity = new list<Opportunity>();
        
        ManageDuplicate manageduplicateAcc = new ManageDuplicate();
        //listOfOpportunity = manageduplicateAcc.mappingOppStatusToStage(listOfOpportunity1);
        objAccount.put('recordtypeid', recordTypeId);
        objAccount.put('Website_Account__c', True);
        //save point before account.
        Savepoint sp = Database.setSavepoint();
        Database.UpsertResult objDatabaseUpsertresult = Database.upsert(objAccount, false);
        if (objDatabaseUpsertresult.isSuccess()) 
        {
            
            strObjectId = string.valueOf(objAccount.id);
            SuccessJson objSuccessJson = new SuccessJson();
            if(objAccount.id != null)
            {
                objSuccessJson.id = objAccount.id;
            }
            objSuccessJson.objectType = 'Account';
            objSuccessJson.success = true;
            objSuccessJson.errors = new list<string>();
            objSuccessJson.warnings = new list<string>();
            lstSuccessJson.add(objSuccessJson);
            
            if(listOfOpportunity != null && !listOfOpportunity.isEmpty()) 
            {
                for(sobject obj: listOfOpportunity) 
                {
                    obj.put('AccountId',objAccount.id);
                }
                
                List<Opportunity> lstOfdupOpportunity = new list<Opportunity>();
                
                lstOfdupOpportunity = manageduplicateAcc.getDuplicateopportunity(string.valueof(objAccount.get('PersonEmail')),listOfOpportunity);
                
                //oppty line item insert
                
                list<OpportunityLineItem> lstOpptyLineitem = InsertOpportunityLineItem.linkProductToOpportunitylineitem(lstOfdupOpportunity);
                //
                if(lstOpptyLineitem != null && !lstOpptyLineitem.isEmpty()) {
                	//cheking course id exist in system or not & no change required duplicate scenario
                	map<string,Product2> mapCourseIdWithProduct = CommonClass.getCourseIdWithProduct();
                	integer counter = 0;
                	String productNotExist = Label.Product_Does_not_exist;
                	string noChangeReq = Label.No_Change_Required;
                	List<Opportunity> lstOpportunityToInsert = new list<Opportunity>();
                	system.debug('mapCourseIdWithProduct***'+mapCourseIdWithProduct);
                    system.debug('lstOfdupOpportunity***'+lstOfdupOpportunity);
                	for(Opportunity objOppty : lstOfdupOpportunity) {
                        system.debug(objOppty.Name+'objOppty.Name****');
                		if(objOppty.Name != null && mapCourseIdWithProduct != null && 
                			mapCourseIdWithProduct.get(objOppty.Name) == null) {
                			//generating success json if product does not exist in salesforce.warning will be thrown.	
                			SuccessJson objSuccessOptyJson = new SuccessJson();
                            objSuccessOptyJson.id =null;
                            objSuccessOptyJson.objectType = 'Opportunity';
                            objSuccessOptyJson.success = false;
                            
                            
                            objSuccessOptyJson.errors = new list<string>();
                            objSuccessOptyJson.warnings = new list<string>();
                            string courseId = 'Opportunity Course Id - '+objOppty.Name;
                            objSuccessOptyJson.warnings.add(courseId);
                            objSuccessOptyJson.Errors.add(productNotExist);
                            lstSuccessJson.add(objSuccessOptyJson);
                            //lstOfdupOpportunity.remove(counter);
                		}
                		else if(objOppty.Opportunity_Status__c != null && objOppty.Opportunity_Status__c == 'No Change Required') {
                			SuccessJson objSuccessOptyJson = new SuccessJson();
                            objSuccessOptyJson.id =null;
                            objSuccessOptyJson.objectType = 'Opportunity';
                            objSuccessOptyJson.success = false;
                            
                            objSuccessOptyJson.errors = new list<string>();
                            objSuccessOptyJson.warnings = new list<string>();
                            string courseId = 'Opportunity Course Id - '+objOppty.Name;
                            objSuccessOptyJson.warnings.add(courseId);
                            objSuccessOptyJson.Errors.add(noChangeReq);
                            lstSuccessJson.add(objSuccessOptyJson);
                            //lstOfdupOpportunity.remove(counter);
                		}
                		else {
                			lstOpportunityToInsert.add(objOppty);
                		}
                		counter++;
                	}
                    list<Database.UpsertResult> LstDatabaseUpsertOptyresult = Database.upsert(lstOpportunityToInsert, false);
                    system.debug('LstDatabaseUpsertOptyresult============'+LstDatabaseUpsertOptyresult);
                    for(Database.UpsertResult objOpptyUpsertResult : LstDatabaseUpsertOptyresult) 
                    {
                        if(objOpptyUpsertResult.isSuccess()) 
                        {
                            SuccessJson objSuccessOptyJson = new SuccessJson();
                            objSuccessOptyJson.id =objOpptyUpsertResult.getId();
                            objSuccessOptyJson.objectType = 'Opportunity';
                            objSuccessOptyJson.success = true;
                            objSuccessOptyJson.errors = new list<string>();
                            objSuccessOptyJson.warnings = new list<string>();
                            lstSuccessJson.add(objSuccessOptyJson);
                            
                            list<Database.UpsertResult> LstDatabaseUpsertOptyLIresult = Database.upsert(lstOpptyLineitem, false);
                            for(Database.UpsertResult objOpptyLIUpsertResult : LstDatabaseUpsertOptyLIresult) 
                            {
                                if(objOpptyLIUpsertResult.isSuccess()) 
                                {
                                    
                                }
                                else {
                                    for(Database.Error err : objOpptyLIUpsertResult.getErrors()) 
                                    {
                                        System.debug('opportunity=============='+err.getStatusCode() + ': ' + err.getMessage());
                                        System.debug('Account fields ============' + err.getFields());
                                        Database.rollback(sp);
                                        ErrorResponse objError = new ErrorResponse();
                                          objError.message = err.getMessage();
                                      
                                          objError.fields = new list<String>();
                                          if(string.valueof(err.getStatusCode()) == 'REQUIRED_FIELD_MISSING') 
                                          {
                                              string fieldName = string.valueof(err.getFields());
                                              system.debug('fieldName***'+fieldName);
                                              
                                              objError.fields.add(fieldName);
                                          }
                                          objError.errorCode = string.valueof(err.getStatusCode());
                                          res.responseBody = Blob.valueOf(JSON.serialize(objError));
                                          ErrorLogUtility.logError('insertAccountOrOpportunity','parseJson',err,string.valueof(err.getMessage()),'','','','');
                                          ErrorLogUtility.commitLog();
                                         lstErrorJson.add(objError);
                                    }  
                                }
                                
                            }
                        }
                        else {
                            for(Database.Error err : objOpptyUpsertResult.getErrors()) 
                            {
                                System.debug('opportunity=============='+err.getStatusCode() + ': ' + err.getMessage());
                                System.debug('Account fields ============' + err.getFields());
                                Database.rollback(sp);
                                
                                ErrorResponse objError = new ErrorResponse();
                                  objError.message = err.getMessage();
                              
                                  objError.fields = new list<String>();
                                  if(string.valueof(err.getStatusCode()) == 'REQUIRED_FIELD_MISSING') 
                                  {
                                      string fieldName = string.valueof(err.getFields());
                                      system.debug('fieldName***'+fieldName);
                                      
                                      objError.fields.add(fieldName);
                                  }
                                  objError.errorCode = string.valueof(err.getStatusCode());
                                  res.responseBody = Blob.valueOf(JSON.serialize(objError));
                                  ErrorLogUtility.logError('insertAccountOrOpportunity','parseJson',err,string.valueof(err.getMessage()),'','','','');
                                  ErrorLogUtility.commitLog();
                                 lstErrorJson.add(objError);
                                
                            }  
                        }
                    }
                }
                else {
                	//cheking course id exist in system or not & no change required duplicate scenario
                	map<string,Product2> mapCourseIdWithProduct = CommonClass.getCourseIdWithProduct();
                	integer counter = 0;
                	String productNotExist = Label.Product_Does_not_exist;
                	string noChangeReq = Label.No_Change_Required;
                	
                	for(Opportunity objOppty : lstOfdupOpportunity) {
                		if(objOppty.Name != null && mapCourseIdWithProduct != null && 
                			mapCourseIdWithProduct.get(objOppty.Name) == null) {
                			//generating success json if product does not exist in salesforce.warning will be thrown.	
                			SuccessJson objSuccessOptyJson = new SuccessJson();
                            objSuccessOptyJson.id =null;
                            objSuccessOptyJson.objectType = 'Opportunity';
                            objSuccessOptyJson.success = false;
                            
                            objSuccessOptyJson.errors = new list<string>();
                            objSuccessOptyJson.warnings = new list<string>();
                            string courseId = 'Opportunity Course Id - '+objOppty.Name;
                            objSuccessOptyJson.warnings.add(courseId);
                            objSuccessOptyJson.Errors.add(productNotExist);
                            lstSuccessJson.add(objSuccessOptyJson);
                            //lstOfdupOpportunity.remove(counter);
                		}
                		else if(objOppty.Opportunity_Status__c != null && objOppty.Opportunity_Status__c == 'No Change Required') {
                			SuccessJson objSuccessOptyJson = new SuccessJson();
                            objSuccessOptyJson.id =null;
                            objSuccessOptyJson.objectType = 'Opportunity';
                            objSuccessOptyJson.success = false;
                            
                            objSuccessOptyJson.errors = new list<string>();
                            objSuccessOptyJson.warnings = new list<string>();
                            string courseId = 'Opportunity Course Id - '+objOppty.Name;
                            objSuccessOptyJson.warnings.add(courseId);
                            objSuccessOptyJson.Errors.add(noChangeReq);
                            lstSuccessJson.add(objSuccessOptyJson);
                            //lstOfdupOpportunity.remove(counter);
                		}
                		
                		counter++;
                	}
                }  
            }
            if(lstErrorJson != null && !lstErrorJson.isEmpty()) {
                res.responseBody = blob.valueof(Json.serialize(lstErrorJson));
                
            }
            if(lstSuccessJson != null && !lstSuccessJson.isEmpty()) {
                res.responseBody = blob.valueof(Json.serialize(lstSuccessJson));
                //res.responseBody = Blob.valueOf(Json.serialize(lstSuccessJson));
            }
                
                System.debug('Successfully inserted account. Account ID: ' + objDatabaseUpsertresult.getId());
        }
        else
        {
            // Operation failed, so get all errors                
            for(Database.Error err : objDatabaseUpsertresult.getErrors()) 
            {                   
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Account fields that affected this error: ' + err.getFields());
                if(string.valueof(err.getStatusCode()) == 'DUPLICATES_DETECTED')
                {
                    setDupAccountId = manageduplicateAcc.getDuplicateAccountId(objDatabaseUpsertresult);
                    system.debug('setDupAccountId&&&'+setDupAccountId);
                    list<id> listOfDupId = new list<id>();
                    Account dupAccount = new Account();
                    listOfDupId.addAll(setDupAccountId);
                    if(listOfDupId != null && listOfDupId.size()>0)
                    {
                        //dupAccount = manageduplicateAcc.updateDuplicateRecord(objAccount,listOfDupId[0]);
                        objAccount.put('Id',listOfDupId[0]);
                    }
                    upsert objAccount;
                    SuccessJson objSuccessJson = new SuccessJson();
                    objSuccessJson.id =objAccount.id;
                    objSuccessJson.objectType = 'Account';
                    objSuccessJson.success = true;
                    objSuccessJson.errors = new list<string>();
                    objSuccessJson.warnings = new list<string>();
                    lstSuccessJson.add(objSuccessJson);
                    if(listOfOpportunity != null && !listOfOpportunity.isEmpty()) {
                      for(sobject obj: listOfOpportunity) {
                        obj.put('AccountId',objAccount.id);
                      }
                      List<Opportunity> lstOfErrAccopportunity = new list<Opportunity>();
                      lstOfErrAccopportunity = manageduplicateAcc.getDuplicateopportunity(string.valueof(objAccount.get('PersonEmail')),listOfOpportunity);
                      
                      list<Database.UpsertResult> LstDatabaseUpsertOptyresult;
                      
                      list<OpportunityLineItem> lstOpptyLineitem = InsertOpportunityLineItem.linkProductToOpportunitylineitem(lstOfErrAccopportunity);
                      
                      if(lstOpptyLineitem != null && !lstOpptyLineitem.isEmpty()) {
                          
                          //cheking course id exist in system or not & no change required duplicate scenario
		                	map<string,Product2> mapCourseIdWithProduct = CommonClass.getCourseIdWithProduct();
		                	integer counter = 0;
		                	String productNotExist = Label.Product_Does_not_exist;
		                	string noChangeReq = Label.No_Change_Required;
		                	list<Opportunity> lstopptyToInsert = new list<Opportunity>();
		                	
		                	for(Opportunity objOppty : lstOfErrAccopportunity) {
		                		if(objOppty.Name != null && mapCourseIdWithProduct != null && 
		                			mapCourseIdWithProduct.get(objOppty.Name) == null) {
		                			//generating success json if product does not exist in salesforce.warning will be thrown.	
		                			SuccessJson objSuccessOptyJson = new SuccessJson();
		                            objSuccessOptyJson.id =null;
		                            objSuccessOptyJson.objectType = 'Opportunity';
		                            objSuccessOptyJson.success = false;
		                            
		                            objSuccessOptyJson.errors = new list<string>();
		                            objSuccessOptyJson.warnings = new list<string>();
		                            string courseId = 'Opportunity Course Id - '+objOppty.Name;
                            		objSuccessOptyJson.warnings.add(courseId);
		                            objSuccessOptyJson.Errors.add(productNotExist);
		                            lstSuccessJson.add(objSuccessOptyJson);
		                            //lstOfErrAccopportunity.remove(counter);
		                		}
		                		else if(objOppty.Opportunity_Status__c != null && objOppty.Opportunity_Status__c == 'No Change Required') {
		                			SuccessJson objSuccessOptyJson = new SuccessJson();
		                            objSuccessOptyJson.id =null;
		                            objSuccessOptyJson.objectType = 'Opportunity';
		                            objSuccessOptyJson.success = false;
		                            
		                            objSuccessOptyJson.errors = new list<string>();
		                            objSuccessOptyJson.warnings = new list<string>();
		                            string courseId = 'Opportunity Course Id - '+objOppty.Name;
                            		objSuccessOptyJson.warnings.add(courseId);
		                            objSuccessOptyJson.Errors.add(noChangeReq);
		                            lstSuccessJson.add(objSuccessOptyJson);
		                            //lstOfErrAccopportunity.remove(counter);
		                		}
		                		else {
		                			lstopptyToInsert.add(objOppty);
		                		}
		                		counter++;
		                	}
                          
                          LstDatabaseUpsertOptyresult = Database.upsert(lstopptyToInsert, false);
                          
                          for(Database.UpsertResult objOpptyUpsertResult : LstDatabaseUpsertOptyresult) 
                          {
                                if(objOpptyUpsertResult.isSuccess()) 
                                {
                                    SuccessJson objSuccessOptyJson = new SuccessJson();
                                    objSuccessOptyJson.id =objOpptyUpsertResult.getId();
                                    objSuccessOptyJson.objectType = 'Opportunity';
                                    objSuccessOptyJson.success = true;
                                    objSuccessOptyJson.errors = new list<string>();
                                    objSuccessOptyJson.warnings = new list<string>();
                                    lstSuccessJson.add(objSuccessOptyJson);
                                    
                                    list<Database.UpsertResult> LstDatabaseUpsertOptyLIresult = Database.upsert(lstOpptyLineitem, false);
                                    
                                    for(Database.UpsertResult objOpptyLIUpsertResult : LstDatabaseUpsertOptyLIresult) 
                                    {
                                        if(objOpptyLIUpsertResult.isSuccess()) 
                                        {
                                            
                                        }
                                        else {
                                            for(Database.Error err1 : objOpptyLIUpsertResult.getErrors()) 
                                            {
                                                
                                                Database.rollback(sp);
                                                lstSuccessJson = new list<SuccessJson>();                                               
                                                ErrorResponse objError = new ErrorResponse();
                                                  objError.message = err1.getMessage();
                                              
                                                  objError.fields = new list<String>();
                                                  if(string.valueof(err1.getStatusCode()) == 'REQUIRED_FIELD_MISSING') 
                                                  {
                                                      string fieldName = string.valueof(err1.getFields());
                                                      
                                                      objError.fields.add(fieldName);
                                                  }
                                                  objError.errorCode = string.valueof(err1.getStatusCode());
                                                  ErrorLogUtility.logError('insertAccountOrOpportunity','parseJson',err1,string.valueof(err1.getMessage()),'','','','');
                                                  ErrorLogUtility.commitLog();
                                                 lstErrorJson.add(objError);
                                                
                                            }  
                                        }
                                        
                                    }
                                }
                                else {
                                    for(Database.Error err2 : objOpptyUpsertResult.getErrors()) 
                                    {
                                        Database.rollback(sp);
                                        //if error is coming then we need to remove success message.
                                        lstSuccessJson = new list<SuccessJson>();
                                        
                                        ErrorResponse objError = new ErrorResponse();
                                          objError.message = err2.getMessage();
                                      
                                          objError.fields = new list<String>();
                                          if(string.valueof(err2.getStatusCode()) == 'REQUIRED_FIELD_MISSING') 
                                          {
                                              string fieldName = string.valueof(err2.getFields());
                                              
                                              objError.fields.add(fieldName);
                                          }
                                          objError.errorCode = string.valueof(err2.getStatusCode());
                                          
                                          ErrorLogUtility.logError('insertAccountOrOpportunity','parseJson',err2,string.valueof(err2.getMessage()),'','','','');
                                          ErrorLogUtility.commitLog();
                                         lstErrorJson.add(objError);
                                        
                                    }  
                                }
                          }
                          
                        }
                        else {
                        	//cheking course id exist in system or not & no change required duplicate scenario
		                	map<string,Product2> mapCourseIdWithProduct = CommonClass.getCourseIdWithProduct();
		                	integer counter = 0;
		                	String productNotExist = Label.Product_Does_not_exist;
		                	string noChangeReq = Label.No_Change_Required;
		                	
		                	for(Opportunity objOppty : lstOfErrAccopportunity) {
		                		if(objOppty.Name != null && mapCourseIdWithProduct != null && 
		                			mapCourseIdWithProduct.get(objOppty.Name) == null) {
		                			//generating success json if product does not exist in salesforce.warning will be thrown.	
		                			SuccessJson objSuccessOptyJson = new SuccessJson();
		                            objSuccessOptyJson.id =null;
		                            objSuccessOptyJson.objectType = 'Opportunity';
		                            objSuccessOptyJson.success = false;
		                            
		                            objSuccessOptyJson.errors = new list<string>();
		                            objSuccessOptyJson.warnings = new list<string>();
		                            string courseId = 'Opportunity Course Id - '+objOppty.Name;
                            		objSuccessOptyJson.warnings.add(courseId);
		                            objSuccessOptyJson.Errors.add(productNotExist);
		                            lstSuccessJson.add(objSuccessOptyJson);
		                            //lstOfErrAccopportunity.remove(counter);
		                		}
		                		if(objOppty.Opportunity_Status__c != null && objOppty.Opportunity_Status__c == 'No Change Required') {
		                			SuccessJson objSuccessOptyJson = new SuccessJson();
		                            objSuccessOptyJson.id =null;
		                            objSuccessOptyJson.objectType = 'Opportunity';
		                            objSuccessOptyJson.success = false;
		                            
		                            objSuccessOptyJson.errors = new list<string>();
		                            objSuccessOptyJson.warnings = new list<string>();
		                            string courseId = 'Opportunity Course Id - '+objOppty.Name;
                            		objSuccessOptyJson.warnings.add(courseId);
		                            objSuccessOptyJson.Errors.add(noChangeReq);
		                            lstSuccessJson.add(objSuccessOptyJson);
		                            //lstOfErrAccopportunity.remove(counter);
		                		}
		                		counter++;
		                	}
                        }
                      }
                      if(lstErrorJson != null && !lstErrorJson.isEmpty()) {
                            res.responseBody = blob.valueof(Json.serialize(lstErrorJson));
                            
                        }
                        system.debug('lstSuccessJson***'+blob.valueof(Json.serialize(lstSuccessJson)));
                        if(lstSuccessJson != null && !lstSuccessJson.isEmpty()) {
                            res.responseBody = blob.valueof(Json.serialize(lstSuccessJson));
                        }
                
                    
                }
                else {
                    Database.rollback(sp);
                  ErrorResponse objError = new ErrorResponse();
                  objError.message = err.getMessage();
              
                  objError.fields = new list<String>();
                  if(string.valueof(err.getStatusCode()) == 'REQUIRED_FIELD_MISSING') 
                  {
                      string fieldName = string.valueof(err.getFields());
                      
                      objError.fields.add(fieldName);
                  }
                  objError.errorCode = string.valueof(err.getStatusCode());
                  res.responseBody = Blob.valueOf(JSON.serialize(objError));
                  ErrorLogUtility.logError('insertAccountOrOpportunity','parseJson',err,string.valueof(err.getMessage()),'','','','');
                  ErrorLogUtility.commitLog();
                }
                
                
            }
        }
        
        return res;  
    }
}