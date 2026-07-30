global class errorlogcleanupjob implements Database.Batchable<sObject> {

    // 1. Start method – defines records to process
    global Database.QueryLocator start(Database.BatchableContext bc) {
    date todaydate = Date.today();
system.debug('todaydate:::'+todaydate);
CleanUp_Batch_Days__c CleanUpRecord = CleanUp_Batch_Days__c.getValues('errorlogcleanupjob');
Integer numOfDays = cleanUpRecord.cleanup_Days__c.intValue();
Date oldDate = todayDate.addDays(numOfDays);
        return Database.getQueryLocator('select id,Component_Name__c,Error_Message__c from Error_Log__c where CreatedDate <= :olddate');
    }

    // 2. Execute method – runs on each batch (chunk)
    global void execute(Database.BatchableContext bc, List<Error_Log__c> scope) {
       delete scope;
    }

    // 3. Finish method – runs after all batches complete
    global void finish(Database.BatchableContext bc) {
        System.debug('Batch job completed successfully');
    }
}