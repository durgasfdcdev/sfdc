Public class AllActiveJobPosting {
    private ApexPages.StandardController Controller {get; set;}
    public list<JobPostings__c> jobpostings {get; set;}
    public list<Jpwrapper> jpwrapperlist {get; set;}
    public list<JobPostings__c> clickedjobpostings {get; set;}
    public list<Application__c> linkedapplication {get; set;}
    public list<IndividualApplicant__c> linkedIndividualApplicant {get; set;}
    
    public AllActiveJobPosting(ApexPages.StandardController controller){
        this.controller = controller;
        if(jpwrapperlist == null){
            jpwrapperlist = new list<Jpwrapper>();
            for(JobPostings__c jpc :[Select Id,Name,Job_Id__c,Active_Job__c from JobPostings__c where Active_Job__c =True]){
                jpwrapperlist.add(new Jpwrapper(jpc));
            }
        }
        
    }
    public pagereference clicked(){
        clickedjobpostings = new list<JobPostings__c>();
        set<id> clickedjobids = new set<id>();
        
        for(Jpwrapper jpw : jpwrapperlist) {
            if(jpw.selected == true){
                clickedjobpostings.add(jpw.clickedjp);
                clickedjobids.add(jpw.clickedjp.id);
            }
        }
        linkedapplication = new list<Application__c>();
        for (Application__c apln:[select id,name,ActiveApplication__c,Email__c,IndividualApplicant__r.Name,IndividualApplicant__c,Job_Id__c,JobPosting__c,Phone__c from Application__c where JobPosting__c=:clickedjobids]){
            linkedapplication.add(apln);
        }
        return null; 
    }
        public class Jpwrapper {
            public JobPostings__c clickedjp{get;set;}
            public Boolean selected {get; set;}
            
            public Jpwrapper(JobPostings__c Jobp) {
                clickedjp = Jobp;
                selected = false;
            }
        }
    }