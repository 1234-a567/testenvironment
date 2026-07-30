trigger leadtrigger on Lead (before update) {
if(trigger.isbefore && trigger.isupdate){
for (lead leadrec:trigger.new){
    leadrec.status ='working-contacted';
}
}
}