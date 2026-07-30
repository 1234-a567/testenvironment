public class MultipleSavepointsExample {
    
    public void executeMultipleSavepoints() {
        // List to keep track of multiple savepoints
        List<Savepoint> savepoints = new List<Savepoint>();

        try {
            // Savepoint 1: Before the first set of operations
            savepoints.add(Database.setSavepoint());
            System.debug('Savepoint 1 set');
            
            // Create first Account
            Account acc1 = new Account(Name = 'Account 1');
            database.insert(acc1,false);
            
            // Savepoint 2: Before the second set of operations
            savepoints.add(Database.setSavepoint());
            System.debug('Savepoint 2 set');
            
            // Create second Account
            Account acc2 = new Account(Name = 'Account 2');
            database.insert(acc2,false);
            
            // Simulate an error (missing field in Account 3)
            Account acc3 = new Account(Name = '');
            insert acc3;
            
        } catch (DmlException e) {
            // Rollback to the last savepoint (Savepoint 2) if error occurs
            //Database.rollback(savepoints[1]); // Rollback to Savepoint 2
            //System.debug('Error occurred. Rolled back to Savepoint 2');
            
            // Optionally, rollback further to Savepoint 1
            //Database.rollback(savepoints[0]); // Rollback to Savepoint 1
            //System.debug('Rolled back to Savepoint 1');
            system.debug(e.getmessage());
        }

        // The first insert (acc1) will be rolled back to the first savepoint, and
        // the second insert (acc2) will be rolled back to the second savepoint.
        // Any changes after that would also be undone.
    }
}