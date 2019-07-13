public with sharing class Opportunity_Notes_RelatedList_Class {

   public List<notes__c> noteslist{get;set;} 

    public opportunity opportunitys {get;set;} 

    public opportunity opp {get;set;} 

     

    //Constructor 

    public opportunity_Notes_RelatedList_Class (ApexPages.StandardController controller) { 

        opp = (opportunity)controller.getRecord();      

        opportunitys = [SELECT id,name FROM opportunity WHERE id=: opp.id LIMIT 1]; 

        noteslist = [SELECT id,Name,body__c,OwnerId,CreatedDate,Owner.name FROM notes__c WHERE opportunity__c = :opportunitys.id ORDER BY CreatedDate DESC];     

} 

    //This method is to create a new notes__c while clicking on the Add notes__c button 

    public pageReference newnotes(){  

        pageReference pageRef = new pageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/a05/e?CF00N7F00000CirVd='+ opportunitys.name +'&CF00N7F00000CirVd_lkid='+ opportunitys.id+'&retURL=%2F'+ opportunitys.id); 

        return pageRef; 

    } 

    //This method is to edit the existing notes__c record while clicking the Edit link 

    public pageReference editnotes(){  

        String notesId = Apexpages.currentpage().getParameters().get('notes__cId');  

        pageReference pageRef = new pageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + notesId + '/e?retURL=' + opportunitys.id);  

        return pageRef;  

    }    


 //This method is to delete the notes__c record while clicking the Del link 

    public pageReference deletenotes(){  

        String notesId = Apexpages.currentpage().getParameters().get('notes__cId');  

        notes__c notesList = [SELECT Id FROM notes__c WHERE id = : notesId LIMIT 1]; 

        delete notesList; 

        String baseUrl = URL.getSalesforceBaseUrl().toExternalForm(); 

        PageReference redirectPage = new PageReference(baseUrl+'/'+opportunitys.id); 

        return redirectPage;  

    }   


}