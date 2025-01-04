public class InvoiceController {
    public Id recordId { get; set; }
    public String account { get; set; }
    public String invoiceDate { get; set; }
    public String invoiceDueDate { get; set; }
    public String lineItemDescription { get; set; }
    public String lineItemQuantity { get; set; }
    public String lineItemUnitPrice { get; set; }
    public String childRelationshipName { get; set; }


    public InvoiceController() {
        // Get URL parameters
        recordId = ApexPages.currentPage().getParameters().get('origin_record');
        account = ApexPages.currentPage().getParameters().get('account');
        invoiceDate = ApexPages.currentPage().getParameters().get('invoice_date');
        invoiceDueDate = ApexPages.currentPage().getParameters().get('invoice_due_date');
        lineItemDescription = ApexPages.currentPage().getParameters().get('line_item_description');
        lineItemQuantity = ApexPages.currentPage().getParameters().get('line_item_quantity');
        lineItemUnitPrice = ApexPages.currentPage().getParameters().get('line_item_unit_price');
        childRelationshipName = ApexPages.currentPage().getParameters().get('child_relationship_name');       
    }
    
    // Method to redirect to the new page
    public PageReference redirectToShowJsonPage() {
        PageReference newPage = Page.ShowJsonForInvoice; // Replace with your VF page name
        newPage.getParameters().put('recordId', String.valueOf(recordId));
        newPage.getParameters().put('account', account);
        newPage.getParameters().put('invoiceDate', invoiceDate);
        newPage.getParameters().put('invoiceDueDate', invoiceDueDate);
        newPage.getParameters().put('lineItemDescription', lineItemDescription);
        newPage.getParameters().put('lineItemQuantity', lineItemQuantity);
        newPage.getParameters().put('lineItemUnitPrice', lineItemUnitPrice);
        newPage.getParameters().put('childRelationshipName', childRelationshipName);
        return newPage;
    }
    
    /*public static void createAndShowJson(Id recordId){
        String objectName = String.valueOf(recordId.getsobjecttype());
        if(objectName != NULL){
            query = 'SELECT ' +account+ ', '+invoiceDate+ ', '+invoiceDueDate+ ', ' + '(Select '+lineItemDescription+ ', '+ lineItemQuantity + ', '+ lineItemUnitPrice+ ' FROM '+childRelationshipName+')' +
                		   ' FROM '+objectName+' WHERE Id = \'' + recordId + '\'';
        }
        
        sYSTEM.DEBUG('QUERY:'+QUERY);
        if(query != NULL){
           sobjects = Database.query(query); 
        }
        for (SObject record : sObjects) {
            accountVal = (String) record.get(account); // Account field
            invoiceDateVal = (Date) record.get(invoiceDate); // Invoice Date field
            invoiceDueDateVal = (Date) record.get(invoiceDueDate); // Invoice Due Date field
            List<SObject> childRecords = (List<SObject>) record.getSObjects(childRelationshipName);
            for (SObject childRecord : childRecords) {
                lineItemDescriptionVal = (String) childRecord.get(lineItemDescription);
                lineItemQuantityVal = (Decimal) childRecord.get(lineItemQuantity);
                lineItemUnitPriceVal = (Decimal) childRecord.get(lineItemUnitPrice);
            }
        }
    } */
}