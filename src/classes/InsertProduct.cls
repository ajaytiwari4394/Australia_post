public class InsertProduct
{
  public static map<string,Product2> getCourseIdWithProductMap(List<Product2> prodList) {
      Set<String> setOfProdIds = new Set<String>();
         map<string,Product2> mapCourseIdWithProduct = new map<string,Product2>();
      if(prodList!=null){
         for(Product2 objProd:prodList ){
             if(objProd!=null){
             if(objProd.Course_ID__c!=null){
                 setOfProdIds.add(objProd.Course_ID__c);
             mapCourseIdWithProduct.put(objProd.Course_ID__c,null);
         }
         }
         }
      list<Product2> lstProductData = [Select id, Course_id__c ,isActive, Name FROM Product2 where isActive=true and course_id__c in :setOfProdIds];
    if(lstProductData != null && !lstProductData.isEmpty()) {
            system.debug('lstProductData'+lstProductData);
        for(Product2 objProd : lstProductData) {
          if(objProd.Course_ID__c != null && mapCourseIdWithProduct.get(objProd.Course_ID__c) == null) {
            mapCourseIdWithProduct.put(objProd.Course_ID__c,objProd);
          } 
        }
      }
      }
      
      return mapCourseIdWithProduct;
    }
    

       public static Map<String, product2> getDuplicateProductIdsMap(list<Product2> newProductList) 
    { 
        Integer listSize= newProductList.size();
        Map<String, product2> mapOfCourseIdWithDupProducts = new Map<String, product2>(); //map of course id with products
        set<String> setOfProductIds= new Set<String>();
        if(newProductList!=null ){
        for(Product2 objProduct : newProductList )
        {
           if(objProduct!=null) 
            setOfProductIds.add(objProduct.Course_Id__c);
        }
        for(Product2 objProduct : newProductList )
        {
                       
           if(objProduct!=null) 

            mapOfCourseIdWithDupProducts.put(objProduct.Course_ID__c,null);
        }
        }
        list<Product2> existingProductList= [Select isActive, Name,Course_ID__c ,id from Product2 where Course_ID__c = :setOfProductIds];
        if(existingProductList!=null && existingProductList.size() > 0  )
        {
            for(Product2 objExistedProduct :existingProductList)
            {
                if(mapOfCourseIdWithDupProducts.get(objExistedProduct.Course_ID__c)==null)
                {
                    mapOfCourseIdWithDupProducts.put(objExistedProduct.Course_ID__c,objExistedProduct);
                }
          }
      }  
     return mapOfCourseIdWithDupProducts;
  }
    
    //checking the duplicate product and doing dml operation accordingly
    public static RestResponse parseJson(list<sObject> objProductlist) 
    {
        list<Database.UpsertResult> LstDatabaseUpsertProductresult;
        Product2 objProd;
        RestResponse res;
        if(test.isRunningTest())
            res = new RestResponse(); 
        else
            res = RestContext.response;
        Savepoint sp = Database.setSavepoint();
        list<SuccessJson> lstSuccessJson = new list<SuccessJson>();
        list<ErrorResponse> lstErrorJson = new list<ErrorResponse>();
       // ManageDuplicate manageduplicateProd = new ManageDuplicate();
        List<Product2> lstProductToInsert = new list<Product2>();
        Set<id> dupProductIds = new Set<id>();
        Map<String, product2> mapOfidwithdupProductIds = new Map<String, product2>();
        List<Product2> castProducts = new List<Product2>();
        for(Sobject obj: objProductlist)
        {
            Product2 obj1=  (Product2)obj;
            castProducts.add(obj1);
        }

        map<String, Product2> mapOfNewProd= new Map<String, Product2>();
        if(castProducts!=null && castProducts.size()>0){
        for(Product2 objPro: castProducts)
        {
            if(objPro!=null){
            mapOfNewProd.put(objPro.Course_ID__c,objPro);
        }
        }
        }
        mapOfidwithdupProductIds = getDuplicateProductIdsMap(castProducts);
        map<string,Product2> mapCourseIdWithProduct = getCourseIdWithProductMap(castProducts);
        if(mapOfidwithdupProductIds!=null)
        {
            for(String courseids:mapOfidwithdupProductIds.keySet() )
            {
                objProd = mapOfidwithdupProductIds.get(courseids);
                system.debug('Product objProd'+objProd);
                if( objProd!=null && objProd.Course_ID__c != null && mapCourseIdWithProduct.get(objProd.Course_ID__c) == null) 
                {
                    //generating success json if product exists in salesforce.warning will be thrown.  
                    SuccessJson objSuccessProductJson = new SuccessJson();
                    objSuccessProductJson.id =objProd.id;
                    objSuccessProductJson.objectType = 'Product2';
                    objSuccessProductJson.success = true;
                    objSuccessProductJson.errors = new list<string>();
                    objSuccessProductJson.warnings = new list<string>();
                    string InActiveproductExists='product already exists with inactive status. Updated successfully';
                    objProd.isActive=true;
                    objProd.Early_Bird__c=mapOfNewProd.get(objProd.Course_ID__c).Early_Bird__c;
                    objProd.Early_Price__c=mapOfNewProd.get(objProd.Course_ID__c).Early_Price__c;
                    objProd.Description=mapOfNewProd.get(objProd.Course_ID__c).Description;
                    objProd.Family=mapOfNewProd.get(objProd.Course_ID__c).Family;
                    objProd.Full_Price__c=mapOfNewProd.get(objProd.Course_ID__c).Full_Price__c;
                    objProd.Name=mapOfNewProd.get(objProd.Course_ID__c).Name;
                    objProd.ProductCode=mapOfNewProd.get(objProd.Course_ID__c).ProductCode;
                    objProd.Location__c=mapOfNewProd.get(objProd.Course_ID__c).Location__c;
                    objProd.ShortName__c=mapOfNewProd.get(objProd.Course_ID__c).ShortName__c;
                    objProd.DisplayUrl=mapOfNewProd.get(objProd.Course_ID__c).DisplayUrl;  
                    
                    lstProductToInsert.add(objProd);
                    objSuccessProductJson.warnings.add(InActiveproductExists);
                    
                    lstSuccessJson.add(objSuccessProductJson);
                }
                else if(objProd!=null && objProd.Course_ID__c != null && mapCourseIdWithProduct != null && mapCourseIdWithProduct.get(objProd.Course_ID__c) != null ) 
                {
                    SuccessJson objSuccessProductJson = new SuccessJson();
                    objSuccessProductJson.id =objProd.id;
                    objSuccessProductJson.objectType = 'Product2';
                    objSuccessProductJson.success = false;
                    objSuccessProductJson.errors = new list<string>();
                    objSuccessProductJson.warnings = new list<string>();
                    string ActiveproductExists = 'Product already exists with active status - '+objProd.Course_ID__c;
                    objSuccessProductJson.Errors.add(ActiveproductExists);
                    lstSuccessJson.add(objSuccessProductJson);
                }
                else 
                {                   
                    lstProductToInsert.add(mapOfNewProd.get(courseids));
                }
            }
        }
        else
        {
            lstProductToInsert.addAll(castProducts);
        }
        try
        {
            LstDatabaseUpsertProductresult = Database.upsert(lstProductToInsert, false);
        }
        catch(Exception e)
        {
            system.debug('exception thrown ----- data upsert'+ e.getMessage());
        }
        if(LstDatabaseUpsertProductresult!=null)
        {
            for(Database.UpsertResult objProductUpsertResult : LstDatabaseUpsertProductresult) 
            {
                if(objProductUpsertResult.isSuccess()) 
                {
                    SuccessJson objSuccessProductJson = new SuccessJson();
                    objSuccessProductJson.id =objProductUpsertResult.getId();
                    objSuccessProductJson.objectType = 'Product2';
                    objSuccessProductJson.success = true;
                    objSuccessProductJson.errors = new list<string>();
                    objSuccessProductJson.warnings = new list<string>();
                    if (objProductUpsertResult.isCreated()) 
                    {
                        lstSuccessJson.add(objSuccessProductJson);          
                    }
                }
                else 
                {
                    for(Database.Error err : objProductUpsertResult.getErrors()) 
                    {
                        Database.rollback(sp);
                        ErrorResponse objError = new ErrorResponse();
                        objError.message = err.getMessage();
                        objError.fields = new list<String>();
                        if(string.valueof(err.getStatusCode()) == 'REQUIRED_FIELD_MISSING') 
                        {
                            string fieldName = string.valueof(err.getFields());
                            objError.fields.add(fieldName);
                        }
                        if((string.valueof(err.getStatusCode())).contains('Duplicate value on record')){
                            string fieldName = string.valueof(err.getFields());
                            objError.fields.add(fieldName);
                        }
                        objError.errorCode = string.valueof(err.getStatusCode());
                        res.responseBody = Blob.valueOf(JSON.serialize(objError));
                        ErrorLogUtility.logError('insertProduct','parseJson',err,string.valueof(err.getMessage()),'','','','');
                        ErrorLogUtility.commitLog();
                        lstErrorJson.add(objError);
                    }  
                }
            }
        }
        if(lstErrorJson != null && !lstErrorJson.isEmpty() && lstSuccessJson != null && !lstSuccessJson.isEmpty()) 
        {
            blob success=  blob.valueof(Json.serialize(lstSuccessJson));
            blob error=  blob.valueof(Json.serialize(lstErrorJson));
            String combinedDataAsHex = EncodingUtil.convertToHex(success) + EncodingUtil.convertToHex(error);
            Blob combinedDataAsBlob = EncodingUtil.convertFromHex(combinedDataAsHex);
            res.responseBody = combinedDataAsBlob;
        }
        else if(lstErrorJson != null && !lstErrorJson.isEmpty()) 
        {
            res.responseBody = blob.valueof(Json.serialize(lstErrorJson));
        }
        else if(lstSuccessJson != null && !lstSuccessJson.isEmpty()) 
        {
            res.responseBody = blob.valueof(Json.serialize(lstSuccessJson));
        }
        return res;  
    }
}