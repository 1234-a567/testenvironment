Public class accounttriggerHelper {
public static boolean isrecurcive = false;
        @testvisible
        private string username = 'Dill';
    // returns the contactlist associated to accounts
    public static list < contact > getcontacts(list < account > accountlist) {
        list <contact> contactlist = new list <contact> ();
        for(account acc : accountlist){
        contactlist = [select id, name from contact where accountid = :acc.id];
        if(!contactlist.isempty())
        {
        list <contact> querycontacts = [select id,name from contact where id in: contactlist];
        }
        else{
        list<opportunity> optylist = [select id,name from opportunity limit 2];
        }
        
       
        }
         return contactlist;
    }
    // raise a error message while delete the oktodelete accounts
    public static void deleteOKdeletContacs(list < account > accountlist) {
        for (account a: accountlist) {
            if (a.name != 'oktodelete') {
                a.addError('you can not delete the Account!!');
            }
        }
    }
    public static void updateindustri(list < account > accountlist) {
        //quering recordtype for particular object
        //Recordtype customerrtp = [SELECT Id,DeveloperName FROM RecordType WHERE DeveloperName = 'Customer' AND SObjectType = 'Account' limit 1];
        //get recordtype without quering 
        Id accountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
        system.debug('Recordtypeid:::' + accountRecordTypeId);
        for (account acc: accountlist) {
            if (acc.recordtypeid == accountRecordTypeId && acc.Type == 'Technology Partner') {
                acc.Industry = 'Technology';

            }
        }
    }
    // assign website
    public static void assignWebsite(account acc) {
        acc.Website = 'https://login.salesforce.com/';
    }
    
    // update contact's phone through future method
    @future
    public static void updatecontactphone(string accountid)
    {
     list<contact> conlist = [select id,lastname,AssistantPhone from contact where accountid = :accountid];
     if(!conlist.isempty())
     {
     list<contact> updateconlist = new list<contact>();
      for(contact c: conlist)
      {
      c.AssistantPhone = '990234567';
      updateconlist.add(c);
      }
      update updateconlist;
     }
     system.enqueuejob(new UpdateAccountQueueable());
     
    }
    
     @future
    public static void createuserrole()
    {
    userrole urole = new userrole(name = 'india director');
      insert  urole;   
    }
    @testvisible
    private static string cancatenames(string first, string last)
    {
    return first+' '+last;
    }

}