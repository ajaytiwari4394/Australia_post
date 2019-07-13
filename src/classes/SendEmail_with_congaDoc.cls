/*
 * Created by Cloud Analogy on 7/4/2019.
 */
global class SendEmail_with_congaDoc {
	webservice static String send_certifiacte(String opportunity_id){
		try{
			System.debug('Id---->OpportunityId--->'+opportunity_id);
			String sessId = UserInfo.getSessionId();
			System.debug('sessId---->sessId--->'+sessId);
			String certificate_name='';

			List<OpportunityLineItem> oli=new List<OpportunityLineItem>();
			List<APXTConga4__Conga_Template__c> template =new List<APXTConga4__Conga_Template__c>();

			oli=[select Name,OpportunityId,Product2Id from OpportunityLineItem where OpportunityId=:opportunity_id limit 1];

			if(!oli.isEmpty()){

				certificate_name=[Select Certificate_Template_Name__c,Name from Product2 where id =: oli[0].Product2Id limit 1].Certificate_Template_Name__c;

				if(certificate_name!=''){
					// if you want to update string in salesforce
					String n='Certification';
					System.debug('certificate name ---->'+certificate_name);

					template=[Select APXTConga4__Name__c ,id from APXTConga4__Conga_Template__c where  APXTConga4__Name__c=:n];
					System.debug('n--->'+template);


				}
			}

			String servUrl = Url.getSalesforceBaseUrl().toExternalForm()+'/services/Soap/u/29.0/'+UserInfo.getOrganizationId();

			String url2 = 'https://composer.congamerge.com/composer8/index.html'+
					'?sessionId='+sessId+
					'&serverUrl='+EncodingUtil.urlEncode(servUrl, 'UTF-8')+
					'&id='+opportunity_id+
					'&TemplateId=a0f0l000001AL7m'+
					'&SC0=1'+
					'&SC1=Attachments'+
					'&FP0=1'+
					'&DS7=1'+
					'&DefaultPDF=1&APIMode=1';

			System.debug(url2);

			Http http = new Http();
			HttpRequest req = new HttpRequest();
			req.setEndpoint(url2);
			req.setMethod('GET');
			req.setTimeout(60000);

			// Send the request, and return a response
			HttpResponse res = http.send(req);

			System.debug(res);

			system.debug('::::'+ res.getStatus() + ' => ' + res.getBody());

			Attachment att = [Select Name, Body From Attachment Where id =: res.getBody()];
			system.debug(att.Body);

			return 'hii';
			//return sessId;

		} catch(Exception ex)
		{
			System.debug('get Exception on Line Number >>'+ex.getLineNumber()+'because of :::'+ex.getMessage());
			return null;

		}
	}
}