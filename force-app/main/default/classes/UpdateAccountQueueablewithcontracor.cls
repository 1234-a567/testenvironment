public class UpdateAccountQueueablewithcontracor implements Queueable {

    // Variable to hold data passed from constructor
    private List<Account> accountList;

    // Constructor
    public UpdateAccountQueueablewithcontracor(List<Account> accs) {
        this.accountList = accs;
    }

    // Execute method (runs asynchronously)
    public void execute(QueueableContext context) {

        for (Account acc : accountList) {
            acc.Description = 'Updated via Queueable Job';
        }

        update accountList;
    }
}