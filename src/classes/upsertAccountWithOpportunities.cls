/**
* @author Priyank - Health Cert
* @date 26/09/2017
*
* @group Opportunity
* @group-content ../../ApexDocContent/Opportunity.htm
*
* @description This Rest resource will take json as input and it will check in system if Opportunity is already there
* then Opportunity will update otherwise New Opportunity will insert.
* @Return - Opportunity id will be sent in response.
**/

@RestResource(urlMapping='/OpportunityService/*')
global with sharing class upsertAccountWithOpportunities {

    @HttpPost
    global static void upsertAccount() {
       RestResponse res = RestContext.response; 
       RestRequest req = RestContext.request;
       if(String.isNotEmpty(req.requestBody.toString())) {
            
            string jsonRequestBody = req.requestBody.toString();
            res = ParseOpportunityJsonRequest.parseJson(jsonRequestBody);
            
       }
    }
}