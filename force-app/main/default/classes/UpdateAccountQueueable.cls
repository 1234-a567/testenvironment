public class UpdateAccountQueueable implements Queueable {
    
    // Method to execute the job
    public void execute(QueueableContext context) {
        // Query for a set of Account records that need to be updated
        List<student__c> stulist = [SELECT Id, Name,recordtype.name FROM student__c];
        
        // Update the records
        for (student__c stu : stulist ) {
            if(stu.recordtype.name == 'Technical Department')
            {
            stu.Name = 'Technical Department - ' + stu.Name;
            }
            else if(stu.recordtype.name == 'Non Technical Deepartment')
            {
            stu.Name = 'Non Technical Deepartment - ' + stu.Name;
            }
        }
        
        // Perform the update operation
        update stulist;
        system.debug('jobid::::'+context.getJobId());
    }
}