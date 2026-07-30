public class totaljobpositions implements Queueable {

public void execute(QueueableContext  qc){
list<job_Posting_Site__c>jobposlist=[select name from job_Posting_Site__c];


List<Account> accs = [
    SELECT Id, Description
    FROM Account
    WHERE Industry = 'Technology'
];

UpdateAccountQueueablewithcontracor job = new UpdateAccountQueueablewithcontracor(accs);
System.enqueueJob(job);

}
}