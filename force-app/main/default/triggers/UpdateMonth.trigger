trigger UpdateMonth on Student__c (after insert, after update) {

  /*  // Iterate through the Trigger.new collection
    try{
    id sturt1=Schema.SObjectType.student__C.getRecordTypeInfosByName().get('Non_Technical Deepartment').getRecordTypeId();
    id sturt2=Schema.SObjectType.student__C.getRecordTypeInfosByName().get('Technical Department').getRecordTypeId();
list<id>idlist=new List<Id>{sturt1, sturt2};
system.debug('idlist'+idlist);
    for (Student__c stu : Trigger.new) {
        // Get the month number using the helper method
        if (stu.joining_month_name__c != null) {
        if (stu.recordtypeid==sturt1 || stu.recordtypeid==sturt2){
            stu.joining_month_number__c = String.valueOf(StudentHelper.getMonthVsNumberMap().get(stu.joining_month_name__c));
        }
    }
}
}
catch(exception e)
{
Error_Log__c error = new Error_Log__c();
error.Component_Name__c = 'Trigger:UpdateMonth';
error.Error_Message__c = e.getmessage() + ':::Line Number::' +e.getLineNumber();
insert error;
system.debug('issue::'+e.getmessage()+' '+e.getLineNumber());
} */
if(accounttriggerHelper.isrecurcive == false){

list<My_Platform_Event__e> eventlist = new list<My_Platform_Event__e>();
for (Student__c  st : trigger.new)
{
My_Platform_Event__e event = new My_Platform_Event__e();
event.student_id__c = st.id;
eventlist.add(event);
}
accounttriggerHelper.isrecurcive = true;
list<Database.SaveResult> result = EventBus.publish(eventlist);

}
}