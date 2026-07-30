/**** child to parent example ****/
trigger updateoptystatus on position__c(after insert, after update) {
     list < opportunity > updateoptylist = new list < opportunity > ();
     set<id> posidset = new set<id>();
     for (position__c pos: trigger.new) {
     posidset.add(pos.id);
     }
     list<position__c> plist = [select id,status__c,opportunity__c,opportunity__r.total_positions__c,opportunity__r.name from position__c where id in :posidset];
    for (position__c pos: plist) {
      system.debug('pos status:::'+pos.status__c);
      system.debug('pos opty total pos:::'+pos.opportunity__r.total_positions__c);
        if (pos.status__c == 'closed' && pos.opportunity__r.total_positions__c <=10) {
        opportunity opp = new opportunity();
           opp.id = pos.opportunity__c;
           opp.position_status__c = 'Closed';
           updateoptylist.add(opp);
        }
        if(pos.opportunity__r.name == 'sbi')
        {
        opportunity opp = new opportunity();
        opp.id = pos.opportunity__c;
        opp.stagename = 'Closed Lost';
        opp.Error_Message__c = '';
          updateoptylist.add(opp);
        }
        else
        {
        opportunity opp = new opportunity();
        opp.id = pos.opportunity__c;
                opp.stagename = 'Qualification';
                        opp.Error_Message__c = '';
                        
          updateoptylist.add(opp);
        }
    }
  list<Database.SaveResult> result =   database.update(updateoptylist,false);
  
      list <opportunity> erroroptylist = new list <opportunity>();
for (integer i = 0; i<result.size(); i++) {
 Database.SaveResult sr = result[i];
 opportunity opp = updateoptylist[i];
 
    if (sr.isSuccess()) {
        System.debug('Inserted Id: ' + sr.getId());
    } else {
    opp.stagename = 'Needs Analysis';
opp.Error_Message__c = sr.getErrors()[0].getMessage();    
          erroroptylist.add(opp);
       
    }
}
update erroroptylist;
}