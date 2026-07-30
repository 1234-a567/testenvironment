/*Recomended version*/
@IsTest
public class accounttriggerHelperTest3{

@testSetup
    static void createTestData() {
    list<account> acclist = new list<account>();
    Account acc = new Account(Name = 'Test Account',AccountNumber = '123',Type='Technology Partner',AccountSource='web');
      acclist.add(acc);
      Account acc2 = new Account(Name = 'Test Account2',AccountNumber = '123',Type='Technology Partner',AccountSource='web');
      acclist.add(acc2);
      insert acclist;
          Contact testContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'john.doe@example.com',
            AccountId = acclist[1].Id
        );
        test.starttest();
        insert testContact;
        test.stoptest();
    }
    
public static testmethod void getcontactstest(){
list<account> acclist2 = [select id,Name,AccountNumber from account]; 
list<contact> conlist = accounttriggerHelper.getcontacts(acclist2);
                system.debug('size::'+conlist.size());
      system.assertEquals(1,conlist.size());
      accounttriggerHelper.cancatenames('Anil', 'Kumar');
}

public static testmethod void  deleteOKdeletContacstest(){
list<account> acclist2 = [select id,Name,AccountNumber from account]; 
accounttriggerHelper.deleteOKdeletContacs(acclist2);
system.assert(acclist2.size() > 0);
}
public static testmethod void assignWebsitetest(){
list<account> acclist2 = [select id,Name,AccountNumber from account];
acclist2[0].AccountSource = 'web';
update acclist2[0];
accounttriggerHelper.assignWebsite(acclist2[0]);
}

}