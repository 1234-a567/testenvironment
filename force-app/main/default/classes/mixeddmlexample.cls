public class mixeddmlexample
{
public static void createmixeddml()
{
Account a = new Account(Name = 'Acme');
a.AccountNumber = '123';
insert a;  
User u = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
u.Title = 'Sales Rep';
update u;          // Setup object

         // Non-setup object
}
}