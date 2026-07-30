@IsTest
public class totalpositionsTest {

    @IsTest
    public static void testExecute() {
        // Step 1: Create a test Opportunity (for lookup)
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today()
        );
        insert opp;

        // Step 2: Create a test Position__c record
        Position__c pos = new Position__c(
            Name = 'p1',
            Opportunity__c = opp.Id,
            Position_Unic_IDs__c = '12345',
            About__c = 'abilll',
            Start_Date__c = Date.today(),
            status__C='closed',
            Position_Type__c = 'Full Time'
        );
        insert pos;

        // Step 3: Execute Queueable job in test context
        Test.startTest();
        if (!Test.isRunningTest()) {
    System.enqueueJob(new totaljobpositions());
}
        Test.stopTest();

        // Step 4: Optional assertion
        Integer countPositions = [SELECT COUNT() FROM Position__c];
        System.assertEquals(1, countPositions, 'There should be 1 position inserted.');
    }
}