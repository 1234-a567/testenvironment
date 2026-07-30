global class UpdateAccountBatch implements Database.Batchable<sObject> {

    // 1. Start method – defines records to process
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Description FROM Account');
    }

    // 2. Execute method – runs on each batch (chunk)
    global void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            acc.Description = 'Updated by Batch Job';
        }
        update scope;
    }

    // 3. Finish method – runs after all batches complete
    global void finish(Database.BatchableContext bc) {
        System.debug('Batch job completed successfully');
    }
}