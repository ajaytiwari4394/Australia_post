/**
* @author Anjali - Health Cert
* @date 03/04/2018
* @description This Rest resource will take json as input and it will check in system if product is already there
* then product will update otherwise New product will insert.
* @Return - Product id will be sent in response.
**/
@RestResource(urlMapping='/ProductService/*')
global with sharing class ProductWebService {
    
    @HttpPost
    global static void upsertProduct() {
        RestResponse res = RestContext.response; 
        RestRequest req = RestContext.request;
        if(String.isNotEmpty(req.requestBody.toString())) {
            string jsonRequestBody = req.requestBody.toString();
            res = ParseJsonProdRequest.parseProductJson(jsonRequestBody);
        }
    }
}