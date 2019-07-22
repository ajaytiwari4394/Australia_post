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

			oli=[select Name,OpportunityId,Opportunity.Account.PersonContactId,Product2Id from OpportunityLineItem where OpportunityId=:opportunity_id limit 1];

			if(!oli.isEmpty()) {

				certificate_name =
						[Select Certificate_Template_Name__c, Name from Product2 where id =: oli[0].Product2Id limit 1].Certificate_Template_Name__c;

				if (certificate_name != '') {
					// if you want to update string in salesforce
					String n = 'Certification';
					System.debug('certificate name ---->' + certificate_name);

					template = [Select APXTConga4__Name__c, id from APXTConga4__Conga_Template__c where APXTConga4__Name__c=:n];
					System.debug('n--->' + template);


					if(!template.isEmpty()){
						String servUrl = Url.getSalesforceBaseUrl().toExternalForm() + '/services/Soap/u/29.0/' +
								UserInfo.getOrganizationId();

						String url2 = 'https://composer.congamerge.com/composer8/index.html' +
								'?sessionId=' + sessId +
								'&serverUrl=' + EncodingUtil.urlEncode(servUrl, 'UTF-8') +
								'&id=' + opportunity_id +
								'&TemplateId=a0f0l000001APgs,'+template[0].id +
								'&SC0=1' +
								'&SC1=Attachments' +
								'&FP0=1' +
								'&DS7=1' +
								'&DefaultPDF=1&APIMode=1&ZipPDFs=1';

						System.debug('-----url2--->'+url2);

						Http http = new Http();
						HttpRequest req = new HttpRequest();
						req.setEndpoint(url2);
						req.setMethod('GET');
						req.setTimeout(60000);

						//que the request, and return a response
						HttpResponse res = http.send(req);

						System.debug('Response ---==>');
						System.debug(res);

						system.debug('::::' + res.getStatus() + ' => ' + res.getBody());

						Attachment att = [Select id,Name, Body From Attachment Where id =: res.getBody()];
						system.debug(att.Body);


						List<String> attachId=new List<String>();
						attachId.add(att.id);
						//attachId.add('00P0l000002NvDZ');

						// mail send code
						EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName ='Email_Test'];

						system.debug('person contact id ---->'+oli[0].Opportunity.Account.PersonContactId);
						system.debug('Email template id -->'+et);

						Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
						mail.setTemplateId(et.Id);
						//mail.setSubject('test subject');
						mail.setTargetObjectId(oli[0].Opportunity.Account.PersonContactId);
						mail.setSaveAsActivity(false);
						mail.setEntityAttachments(attachId);


						List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
						allmsg.add(mail);
						list<Messaging.SendEmailResult> results = Messaging.sendEmail(allmsg);
						//mail send code end
						return 'true-->';
					}

				}

				//return sessId;
			}//oli check end
			return null;
		} catch(Exception ex)
		{
			System.debug('get Exception on Line Number >>'+ex.getLineNumber()+'because of :::'+ex.getMessage());
			return null;

		}
	}

	//sned mail for print the certificate
	webservice static String send_certifiacte_Print(String opportunity_id){
		try{
			System.debug('Id---->OpportunityId--->'+opportunity_id);
			String sessId = UserInfo.getSessionId();
			System.debug('sessId---->sessId--->'+sessId);
			String certificate_name='';

			List<OpportunityLineItem> oli=new List<OpportunityLineItem>();
			List<APXTConga4__Conga_Template__c> template =new List<APXTConga4__Conga_Template__c>();

			oli=[select Name,OpportunityId,Opportunity.Account.PersonContactId,Product2Id from OpportunityLineItem where OpportunityId=:opportunity_id limit 1];

			if(!oli.isEmpty()) {

				certificate_name =
						[Select Certificate_Template_Name__c, Name from Product2 where id =: oli[0].Product2Id limit 1].Certificate_Template_Name__c;

				if (certificate_name != '') {
					// if you want to update string in salesforce
					String n = 'Certification';
					System.debug('certificate name ---->' + certificate_name);

					template = [Select APXTConga4__Name__c, id from APXTConga4__Conga_Template__c where APXTConga4__Name__c=:n];
					System.debug('n--->' + template);


				/*	if(!template.isEmpty()){
						String servUrl = Url.getSalesforceBaseUrl().toExternalForm() + '/services/Soap/u/29.0/' +
								UserInfo.getOrganizationId();

						String url2 = 'https://composer.congamerge.com/composer8/index.html' +
								'?sessionId=' + sessId +
								'&serverUrl=' + EncodingUtil.urlEncode(servUrl, 'UTF-8') +
								'&id=' + opportunity_id +
								'&TemplateId=+template[0].id +
								'&SC0=1' +
								'&SC1=Attachments' +
								'&FP0=1' +
								'&DS7=1' +
								'&DefaultPDF=1&APIMode=1&ZipPDFs=1';

						System.debug('-----url2--->'+url2);

						Http http = new Http();
						HttpRequest req = new HttpRequest();
						req.setEndpoint(url2);
						req.setMethod('GET');
						req.setTimeout(60000);

						//que the request, and return a response
						HttpResponse res = http.send(req);

						System.debug('Response ---==>');
						System.debug(res);

						system.debug('::::' + res.getStatus() + ' => ' + res.getBody());

						Attachment att = [Select id,Name, Body From Attachment Where id =: res.getBody()];
						system.debug(att.Body);


						List<String> attachId=new List<String>();
						attachId.add(att.id);
						//attachId.add('00P0l000002NvDZ');

						// mail send code
						EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName ='Email_Test'];

						system.debug('person contact id ---->'+oli[0].Opportunity.Account.PersonContactId);
						system.debug('Email template id -->'+et);

						Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
						mail.setTemplateId(et.Id);
						//mail.setSubject('test subject');
						mail.setTargetObjectId(oli[0].Opportunity.Account.PersonContactId);
						mail.setSaveAsActivity(false);
						mail.setEntityAttachments(attachId);


						List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
						allmsg.add(mail);
						list<Messaging.SendEmailResult> results = Messaging.sendEmail(allmsg);
						//mail send code end
						return 'true-->';
					}*/

				}

				//return sessId;
			}//oli check end
			return null;
		} catch(Exception ex)
		{
			System.debug('get Exception on Line Number >>'+ex.getLineNumber()+'because of :::'+ex.getMessage());
			return null;

		}
	}


}