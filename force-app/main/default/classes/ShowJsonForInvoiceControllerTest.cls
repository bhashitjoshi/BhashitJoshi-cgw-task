@isTest
public class ShowJsonForInvoiceControllerTest {
    @isTest
    public static void testShowJsonForInvoiceController() {
        // Set up test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Invoice__c testInvoice = new Invoice__c(
            Account__c = testAccount.Id,
            InvoiceDate__c = Date.today(),
            DueDate__c = Date.today().addDays(10)
        );
        insert testInvoice;

        Invoice_Line_Item__c testLineItem1 = new Invoice_Line_Item__c(
            Invoice__c = testInvoice.Id,
            Description__c = 'Line Item 1',
            Quantity__c = 2,
            UnitPrice__c = 50
        );
        Invoice_Line_Item__c testLineItem2 = new Invoice_Line_Item__c(
            Invoice__c = testInvoice.Id,
            Description__c = 'Line Item 2',
            Quantity__c = 1,
            UnitPrice__c = 100
        );
        insert new List<Invoice_Line_Item__c>{testLineItem1, testLineItem2};

        // Simulate page parameters
        Test.startTest();
        PageReference pageRef = Page.ShowJsonForInvoice; 
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('recordId', testInvoice.Id);
        ApexPages.currentPage().getParameters().put('account', 'Account__c');
        ApexPages.currentPage().getParameters().put('invoiceDate', 'InvoiceDate__c');
        ApexPages.currentPage().getParameters().put('invoiceDueDate', 'DueDate__c');
        ApexPages.currentPage().getParameters().put('lineItemDescription', 'Description__c');
        ApexPages.currentPage().getParameters().put('lineItemQuantity', 'Quantity__c');
        ApexPages.currentPage().getParameters().put('lineItemUnitPrice', 'UnitPrice__c');
        ApexPages.currentPage().getParameters().put('childRelationshipName', 'Invoice_Line_Items__r');

        // Initialize the controller
        ShowJsonForInvoiceController controller = new ShowJsonForInvoiceController();
        System.assertNotEquals(null, controller.jsonResult, 'JSON result should not be null.');
        
        Test.stopTest();

        // Validate JSON serialization
        System.assert(controller.jsonResult.contains('50'), 'JSON should include line item prices.');

    }

    @isTest
    public static void testCreateInvoiceAndInvoiceLineItems() {
        // Step 1: Create test data for Account, Invoice, and Line Items
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Invoice__c testInvoice = new Invoice__c(
            Account__c = testAccount.Id,
            InvoiceDate__c = Date.today(),
            DueDate__c = Date.today().addDays(10)
        );
        insert testInvoice;

        Test.startTest();
        PageReference pageRef = Page.ShowJsonForInvoice;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('recordId', testInvoice.Id);
        ApexPages.currentPage().getParameters().put('account', 'Account__c');
        ApexPages.currentPage().getParameters().put('invoiceDate', 'InvoiceDate__c');
        ApexPages.currentPage().getParameters().put('invoiceDueDate', 'DueDate__c');
        ApexPages.currentPage().getParameters().put('lineItemDescription', 'Description__c');
        ApexPages.currentPage().getParameters().put('lineItemQuantity', 'Quantity__c');
        ApexPages.currentPage().getParameters().put('lineItemUnitPrice', 'UnitPrice__c');
        ApexPages.currentPage().getParameters().put('childRelationshipName', 'Invoice_Line_Items__r'); 

        // Step 3: Initialize the controller and invoke the method
        ShowJsonForInvoiceController controller = new ShowJsonForInvoiceController();
        PageReference resultPage = controller.createInvoiceAndInvoiceLineItems();
        Test.stopTest();

        
    }
}