@isTest
private class LeadAutoConvertTest {
    
    private static testMethod void createLead() {
    
    List<Lead>TestLeadList = New List<Lead>();
        
        Lead ld = new Lead();
        ld.FirstName = 'firstname ';
        ld.LastName = 'lastname ';
        ld.Company = 'company ';
        ld.Status = 'Qualified';
        ld.Phone = '1234567890';
        ld.Email = 'Leadtest@yopmail.com';
        insert ld;
        
        Lead ldtest = [select id,IsConverted from Lead WHERE id =: ld.Id ]; 
        
        system.debug('Lead Details***************'+ld);
        system.debug('Lead Details***************'+ld.IsConverted);   
        
        system.debug('Lead Details***************'+ldtest);
        system.debug('Lead Details***************'+ldtest.IsConverted);       
        
        system.assertEquals(true, ldtest.IsConverted);        
    }
}