trigger accounttrigger on Account(after update, before delete, before insert, after insert, before update) {
    if ((trigger.isupdate && trigger.isbefore) || (trigger.isinsert && trigger.isbefore)) {
        //assign Industri field value before insert or update
        accounttriggerHelper.updateindustri(trigger.new);
        /* assign default website when account source is web*/
        if (trigger.isinsert && trigger.isbefore) {
            for (account acc: trigger.new) {
                if (acc.AccountSource == 'Web') {
                    accounttriggerHelper.assignWebsite(acc);
                }
            }
        }
        if (trigger.isupdate && trigger.isbefore) {
            for (account acc: trigger.new) {
                system.debug('new AccountSource:::' + trigger.newmap.get(acc.id).AccountSource);
                system.debug('old AccountSource:::' + trigger.oldmap.get(acc.id).AccountSource);

                if (acc.AccountSource == 'Web' && trigger.newmap.get(acc.id).AccountSource != trigger.oldmap.get(acc.id).AccountSource) {
                    accounttriggerHelper.assignWebsite(acc);

                }
                 if(acc.accountsource!='web'){
                   acc.website=' ';
 }
            }
        }
        /* End assign default website when account source is web*/

    }

    //query the contact records while account update
    if (trigger.isupdate && trigger.isafter) {
        list < contact > conlist = accounttriggerHelper.getcontacts(trigger.new);
    }
    // delete the accounts when name eqal to oktodelete
    if (trigger.isdelete && trigger.isbefore) {
        accounttriggerHelper.deleteOKdeletContacs(trigger.old);
    }
    
    // call future method for update contacts
    
    if (trigger.isafter && trigger.isupdate) {
    for(account a : trigger.new)
    {
    accounttriggerHelper.updatecontactphone(a.id);
    }
    }
    // update account billing country to the account owner country
    if ((trigger.isupdate && trigger.isafter) || (trigger.isupdate && trigger.isinsert)){
    set<id> accountidset = new set<id>();
    for (account acc: trigger.new) {
  //accounttriggerHelper.createuserrole();
   
    }
    
    list<contact> updatecontactlist = new list<contact>();
    list<contact> conlist = [select id,accountbillingcountry__c,account.BillingCountry from contact where accountid in : accountidset];
    for(contact c : conlist)
    {
    c.accountbillingcountry__c = c.account.BillingCountry;
    updatecontactlist.add(c);
    }
    update updatecontactlist;
    
    
    }
    if(trigger.isinsert && trigger.isafter){
    List<Contact> conList = new List<Contact>();

    for (Account acc : Trigger.new) {
        Contact con = new Contact();
        con.LastName = acc.Name;   // Contact requires LastName, not Name
        con.AccountId = acc.Id;

        conList.add(con);
    }

    if (!conList.isEmpty()) {
        insert conList;
    }
}
    
   
}