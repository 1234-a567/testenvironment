public class OpportunityTeamMemberHandler {
public static void handleAfterInsert(List<OpportunityTeamMember> teamMembers) {
        List<OpportunityShare> sharesToInsert = new List<OpportunityShare>();

        for (OpportunityTeamMember teamMember : teamMembers) {
            OpportunityShare oppShare = new OpportunityShare();
            oppShare.OpportunityId = teamMember.OpportunityId;
            oppShare.UserOrGroupId = teamMember.UserId;
            oppShare.OpportunityAccessLevel = 'Edit';
            oppShare.RowCause = Schema.OpportunityShare.RowCause.Manual; // Must be Manual for Apex sharing
            sharesToInsert.add(oppShare);
        }

        if (!sharesToInsert.isEmpty()) {
            try {
                insert sharesToInsert;
            } catch (DmlException e) {
                System.debug('Error inserting OpportunityShare records: ' + e.getMessage());
            }
        }
    }
}