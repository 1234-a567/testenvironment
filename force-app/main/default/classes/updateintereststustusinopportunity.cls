public class updateintereststustusinopportunity {
    /* public updateintereststustusinopportunity() {
        updateopportunity();
    }*/
    

    public void updateopportunity() {
        set < id > optyidset = new set < id > ();
        set < id > optyidsetnotinterest = new set < id > ();
        list < position__c > positionlist = new list < position__c > ();
        positionlist = [select id, name, will_you_intrest__c, Opportunity__c from position__c];
        system.debug('position list:::' + positionlist);
        for (position__c pos: positionlist) {
            if (pos.will_you_intrest__c == true && pos.Opportunity__c != null) {
                optyidset.add(pos.Opportunity__c);

            }

        }
        list < opportunity > updateopty = new list < opportunity > ();
        for (id optyid: optyidset) {
            opportunity opp = new opportunity();
            opp.id = optyid;
            opp.position_interested__c = 'Yes interested!';
            updateopty.add(opp);

        }
        update updateopty;
    }
    public void updatestudents() {
        string profileid = userinfo.getprofileid();
       profile p =  [select id,name from profile where id =:profileid limit 1];
       if(p.name  != 'Authenticated Website')
       {
        list < student__c > stulist = [select id, name, joining_month_name__c, joining_month_number__c from student__c where joining_month_name__c != null];
            map < string, string > monthnamevsnumbermap = new map < string, string > ();
      monthnamevsnumbermap =  getmonthvsnumbermap();
        list < student__c > updatestudentlist = new list < student__c > ();
        for (student__c stu: stulist) {
            if (monthnamevsnumbermap.containskey(stu.joining_month_name__c)) {
                stu.joining_month_number__c = monthnamevsnumbermap.get(stu.joining_month_name__c);
                updatestudentlist.add(stu);
            }
             

        }
        update updatestudentlist;
        system.debug('Consumed DML ROWS:::'+Limits.getDMLRows());
        system.debug('Total DML ROWS limit:::'+Limits.getLimitDMLRows());
        
         system.debug('Consumed DML statements:::'+Limits.getDMLStatements());
        system.debug('Total DML ROWS statements:::'+Limits.getLimitDMLStatements());
        
        system.debug('Consumed heapsize:::'+Limits.getHeapSize());
        system.debug('Total heapsize:::'+Limits.getLimitHeapSize());
        
        system.debug('Consumed Queries:::'+Limits.getQueries());
        system.debug('Total Queries:::'+Limits.getLimitQueries());
        
        system.debug('Consumed QueryRows:::'+Limits.getQueryRows());
        system.debug('Total QueryRows:::'+Limits.getLimitQueryRows());
        }
        
    }
    public  map < string, string > getmonthvsnumbermap(){
        map < string, string > monthnamevsnumber = new map < string, string > ();

        monthnamevsnumber.put('Jan', '1');
        monthnamevsnumber.put('Feb', '2');
        monthnamevsnumber.put('Mar', '3');
        monthnamevsnumber.put('Apr', '4');
        monthnamevsnumber.put('May', '5');
        monthnamevsnumber.put('Jun', '6');
        monthnamevsnumber.put('Jul', '7');
        monthnamevsnumber.put('Aug', '8');
        monthnamevsnumber.put('Sep', '9');
        monthnamevsnumber.put('Oct', '10');
        monthnamevsnumber.put('Nov', '11');
        monthnamevsnumber.put('Dec', '12');
        return monthnamevsnumber;

    }
    public void dinamicquery(string fieldname1, string fieldname2, string objectname)
    {
    string query = 'select id,'+fieldname1+', '+fieldname2 + ' from '+ objectname ;
     List<SObject> records = Database.query(query);
        System.debug(records);
    }
}