/*
    This is the common class in which we insert all object record.
    =================================================================================
    Created By                          Date                            Version
    =================================================================================
    Lav Singh                        24-10-2017                           1.0

*/
public class commonClassTracker
{
    public static account accountRecord(string objFirstName,string objLastName,string objPhone,string objPersonEmail,string ObjSalutation,string objphoneType,string objWebId,Date objRegistrationDate,string objMoodleUser,string objMoodlePass,string objProfession,string objCategory,string syncWithHubspot)
    {
        Account objAccount = new Account();
        objAccount.FirstName =objFirstName; 
        objAccount.LastName =objLastName;  
        objAccount.Phone =objPhone;  
        objAccount.PersonEmail =objPersonEmail;  
        objAccount.Salutation =ObjSalutation;  
        objAccount.Phone_Type__c =objphoneType;  
        objAccount.WEB_ID__c =objWebId;  
        objAccount.Registration_Date__c = objRegistrationDate;  
        objAccount.MoodleUser__c =objMoodleUser;  
        objAccount.MoodlePass__c =objMoodlePass;  
        objAccount.Profession__c =objProfession;
        objAccount.Sync_With_HubSpot__c =syncWithHubspot; 
        return objAccount;
    }
    public static opportunity opportunityRecord(string objName,Boolean objcreatedbyapi,string objStageName,Date closeDate,Integer ObjRevenue,string objOppStatus,string objCoursesInterested,string objconfWorkshop,string objWorkbookFormat,string objSourceofinquery,string objcoursecode,string objpaymentMethod,string objpaymentStatus,string objLeadsourse,string objPartnerMarketing,string objOpportunityUTM)
    {
        Opportunity objOpportunity = new Opportunity();
        objOpportunity.Name =objName;
        objOpportunity.Created_by_Api__c =objcreatedbyapi;
        objOpportunity.StageName =objStageName;
        objOpportunity.CloseDate =closeDate;
        objOpportunity.Revenue__c =ObjRevenue;
        objOpportunity.OppStatus__c =objOppStatus;
        objOpportunity.Courses_Interested_In__c =objCoursesInterested;
        objOpportunity.Conf_Workshop_1__c =objconfWorkshop;
        objOpportunity.WorkbookFormat__c =objWorkbookFormat;
        objOpportunity.Source_of_Enquiry_or_Registration__c =objSourceofinquery;
        objOpportunity.Course_Code__c =objcoursecode;
        objOpportunity.Payment_Method__c =objpaymentMethod;
        objOpportunity.Payment_Status__c =objpaymentStatus;
        objOpportunity.LeadSource =objLeadsourse;
        objOpportunity.PartnerMarketing__c =objPartnerMarketing;
        objOpportunity.Opportunity_UTM__c =objOpportunityUTM;
        return objOpportunity;
    }
    public static Json_Key_Object_Field_mapping__c objJsonKeyObjectfieldMappingRecord(string objName,string objDataType,string objObjectName,string objSFFieldApi)
    {
        Json_Key_Object_Field_mapping__c objJsonmapping = new Json_Key_Object_Field_mapping__c();
        objJsonmapping.Name = objName;
        objJsonmapping.Data_Type__c =objDataType;
        objJsonmapping.Object_Name__c =objObjectName;
        objJsonmapping.SF_Field_Api__c =objSFFieldApi;
        return objJsonmapping;
    }
    
    
   public static Product2 productRecord(string objProductName,String objCourseID,String objProductCode,Decimal objFullPrice,String objDescription,String objFamily,Boolean objIsActive)
    {
        Product2 objProduct = new Product2();
        objProduct.Name =objProductName;
        objProduct.Course_ID__c=objCourseID;
         objProduct.Description=objDescription;
            objProduct.Family=objFamily;
            objProduct.IsActive=objIsActive;
            objProduct.ProductCode=objProductCode;
            objProduct.Full_Price__c=objFullPrice;
            return objProduct;
    }
    
    public static PriceBookEntry addProductToPriceBook(Product2 objProduct)
    {
        
 Id pricebookId = Test.getStandardPricebookId();
        PriceBookEntry pbe=new PriceBookEntry();

        pbe.Product2Id=objProduct.id;
            pbe.Pricebook2Id= pricebookId;
            pbe.UnitPrice=objProduct.Full_Price__c;
            pbe.Early_Bird__c=objProduct.Early_Bird__c;
            pbe.Early_Price__c=objProduct.Early_Price__c;
            pbe.IsActive=true;
        
        return pbe;
    }
    
}