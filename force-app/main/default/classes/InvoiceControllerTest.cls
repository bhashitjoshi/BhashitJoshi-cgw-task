@isTest
public class InvoiceControllerTest {
    @isTest
    static void testInvoiceController() {
        //Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            AccountId = testAccount.Id
        );
        insert testOpportunity;

        //Visualforce page parameters
        Test.startTest();
        ApexPages.CurrentPage().getParameters().put('origin_record', testOpportunity.Id);
        ApexPages.CurrentPage().getParameters().put('account', testAccount.Name);
        ApexPages.CurrentPage().getParameters().put('invoice_date', String.valueOf(Date.today()));
        ApexPages.CurrentPage().getParameters().put('invoice_due_date', String.valueOf(Date.today().addDays(30)));
        ApexPages.CurrentPage().getParameters().put('line_item_description', 'Test Description');
        ApexPages.CurrentPage().getParameters().put('line_item_quantity', '5');
        ApexPages.CurrentPage().getParameters().put('line_item_unit_price', '100');
        ApexPages.CurrentPage().getParameters().put('child_relationship_name', 'Opportunities');

        //Instantiate the controller
        InvoiceController controller = new InvoiceController();

        //Validate the controller behavior
        System.assertEquals(testOpportunity.Id, controller.recordId, 'Record Id should match');
        System.assertEquals(testAccount.Name, controller.account, 'Account Name should match');
        System.assertEquals(String.valueOf(Date.today()), controller.invoiceDate, 'Invoice Date should match');
        System.assertEquals(String.valueOf(Date.today().addDays(30)), controller.invoiceDueDate, 'Invoice Due Date should match');
        System.assertEquals('Test Description', controller.lineItemDescription, 'Line Item Description should match');
        System.assertEquals('5', controller.lineItemQuantity, 'Line Item Quantity should match');
        System.assertEquals('100', controller.lineItemUnitPrice, 'Line Item Unit Price should match');
        System.assertEquals('Opportunities', controller.childRelationshipName, 'Child Relationship Name should match');
        Test.stopTest();
    }
}