public class InitializeSobjectInstance {
    
    private static list<sobject> lstSobject = null;
    
    private static Sobject objSobjectInstance = null;
    
    private static Sobject objOpportunityInstance = null;
    /*
    public static list<sobject> getListInstance(string sobjectType) {
       // lazy load the record type - only initialize if it doesn't already exist
       if (lstSobject == null) lstSobject = new List<SObject>();//lstSobject = (List<SObject>)Type.forName(sobjectType).newInstance();
       return lstSobject;
   }
   */
   public static sobject getObjectInstance(string sobjectType) {
       // lazy load the record type - only initialize if it doesn't already exist
       if (objSobjectInstance == null) objSobjectInstance = Schema.getGlobalDescribe().get(sobjectType).newSObject() ;
       return objSobjectInstance;
   }
   
   public static sobject getOpportunityInstance(string sobjectType) {
       // lazy load the record type - only initialize if it doesn't already exist
       if (objOpportunityInstance == null) objOpportunityInstance = Schema.getGlobalDescribe().get(sobjectType).newSObject() ;
       return objOpportunityInstance;
   }
   
}