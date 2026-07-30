@isTest
public class updateintereststustusinopportunitytest {

    @isTest
    public static void updateopportunity() {
        // Step 1: Create a test Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Union Bank1',
            CloseDate = Date.today(),
            StageName = 'Prospecting'
            
        );
        insert opp;

        // Step 2: Create the Position record
        position__c p = new position__c();
        p.Name = 'dev';
        p.position_type__c = 'Full Time';
        p.start_date__c = Date.newInstance(2026, 4, 21);
        p.position_unic_ids__c = '12345656';
        p.Opportunity__c = opp.Id; // link to the Opportunity
        p.about__c='this is dileep';
        p.will_you_intrest__c=true;
        

        // Step 3: Insert the Position record
        insert p;

        // Optional: Assert it was inserted correctly
        Position__c insertedP = [SELECT Id, Name, Opportunity__c FROM Position__c WHERE Id = :p.Id];
        System.assertEquals('dev', insertedP.Name);
        System.assertEquals(opp.Id, insertedP.Opportunity__c);
         updateintereststustusinopportunity obj=new updateintereststustusinopportunity();
    obj.updateopportunity();
    }
   
   @istest()
   public static void updatestudentstest(){
   
   student__C s=new student__C ();
   s.name='anil';
   s.joining_month_name__c='Jun';
   insert s;
   
   updateintereststustusinopportunity obj = new updateintereststustusinopportunity();
    obj.updatestudents();
    }
    @istest()
    public static  void dinamicquerytest(){
     updateintereststustusinopportunity obj = new updateintereststustusinopportunity();
    obj.dinamicquery('Name','joining_month_name__c','student__C');
    
 }
    
}