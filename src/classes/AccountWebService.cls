/**
* @author Priyank - Health Cert
* @date 26/09/2017
*
* @group Accounts
* @group-content ../../ApexDocContent/Accounts.htm
*
* @description This Rest resource will take json as input and it will check in system if account is already there
* then account will update otherwise New account will insert.
* @Return - Account id will be sent in response.
**/

@RestResource(urlMapping='/AccountService/*')
global with sharing class AccountWebService {

    @HttpPost
    global static void upsertAccount() {
       RestResponse res = RestContext.response; 
       RestRequest req = RestContext.request;
       if(String.isNotEmpty(req.requestBody.toString())) {
            
            string jsonRequestBody = req.requestBody.toString();
            res = ParseJsonRequest.parseJson(jsonRequestBody);
       }
    }
}