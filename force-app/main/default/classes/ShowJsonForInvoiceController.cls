public without sharing class ShowJsonForInvoiceController {
    
    public Id recordId { get; set; }
    public String account { get; set; }
    public String invoiceDate { get; set; }
    public String invoiceDueDate { get; set; }
    public String lineItemDescription { get; set; }
    public String lineItemQuantity { get; set; }
    public String lineItemUnitPrice { get; set; }
    public String childRelationshipName { get; set; }
    public String jsonResult {get; set;}
    
    public ShowJsonForInvoiceController() {
        recordId = ApexPages.currentPage().getParameters().get('recordId');
        account = ApexPages.currentPage().getParameters().get('account');
        invoiceDate = ApexPages.currentPage().getParameters().get('invoiceDate');
        invoiceDueDate = ApexPages.currentPage().getParameters().get('invoiceDueDate');
        lineItemDescription = ApexPages.currentPage().getParameters().get('lineItemDescription');
        lineItemQuantity = ApexPages.currentPage().getParameters().get('lineItemQuantity');
        lineItemUnitPrice = ApexPages.currentPage().getParameters().get('lineItemUnitPrice');
        childRelationshipName = ApexPages.currentPage().getParameters().get('childRelationshipName');  
        
        String objectName = String.valueOf(recordId.getsobjecttype());
        List<sObject> sObjects;
        String query;
        if(objectName != NULL){
            query = 'SELECT ' +account+ ', '+invoiceDate+ ', '+invoiceDueDate+ ', ' + '(Select '+lineItemDescription+ ', '+ lineItemQuantity + ', '+ lineItemUnitPrice+ ' FROM '+childRelationshipName+')' +
                ' FROM '+objectName+' WHERE Id = \'' + recordId + '\'';
        }
        
        sYSTEM.DEBUG('QUERY:'+QUERY);
        if(query != NULL){
            sobjects = Database.query(query); 
        }
        if(sobjects != NULL){
            // Create an instance of XeroWrapper
            XeroWrapper wrapper = new XeroWrapper();
            wrapper.Invoices = new List<XeroWrapper.cls_Invoices>();
            for (SObject record : sObjects) {
                XeroWrapper.cls_Invoices invoice = new XeroWrapper.cls_Invoices();
                invoice.Type = 'ACCREC';
                
                // Create and assign contact
                invoice.Contact = new XeroWrapper.cls_Contact();
                invoice.Contact.ContactID = '0000000';
                
                invoice.DateString = String.valueOf(record.get(invoiceDate));
                invoice.DueDateString = String.valueOf(record.get(invoiceDueDate));
                invoice.ExpectedPaymentDate = '2023-12-20T00:00:00';
                invoice.CurrencyCode = 'USD';
                invoice.Status = 'SUBMITTED';
                invoice.LineAmountTypes = 'Exclusive';
                invoice.SubTotal = '100.00';
                invoice.TotalTax = '10.00';
                invoice.Total = (String) record.get(account);
                
                // Create and assign line items
                invoice.LineItems = new List<XeroWrapper.cls_LineItems>();
                List<SObject> childRecords = (List<SObject>) record.getSObjects(childRelationshipName);
                for (SObject childRecord : childRecords) {
                    XeroWrapper.cls_LineItems lineItem = new XeroWrapper.cls_LineItems();
                    lineItem.Description = (String) childRecord.get(lineItemDescription);
                    lineItem.Quantity = String.valueOf(childRecord.get(lineItemQuantity));
                    lineItem.UnitAmount = String.valueOf(childRecord.get(lineItemUnitPrice));
                    lineItem.TaxType = 'OUTPUT';
                    lineItem.TaxAmount = '5.00';
                    lineItem.LineAmount = '100.00';
                    lineItem.AccountCode = '200';
                    invoice.LineItems.add(lineItem);
                }
                wrapper.Invoices.add(invoice);
            }
            // Serialize wrapper to JSON
            jsonResult = System.JSON.serializePretty(wrapper);
        }else{
            jsonResult = 'No data found for the given record.';
        }
        
    }
    
    public pageReference createInvoiceAndInvoiceLineItems(){
        String objectName = String.valueOf(recordId.getsobjecttype());
        List<sObject> sObjects;
        String query;
        Invoice__c invoiceObj;
        
        if(objectName != NULL){
            query = 'SELECT ' +account+ ', '+invoiceDate+ ', '+invoiceDueDate+ ', ' + '(Select '+lineItemDescription+ ', '+ lineItemQuantity + ', '+ lineItemUnitPrice+ ' FROM '+childRelationshipName+')' +
                ' FROM '+objectName+' WHERE Id = \'' + recordId + '\'';
        }
        
        if(query != NULL){
            sobjects = Database.query(query); 
        }
        List<Invoice__c> invList = new List<Invoice__c>();
        if(sObjects != NULL){
            for (SObject record : sObjects) {
                invoiceObj = new Invoice__c(Account__c = String.valueOf(record.get(account)), InvoiceDate__c = Date.valueOf(record.get(invoiceDate)),DueDate__c = Date.valueOf(record.get(invoiceDueDate)));
            }
            Insert invoiceObj;
            List<Invoice_Line_Item__c> invoiceLineItems = new List<Invoice_Line_Item__c>();
            for (SObject record : sObjects) {
                
                List<SObject> childRecords = (List<SObject>) record.getSObjects(childRelationshipName);
                for (SObject childRecord : childRecords) {
                    Invoice_Line_Item__c invcLineItem = new Invoice_Line_Item__c(Invoice__c = invoiceObj.Id, Description__c = (String) childRecord.get(lineItemDescription), Quantity__c = (Decimal)childRecord.get(lineItemQuantity),
                                                                                 UnitPrice__c = (Decimal)childRecord.get(lineItemUnitPrice));
                    
                    invoiceLineItems.add(invcLineItem);
                }
            }
            Insert invoiceLineItems; 
        }
        
        PageReference pg = new PageReference('/' + invoiceObj.Id);
        System.debug('pg:'+pg);
        pg.setRedirect(true);
        return pg;
    }
}