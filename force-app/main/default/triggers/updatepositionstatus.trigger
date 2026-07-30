/* parent to  child child  */
 
trigger updatepositionstatus on Opportunity (after insert, after update) {
set<id> optyidset = new set<id> ();
for(opportunity opp :trigger.new)
{
optyidset.add(opp.id);

}
list<position__c> poslist = new list<position__c>();
list<opportunity> optylist = [select id,position_status__c,(select id,status__c from positions__r) from opportunity where id in: optyidset];
for(opportunity opp:optylist )
{
if (opp.Positions__r != null) {
            for (Position__c pos : opp.Positions__r) {
                // Check if the Opportunity's Position Status has changed
                if(opp.position_status__c == 'Open')
                {
                pos.status__c = 'Open';
                }
                else if (opp.position_status__c == 'Closed')
                {
                pos.status__c = 'Closed';
                }
              poslist.add(pos);

            }
        }
}
update poslist;
}