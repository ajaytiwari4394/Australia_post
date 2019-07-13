public class UpdateOpportunity_Helper {
    
    public static void updateOpportunityField(map<id,opportunity> newoppmap,map<id,opportunity> oldoppmap, list<opportunity> opportunitylist) {
        try {
            system.debug('updateOpportunityField>>>>>>>>>>>>>>');
            
            string allname = '';
            
            List<Messaging.SingleEmailMessage > singleEmailMessageList=new List<Messaging.SingleEmailMessage>();
            OpportunityEmail__c mc = OpportunityEmail__c.getOrgDefaults();
            
            set <id>  accid = new set <id>();
            
            for(opportunity objopp : opportunitylist){
                
                if(objopp.AccountId!=null){
                    
                    accid.add(objopp.AccountId);
                    
                }
                
            }
            
            system.debug('OpportunityEmail__c>>>>>>>>>>>>'+mc.Email__c);
            
            map<id,string> accmap = new map <id,string>();
            
            list <opportunity> opplist = [select accountid,opportunity.account.name from opportunity where accountid in : accid];
            
            for (opportunity oppObj : opplist){
                
                if(oppObj.AccountId!=null){
                    
                    accmap.put(oppObj.AccountId,oppObj.account.name);
                }
                
            }
            
            for (opportunity objopp : opportunitylist) {
                
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                
                if (oldoppmap.containsKey(objopp.Id) &&
                    newoppmap.get(objopp.Id).HC_Leader__c != oldoppmap.get(objopp.Id).HC_Leader__c) {
                        
                        allname = oldoppmap.get(objopp.Id).HC_Leader__c +'\n' +newoppmap.get(objopp.Id).HC_Leader__c +'\n'+ UserInfo.getName() +'\n'+ accmap.get(objopp.AccountId) +'\n'+ URL.getSalesforceBaseUrl().toExternalForm() +'/' + objopp.id;
                        
                        system.debug('allname>>>>>>>>>>>>'+allname);
                        
                        string htmlbody = 'Changed from: ' + oldoppmap.get(objopp.Id).HC_Leader__c + '<br/><br/>'+ 'Change to: '+ newoppmap.get(objopp.Id).HC_Leader__c+'<br/><br/>' + 'Changed by: ' +  UserInfo.getName()+'<br/><br/>' + 'Account Name: ' +  accmap.get(objopp.AccountId)+'<br/><br/>' + 'Opportunity Record - URL: ' +  URL.getSalesforceBaseUrl().toExternalForm() +'/' + objopp.id;
                        email.setHtmlBody(htmlBody);
                        email.setSubject('HC Leader Change Update');
                        email.setToAddresses(new List<String>{mc.Email__c});
                        singleEmailMessageList.add(email);
                    }
                
            }
            Messaging.SendEmailResult [] r = Messaging.sendEmail(singleEmailMessageList);
            System.debug('Result----'+r);
            
            
        }
                
        catch (Exception e) {
            
            system.debug('Error>>>>>>>>>>>' + e.getMessage() + 'At line number>>>>>>>>>>' + e.getLineNumber());
        }
    }
}