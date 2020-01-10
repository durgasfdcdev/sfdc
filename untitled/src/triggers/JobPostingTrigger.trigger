trigger JobPostingTrigger on JobPostings__c (after update) {
    if(trigger.isupdate && trigger.isafter){
        JobPostingTriggerHandler Handler = new JobPostingTriggerHandler();
        handler.afterUpdate(trigger.old, trigger.new);
    }
}