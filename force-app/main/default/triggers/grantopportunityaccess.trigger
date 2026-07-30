trigger grantopportunityaccess on OpportunityTeamMember (after insert) {
 if (Trigger.isAfter && Trigger.isInsert) {
        OpportunityTeamMemberHandler.handleAfterInsert(Trigger.new);
    }
    
}