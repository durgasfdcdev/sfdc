@isTest
public class JobPostingTriggerHandlerTest {
    
    @isTest static void Testupdatestatusfield() {
        IndividualApplicant__c IndAppcnt = new IndividualApplicant__c(Name= 'Test');
        insert IndAppcnt;
        
        JobPostings__c Jp = new JobPostings__c(Name='TestJobPosting',Active_Job__c = true);
        insert Jp;
        
        Application__c App = new Application__c(Name='TestApplicantion',IndividualApplicant__c=IndAppcnt.Id, ActiveApplication__c=true,JobPosting__c =Jp.Id);
		insert App;
                
        Jp.Active_Job__c = false;
              
        Test.startTest();       
        Update Jp;
        Test.stopTest();
        
    }
                      
}