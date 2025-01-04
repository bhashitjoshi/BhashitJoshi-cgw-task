public class XeroWrapper {

	public cls_Invoices[] Invoices;
	public class cls_Invoices {
		public String Type;	//ACCREC
		public cls_Contact Contact;
		public String DateString;	//2009-09-08T00:00:00
		public String DueDateString;	//2009-10-20T00:00:00
		public String ExpectedPaymentDate;	//2009-10-20T00:00:00
		public String InvoiceNumber;	//OIT:01065
		public String Reference;	//Ref:SMITHK
		public String BrandingThemeID;	//3b148ee0-adfa-442c-a98b-9059a73e8ef5
		public String Url;	//http://www.accounting20.com
		public String CurrencyCode;	//NZD
		public String Status;	//SUBMITTED
		public String LineAmountTypes;	//Inclusive
		public String SubTotal;	//87.11
		public String TotalTax;	//10.89
		public String Total;	//98.00
		public cls_LineItems[] LineItems;
	}
	public class cls_Contact {
		public String ContactID;	//eaa28f49-6028-4b6e-bb12-d8f6278073fc
	}
	public class cls_LineItems {
		public String ItemCode;	//Test 01
		public String Description;	//3 copies of OS X 10.6 Snow Leopard
		public String Quantity;	//3.0000
		public String UnitAmount;	//59.00
		public String TaxType;	//OUTPUT
		public String TaxAmount;	//19.67
		public String LineAmount;	//177.00
		public String AccountCode;	//200
		public cls_Tracking[] Tracking;
	}
	public class cls_Tracking {
		public String TrackingCategoryID;	//e2f2f732-e92a-4f3a-9c4d-ee4da0182a13
		public String Name;	//Region
		public String Option;	//North
	}
	public static XeroWrapper parse(String json){
		return (XeroWrapper) System.JSON.deserialize(json, XeroWrapper.class);
	}
}