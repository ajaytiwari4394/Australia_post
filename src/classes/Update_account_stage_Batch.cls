/*
 * Created by Cloud Analogy on 6/26/2019.
 * author:ajay
 * for update the account stage using batch class
 */
global class Update_account_stage_Batch implements Database.Batchable<Account> {

	global Iterable<Account> start(Database.BatchableContext BC) {
		List<Account> accountList = new List<Account>();
		accountList = [Select id, HC_Leader__c,RecordTypeId from Account];
		return accountList;
	}

	global void execute(Database.BatchableContext BC, List<Account> accountList) {
		// process each batch of records
		try {

			List<Account> update_account = new List<Account>();
			List<Opportunity> oppList = new List<Opportunity>();
			map<Id, List<Opportunity>> aacId_VS_Opp = new map<Id, List<Opportunity>>();
			String opp_values = 'AMBER,CAMPBELL,DON,MASTER,OWEN,RICHARD';


			map<id, Account> mapId_VS_Acoount = new map<id, Account>();
			System.debug('-------->' + accountList);
			System.debug('-------->' + accountList.size());

			for (Account acc : accountList) {
				if (!mapId_VS_Acoount.containsKey(acc.Id))
					mapId_VS_Acoount.put(acc.Id, acc);
			}
			 System.debug('map-->'+mapId_VS_Acoount);
			  System.debug('map-->'+mapId_VS_Acoount.keySet());
			  System.debug('map-->'+mapId_VS_Acoount.size() );

			oppList = [SELECT id, HC_Leader__c, AccountId, Name from Opportunity where AccountId in : mapId_VS_Acoount.keySet()
			and HC_Leader__c!=null ORDER BY LastModifiedDate DESC];
			System.debug('Opp List---->'+oppList);
			  System.debug('Opp List---->'+oppList.size());


			for (Opportunity opp : oppList) {
				if (aacId_VS_Opp.containsKey(opp.AccountId)) {
					aacId_VS_Opp.get(opp.AccountId).add(opp);
				} else {
					List<Opportunity> oppList1 = new List<Opportunity>();
					oppList1.add(opp);
					aacId_VS_Opp.put(opp.AccountId, oppList1);
				}
			}
			for(Account acc : accountList) {
				if (aacId_VS_Opp.containsKey(acc.Id)) {
					if (opp_values.contains(aacId_VS_Opp.get(acc.Id).get(0).HC_Leader__c)) {
						System.debug('true--->');
						acc.HC_Leader__c = aacId_VS_Opp.get(acc.Id).get(0).HC_Leader__c;
					} else {
						System.debug('Master--->');
						acc.HC_Leader__c = 'Master';
					}
					update_account.add(acc);
				}
			}

			if(!update_account.isEmpty()){

					update update_account;
			}
		} catch (Exception ex) {
			System.debug('Get exception on line number -->' + ex.getLineNumber() + 'because of -->' + ex.getCause() +
					'::  Message-->' + ex.getMessage());
		}

	}

	global void finish(Database.BatchableContext BC) {
		// execute any post-processing operations
	}

}