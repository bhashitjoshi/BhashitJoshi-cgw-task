@isTest
public class XeroWrapperTest {

    @isTest
    public static void testParse() {
		String json=		'{'+
		'  "Invoices": ['+
		'    {'+
		'      "Type": "ACCREC",'+
		'      "Contact": {'+
		'        "ContactID": "eaa28f49-6028-4b6e-bb12-d8f6278073fc"'+
		'      },'+
		'      "DateString": "2009-09-08T00:00:00",'+
		'      "DueDateString": "2009-10-20T00:00:00",'+
		'      "ExpectedPaymentDate": "2009-10-20T00:00:00",'+
		'      "InvoiceNumber": "OIT:01065",'+
		'      "Reference": "Ref:SMITHK",'+
		'      "BrandingThemeID": "3b148ee0-adfa-442c-a98b-9059a73e8ef5",'+
		'      "Url": "http://www.accounting20.com",'+
		'      "CurrencyCode": "NZD",'+
		'      "Status": "SUBMITTED",'+
		'      "LineAmountTypes": "Inclusive",'+
		'      "SubTotal": "87.11",'+
		'      "TotalTax": "10.89",'+
		'      "Total": "98.00",'+
		'      "LineItems": ['+
		'        {'+
		'          "ItemCode": "Test 01",'+
		'          "Description": "3 copies of OS X 10.6 Snow Leopard",'+
		'          "Quantity": "3.0000",'+
		'          "UnitAmount": "59.00",'+
		'          "TaxType": "OUTPUT",'+
		'          "TaxAmount": "19.67",'+
		'          "LineAmount": "177.00",'+
		'          "AccountCode": "200",'+
		'          "Tracking": ['+
		'            {'+
		'              "TrackingCategoryID": "e2f2f732-e92a-4f3a-9c4d-ee4da0182a13",'+
		'              "Name": "Region",'+
		'              "Option": "North"'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          "ItemCode": "Test 02",'+
		'          "Description": "Returned Apple Keyboard with Numeric Keypad (faulty)",'+
		'          "Quantity": "1.0000",'+
		'          "UnitAmount": "-79.00",'+
		'          "TaxType": "OUTPUT",'+
		'          "TaxAmount": "-8.78",'+
		'          "LineAmount": "-79.00",'+
		'          "AccountCode": "200"'+
		'        }'+
		'      ]'+
		'    }'+
		'  ]'+
		'}';
        XeroWrapper obj = XeroWrapper.parse(json);
		System.assert(obj != null);
	}
}