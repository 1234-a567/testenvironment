trigger AccountTriggerrecursive on Account (after update) {
    List<Account> accList = new List<Account>();

    for(Account acc : Trigger.new) {
        bus__c b = new bus__c();
        b.id = 'a0DgK000004XOShUAO';
        update b; // ❌ This causes recursion
    }

}