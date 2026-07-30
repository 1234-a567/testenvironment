trigger processstudents on My_Platform_Event__e (after insert) {
set<id> studentids = new set<id>();
accounttriggerHelper.isrecurcive = true;
for(My_Platform_Event__e event : trigger.new)
{
studentids.add(event.student_id__c);
}
list<Student__c> stulist = [select id,joining_month_name__c,recordtypeid,joining_month_number__c from student__C where id in :studentids];
try{
    id sturt1=Schema.SObjectType.student__C.getRecordTypeInfosByName().get('Non Technical Deepartment').getRecordTypeId();
    id sturt2=Schema.SObjectType.student__C.getRecordTypeInfosByName().get('Technical Department').getRecordTypeId();
    list<Student__c> updatestulist = new list<Student__c>();
    for (Student__c stu : stulist) {
        // Get the month number using the helper method
        if (stu.joining_month_name__c != null) {
        if (stu.recordtypeid==sturt1 || stu.recordtypeid==sturt2){
            stu.joining_month_number__c = String.valueOf(StudentHelper.getMonthVsNumberMap().get(stu.joining_month_name__c));
        updatestulist.add(stu);
        }
    }
}
update updatestulist; 
}
catch(exception e)
{
Error_Log__c error = new Error_Log__c();
error.Component_Name__c = 'Trigger:UpdateMonth';
error.Error_Message__c = e.getmessage() + ':::Line Number::' +e.getLineNumber();
insert error;
system.debug('issue::'+e.getmessage()+' '+e.getLineNumber());
} 



}