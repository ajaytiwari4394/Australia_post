public with sharing class Account_Notes_RelatedList_Class {

public List<notes__c> noteslist{get;set;} 

    public Account accounts {get;set;} 

    public Account acc {get;set;} 

     

    //Constructor 

    public Account_Notes_RelatedList_Class (ApexPages.StandardController controller) { 

        acc = (account)controller.getRecord(); 
            

        accounts = [SELECT id,name FROM account WHERE id=: acc.id LIMIT 1]; 
         

        noteslist = [SELECT id,Name,body__c,OwnerId,CreatedDate,Owner.name FROM notes__c WHERE account__c = :accounts.id ORDER BY CreatedDate DESC]; 
             

} 

    //This method is to create a new notes__c while clicking on the Add notes__c button 

    public pageReference newnotes(){  

        pageReference pageRef = new pageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/a05/e?CF00N7F00000CirVY='+ accounts.name +'&CF00N7F00000CirVY_lkid='+ accounts.id+'&retURL=%2F'+ accounts.id); 

        return pageRef; 

    } 

    //This method is to edit the existing notes__c record while clicking the Edit link 

    public pageReference editnotes(){  

        String notesId = Apexpages.currentpage().getParameters().get('notes__cId'); 
       

        pageReference pageRef = new pageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + notesId + '/e?retURL=' + accounts.id);  

        return pageRef;  

    }    


 //This method is to delete the notes__c record while clicking the Del link 

    public pageReference deletenotes(){  

        String notesId = Apexpages.currentpage().getParameters().get('notes__cId'); 
      
        
         
        notes__c notesList = [SELECT Id FROM notes__c WHERE id = : notesId LIMIT 1]; 
       
        delete notesList; 
       
       
        

        String baseUrl = URL.getSalesforceBaseUrl().toExternalForm(); 

        PageReference redirectPage = new PageReference(baseUrl+'/'+accounts.id); 

        return redirectPage;  

    }   

}