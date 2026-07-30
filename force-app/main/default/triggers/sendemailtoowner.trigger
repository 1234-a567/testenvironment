trigger sendemailtoowner on Case (after update) {
list<Messaging.SingleEmailMessage> messagelist = new list<Messaging.SingleEmailMessage>();
for(case c : trigger.new)
{
if(c.Priority == 'High')
{
/* send email with normal subject
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
// Set recipients (To)
String[] toAddresses = new String[] {c.owner.email};
mail.setToAddresses(toAddresses);
// Set CC recipients
String[] ccAddresses = new String[] {'subbaiah.peta@gmail.com'};
mail.setCcAddresses(ccAddresses);
// Set subject
mail.setSubject('Welcome to Salesforce Messaging');
// Set email body (plain text)
mail.setPlainTextBody('Hello John,\n\nThis is a test email sent from Salesforce Apex.\n\nRegards,\nTeam');
// (Optional) HTML body instead
mail.setHtmlBody('<h3>Hello John</h3><p>This is a test email from <b>Salesforce</b>.</p>');
messagelist.add(mail);
*/

/*send email with Email Template*/

 // Email Template Id (replace with your template Id)
        Id templateId = [SELECT Id, Name, Subject, HtmlValue, Body FROM EmailTemplate WHERE Name = 'sentmailtocaseowner'].id; 

        // Create email message
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setTargetObjectId(userinfo.getuserid());
    String[] toAddresses = new String[] {c.owner.email};
    mail.setToAddresses(new list<string> {'anilkumar.mothukuri111@gmail.com'});
        // Use email template
        mail.setTemplateId(templateId);
        // Required when using templates with merge fields
        mail.setWhatId(c.Id);

        // Ensure email is sent even if recipient is a Contact/Lead/User
        mail.setSaveAsActivity(false);
        messagelist.add(mail);
}
}
// Send email
Messaging.SendEmailResult[] results = Messaging.sendEmail(messagelist);

}