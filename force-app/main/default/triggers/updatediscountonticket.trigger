trigger updatediscountonticket on bus__c(after update, before update,after insert ) {

    if (trigger.isbefore && trigger.isupdate) {
        for (bus__C busrec: trigger.new) {
         busrec.shippingmethod__C = '';
         busrec.is_discount_elgible__c = false;
            //busobj__c shippingrec = busobj__c.getValues(busrec.country__c.toLowerCase());
            //busobj__c countrynamerecord = busobj__c.getValues('countrieslist');
            list<countrysetup__mdt>  countrynamerecordlist = new list<countrysetup__mdt>();
            list<countrysetup__mdt> shippingreclist = new list<countrysetup__mdt>();
            shippingreclist = [select id,DeveloperName ,countrieslist__c,shippingmethod__C from countrysetup__mdt  where DeveloperName =:busrec.country__c.toLowerCase() limit 1];
            countrynamerecordlist = [select id,DeveloperName ,countrieslist__c,shippingmethod__C from countrysetup__mdt  where DeveloperName = 'countrieslist' limit 1];
            string countrynamesstring = countrynamerecordlist[0].countrieslist__c;
            list < string > countrylist = countrynamesstring.split(',');
            if (!shippingreclist.isempty()) {
                string shippingmethod = shippingreclist[0].shippingmethod__C;
                busrec.shippingmethod__C = shippingmethod;
                }
             if (countrylist.contains(busrec.country__c.toLowerCase())) {
                    busrec.is_discount_elgible__c = true;
                } 
                else{
                 busrec.is_discount_elgible__c = false;
                }
            }

        }
        if (accounttriggerHelper.isrecurcive == false) {
            list < bus__c > updatebuslist = new list < bus__c > ();
            for (bus__c b: trigger.new) {

                account a = new account();
                a.id = '001gK00000ZCXqVQAX';
                accounttriggerHelper.isrecurcive = true;
                update a;
            }
        }
        if(trigger.isafter && trigger.isupdate){
        list<Messaging.SingleEmailMessage> messagelist = new list<Messaging.SingleEmailMessage>();
for(bus__C c : trigger.new)
{
//id recid = [select id from bus__c where id = :c.id limit 1].id;
if(Trigger.oldMap.get(c.Id).Districts__c != c.Districts__c && c.Districts__c == 'Kadapa') {

Id templateId = [SELECT Id, Name, Subject, HtmlValue, Body FROM EmailTemplate WHERE Name = 'BusRemindermail'].id; 

        // Create email message
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    //mail.setTargetObjectId(c.ownerid);
    String[] toAddresses = new String[] {c.owner.email};
    mail.setToAddresses(new list<string> {'anilkumar.mothukuri111@gmail.com'});
   mail.setTargetObjectId(UserInfo.getUserId());
        // Use email template
        mail.setTemplateId(templateId);
        // Required when using templates with merge fields
       mail.setWhatId(c.id);

        // Ensure email is sent even if recipient is a Contact/Lead/User
        mail.setSaveAsActivity(false);
        messagelist.add(mail);
}
}
// Send email
Messaging.SendEmailResult[] results = Messaging.sendEmail(messagelist);

}
    }