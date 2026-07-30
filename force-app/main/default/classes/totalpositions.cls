public class totalpositions implements Queueable {

public void execute(QueueableContext  qc){
list<position__C>poslist=[select name from position__c];
System.enqueueJob(new totaljobpositions());
}
}