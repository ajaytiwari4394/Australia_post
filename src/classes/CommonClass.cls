public class CommonClass {
    // -----------------------------------------------------------------------------------------------------------------
    // This Static method returns the comma separated fields for given object API Name
    // -----------------------------------------------------------------------------------------------------------------
    // INPUT PARAMETERS:    - String - objectAPIName
    // -----------------------------------------------------------------------------------------------------------------
    //                      
    // ----------------------------------------------------------------------------------------------------------------- 
    // RETURNS:             - Id - recordTypeId
    // -----------------------------------------------------------------------------------------------------------------
    // Version#     Date                    Author                          Description
    // -----------------------------------------------------------------------------------------------------------------
    // 1.0         06-Sept-2017           Priyank Rajvanshi                Initial Version
    // -----------------------------------------------------------------------------------------------------------------
    public static string getSobjectFields(String sobjectName) {
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(sobjectName).getDescribe().fields.getMap();
        
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()) {
           if(fieldMap.get(fieldName).getDescribe().isAccessible()) {
                    
               if(commaSepratedFields == null || commaSepratedFields == '') {
                    commaSepratedFields = 'select '+fieldName;
                }
                else {
                    commaSepratedFields = commaSepratedFields + ', ' + fieldName;
                }
            }
           
        }
        
        return commaSepratedFields;
    }
    // -----------------------------------------------------------------------------------------------------------------
    // This Static method returns the record type Id for given object API Name & RecordType Name 
    // -----------------------------------------------------------------------------------------------------------------
    // INPUT PARAMETERS:    - String - objectAPIName
    // -----------------------------------------------------------------------------------------------------------------
    //                      - String - recordTypeName
    // ----------------------------------------------------------------------------------------------------------------- 
    // RETURNS:             - Id - recordTypeId
    // -----------------------------------------------------------------------------------------------------------------
    // Version#     Date                    Author                          Description
    // -----------------------------------------------------------------------------------------------------------------
    // 1.0         06-Sept-2017           Priyank Rajvanshi                Initial Version
    // -----------------------------------------------------------------------------------------------------------------
    public static id GetRecordTypeId(string objectAPIName, string recordTypeName){
        if(IsNullOrEmptyString(objectAPIName) || IsNullOrEmptyString(recordTypeName)){
            return null;
        }
        Map<String, Schema.SObjectType> sobjectSchemaMap;
        if(sobjectSchemaMap == null)
        {
            sobjectSchemaMap = Schema.getGlobalDescribe();
        }
        Schema.SObjectType sObjType = sobjectSchemaMap.get(objectAPIName) ;
        Schema.DescribeSObjectResult cfrSchema = sObjType.getDescribe() ;
        Map<String,Schema.RecordTypeInfo> RecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id recordTypeId = RecordTypeInfo.get(recordTypeName).getRecordTypeId();
        return recordTypeId;
    }
    
    // -----------------------------------------------------------------------------------------------------------------
    // This Static method is used to validate null or Empty String 
    // -----------------------------------------------------------------------------------------------------------------
    // INPUT PARAMETERS:    - string    - strInput
    // -----------------------------------------------------------------------------------------------------------------
    // RETURNS:             - boolean   - true/false
    // -----------------------------------------------------------------------------------------------------------------
    // Version#     Date                    Author                          Description
    // -----------------------------------------------------------------------------------------------------------------
    // 1.0         06-Sept-2017           Priyank Rajvanshi                Initial Version
    // -----------------------------------------------------------------------------------------------------------------
    public static boolean IsNullOrEmptyString(string strInput){
        if(strInput == null || strInput.equals('')){
            return true;
        }
        return false;
    }
    
    public static Map<String, Schema.SObjectField> getSobjectFieldMap(String sobjectName) 
    {
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(sobjectName).getDescribe().fields.getMap();
        return fieldMap;
    }
    
    public static map<string,Product2> getCourseIdWithProduct() {
    	string queryOnProduct = getSobjectFields('Product2');
    	queryOnProduct += ' FROM Product2 where isActive=true';
    	List<Product2> lstProductData = database.query(queryOnProduct);
    	map<string,Product2> mapCourseIdWithProduct = new map<string,Product2>();
    	
    	if(lstProductData != null && !lstProductData.isEmpty()) {
    		for(Product2 objProd : lstProductData) {
    			if(objProd.Course_ID__c != null && mapCourseIdWithProduct.get(objProd.Course_ID__c) == null) {
    				mapCourseIdWithProduct.put(objProd.Course_ID__c,objProd);
    			} 
    		}
    	}
    	return mapCourseIdWithProduct;
    }
}