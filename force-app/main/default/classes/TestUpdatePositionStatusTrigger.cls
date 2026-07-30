@isTest
public class TestUpdatePositionStatusTrigger {

    @isTest
    static void testOpportunityStatusUpdate() {
        // Step 1: Create an Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            CloseDate = Date.today().addDays(30),
            StageName = 'Prospecting',
            Position_Status__c = 'Open' // initial status
        );
        insert opp;

        // Step 2: Create related Position__c child records
        Position__c pos1 = new Position__c(
            Name = 'Position 1',
            Opportunity__c = opp.Id,
            Status__c = 'Closed' // initial status, will be updated by trigger
        );

        Position__c pos2 = new Position__c(
            Name = 'Position 2',
            Opportunity__c = opp.Id,
            Status__c = 'Closed'
        );

        insert new List<Position__c> { pos1, pos2 };

        // Step 3: Update Opportunity's Position_Status__c to 'Closed' to fire trigger
        opp.Position_Status__c = 'Closed';
        update opp;

        // Step 4: Query child Positions to verify trigger updated them
        List<Position__c> updatedPositions = [SELECT Id, Status__c FROM Position__c WHERE Opportunity__c = :opp.Id];

        // Step 5: Assert that each Position__c's Status__c matches the Opportunity's status
        for (Position__c pos : updatedPositions) {
            System.assertEquals('Closed', pos.Status__c, 'Position status should match Opportunity status');
        }

        // Step 6: Test when Opportunity status is 'Open'
        opp.Position_Status__c = 'Open';
        update opp;

        updatedPositions = [SELECT Id, Status__c FROM Position__c WHERE Opportunity__c = :opp.Id];

        for (Position__c pos : updatedPositions) {
            System.assertEquals('Open', pos.Status__c, 'Position status should match Opportunity status');
        }
    }
}