public class LeadAutoConvertHelper {
    
        public static void ConvertLeadHelperMethod(List<Lead> LeadsFromTrigger){
        
        LeadStatus convertStatus = [SELECT MasterLabel FROM LeadStatus where IsConverted = true LIMIT 1];
        
        List<Database.LeadConvert> LeadConvertList = new List<Database.LeadConvert>(); 
        
        for(lead ld : LeadsFromTrigger){
            if(!ld.IsConverted ){ //&& ld.Status == 'Qualified'){ // after this change every new lead will get converted automatically
                Database.LeadConvert LC = new Database.LeadConvert();
                
                String OppName = ld.Name + 'Opportunity';
                
                LC.setLeadId(ld.id);
                //LC.setOpportunityName(OppName);
                LC.setDoNotCreateOpportunity(true); // this is to avoid Opportunity creation
                LC.setConvertedStatus(convertStatus.MasterLabel);
                
                LeadConvertList.add(LC);
            }
        }
        
        if(!LeadConvertList.isEmpty()){
            List<Database.LeadConvertResult> lcr = Database.convertLead(LeadConvertList);    
        } 
    }
}