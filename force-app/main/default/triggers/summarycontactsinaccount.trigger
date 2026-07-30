trigger summarycontactsinaccount on Contact(after insert, after update, after delete) {
    set < id > accountids = new set < id > ();
    if (trigger.isinsert || trigger.isupdate) {
        for (contact c: trigger.new) {
            accountids.add(c.accountid);
        }
    }
    if (trigger.isdelete) {
        for (contact c: trigger.old) {
            accountids.add(c.accountid);
        }
    }

    AggregateResult[] groupedResults = [SELECT AccountId, COUNT(Id) totalContacts, SUM(Salary__c) totalsalary,max(salary__C) maxsalary,min(salary__C) minsalary,avg(salary__c) avgsalary FROM Contact WHERE AccountId in: accountids GROUP BY AccountId];
    system.debug('total aggrigate result:::'+groupedResults);
    list < account > updateacclist = new list < account > ();
    for (AggregateResult agr: groupedResults) {
    system.debug(' eatch aggrigate result:::'+agr);
        account acc = new account();
        acc.id = (id) agr.get('AccountId');
        acc.count_of_contacts__c = (integer) agr.get('totalContacts');
        acc.Sum_of_Contacts_Salary__c = (decimal) agr.get('totalsalary');
        acc.max_of_contact_sal__c=(decimal) agr.get('maxsalary');
        acc.min_of_contact_sal__c=(decimal) agr.get('minsalary');
        acc.Avg_of_contact_sal__c=(decimal) agr.get('avgsalary');
        updateacclist.add(acc);
    }
    update updateacclist;
}