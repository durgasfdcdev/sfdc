public class JobPostingTriggerHandler {
  public void afterUpdate(List<JobPostings__c> oldjobpostings,List<JobPostings__c> newjobpostings)
    {
        Set<Id> jpstids = new Set<Id>();
        for(JobPostings__c jpc: newjobpostings){
		if(jpc.Active_Job__c == false)
            jpstids.add(jpc.Id);
        }
        List<Application__c> updjpLst = new List<Application__c>();
        for(Application__c jps:[SELECT Id,ActiveApplication__c,JobPosting__c FROM Application__c WHERE JobPosting__c IN: jpstids ]){
            jps.ActiveApplication__c = false;
            updjpLst.add(jps);
        }
        Update updjpLst;
}
}