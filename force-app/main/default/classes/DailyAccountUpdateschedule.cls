global class DailyAccountUpdateschedule implements Schedulable {

    global void execute(SchedulableContext sc) {
        // Example logic: update accounts once per day
        List<opportunity> accts = [
            SELECT Id, name
            FROM opportunity limit 1            
        ];

        for (opportunity a : accts) {
            a.name = 'Updated by scheduled Apex';
        }

        if (!accts.isEmpty()) {
            update accts;
        }
        
        //execute batch class
        errorlogcleanupjob batch = new errorlogcleanupjob();
        Database.executeBatch(batch, 200);
        
        // execute quauable job
        system.enqueuejob(new UpdateAccountQueueable());
    }
}