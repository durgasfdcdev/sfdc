@RestResource(urlMapping = '/Applications/*')
global class RestAPI_createApplications {
    
    global class ApplicationsWrapper {
    public String Name;
    public String Email;
    public String Address;
    public String Phone;
    public String JobId;
    

    public Application__c getApp() {
        
        return new Application__c(
            Name = this.Name,
            Email__c = this.Email,
            Address__c = this.Address,
            Phone__c = this.Phone,
            Job_Id__c = this.JobId
        );
    }
}
    
    @HttpPost
    global static void insertApp(List<ApplicationsWrapper> webformData) {
        List<Application__c> AppstoCreate = new List<Application__c>();
        List<String> Jobids = new List<String>();
        List<String> Emails = new List<String>();
        
        for(ApplicationsWrapper App :webformData ){
           AppstoCreate.add(App.getApp()) ;
            Jobids.add(App.getApp().Job_Id__c);
            Emails.add(App.getApp().Email__c);
        }
        
        List<JobPostings__c> JobPostList = [SELECT Id,Job_Id__c FROM JobPostings__c WHERE Job_Id__c IN:Jobids ];
        List<Contact> ConList = [SELECT Id,Name,Email FROM Contact WHERE Email IN:Emails ];
        List<IndividualApplicant__c> IndAppList = [SELECT Id,Name,Email__c FROM IndividualApplicant__c WHERE Email__c IN:Emails ];
        for(Application__c App:AppstoCreate){
            for(JobPostings__c JobPosting : JobPostList){
                if(JobPosting.Job_Id__c == App.Job_Id__c && JobPosting != null)
              App.JobPosting__c =  JobPosting.Id; 
            } 
            for(Contact Con : ConList){
                if(Con.Email ==App.Email__c && Con!= null)
               App.Contact__c =  Con.Id;      
            }
            for(IndividualApplicant__c IndApp : IndAppList){
                if(IndApp.Email__c ==App.Email__c && IndApp != null )
               App.IndividualApplicant__c =  IndApp.Id;      
            }
        }
        Insert AppstoCreate;    
    }
    
}