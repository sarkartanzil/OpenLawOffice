﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<OpenLawOffice.WebClient.ViewModels.Billing.InvoiceViewModel>" %>
<%@ Import Namespace="OpenLawOffice.WebClient.Helpers" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Timesheet</title>
    <style>
    body
    {
        font-size: 8pt;
        font-family: Verdana, Helvetica, Sans-Serif;
    }
    </style>
</head>
<body style="background: white; margin: 5px; width: 511pt;">
    
    <div style="border: none; color: Black; padding: 5px;">
        <div style="height: 75px; display: inline-block; font-size: 10pt;">
            <span style="font-weight: bold;"><%: ViewData["FirmName"] %></span><br />
            <%: ViewData["FirmAddress"] %><br />
            <%: ViewData["FirmCity"] %>, <%: ViewData["FirmState"] %> <%: ViewData["FirmZip"] %><br />
            Phone: <%: ViewData["FirmPhone"] %><br />
            Web: <%: ViewData["FirmWeb"] %>
        </div>

        <div style="float: right; font-weight: normal; font-size: 32px; display: inline-block;">
            Invoice
        </div>
        
        <br />

        <div style="display: inline-block; margin-top: 25px; margin-left: 5px; border: 1px solid #c0c0c0; width: 185pt;">
            <div style="display: block; background: #dddddd; font-size: 10pt;">Bill To:</div>
            <div><%: Model.BillTo_NameLine1 %></div>
            <% if (!string.IsNullOrEmpty(Model.BillTo_NameLine2))
                { %>
            <div><%: Model.BillTo_NameLine2 %></div>            
            <% } %>
            <div><%: Model.BillTo_AddressLine1%></div>
            <% if (!string.IsNullOrEmpty(Model.BillTo_AddressLine2))
                { %>
            <div><%: Model.BillTo_AddressLine2%></div>            
            <% } %>
            <div><%: Model.BillTo_City%>, <%: Model.BillTo_State%> <%: Model.BillTo_Zip %></div>
        </div>

        <div style="display: inline-block; vertical-align: top; padding-left: 15px; width: 290pt;">
            <table cellpadding="0" cellspacing="0" style="border: none; padding: 0px;">
                <tr>
                    <td style="padding: 0px; text-align: right;">Invoice No.:</td>
                    <td style="padding: 0 0 0 5px;"><%: Model.Id %></td>
                </tr>
                <tr>
                    <td style="padding: 0px; text-align: right;">External Invoice No.:</td>
                    <td style="padding: 0 0 0 5px;"><%: Model.ExternalInvoiceId %></td>
                </tr>
                <tr>
                    <td style="padding: 0px; text-align: right;">Invoice Date:</td>
                    <td style="padding: 0 0 0 5px;"><%: Model.Date.ToString("M/d/yyyy") %></td>
                </tr>
                <tr>
                    <td style="padding: 0px; text-align: right;">Due Date:</td>
                    <td style="padding: 0 0 0 5px;"><%: Model.Due.ToString("M/d/yyyy") %></td>
                </tr>
                <% if (Model.Matter != null && !string.IsNullOrEmpty(Model.Matter.Title))
                   { %>
                <tr>
                    <td style="padding: 0px; text-align: right;">Matter:</td>
                    <td style="padding: 0 0 0 5px;"><%: Model.Matter.Title%></td>
                </tr>
                <% } 
                   if (Model.Matter != null && !string.IsNullOrEmpty(Model.Matter.Title))
                   { %>
                <tr>
                    <td style="padding: 0px; text-align: right;">Case No.:</td>
                    <td style="padding: 0 0 0 5px;"><%: Model.Matter.CaseNumber %></td>
                </tr>
                <% } %>
            </table>
        </div>

        <br />

        <div style="text-align: left; margin: 5px 0 0 0; padding: 2px 0px 2px 5px;
            font-size: 12px; font-weight: bold; border-collapse: collapse;
            border-top-left-radius: 5px; border-top-right-radius: 5px; -moz-border-top-left-radius: 5px;
            -moz-border-top-right-radius: 5px; background: #f5f5f5;">Expenses</div>
        
        <div style="border: none; padding: 0;">            
            <table cellpadding="0" cellspacing="0" style="border: none; width: 100%;">
                <thead style="background: #dddddd; text-align: center; font-weight: bold;">
                    <tr>
                        <td style="width: 100px;">
                            Incurred
                        </td>
                        <td>
                            Vendor
                        </td>
                        <td>
                            Details
                        </td>
                        <td style="width: 100px;">
                            Amount
                        </td>  
                    </tr>      
                </thead>
                <tbody>
                <%
                    bool altRow = true;
                    decimal expSum = 0;
                    for (int i=0; i<Model.Expenses.Count; i++)
                    {
                        OpenLawOffice.WebClient.ViewModels.Billing.InvoiceExpenseViewModel item = Model.Expenses[i];
                        altRow = !altRow;
                        expSum += item.Amount;
                        if (altRow)
                        { %> <tr style="background-color: #f5f5f5;"> <% }
                        else
                        { %> <tr> <% }
                        %>
                        <td><%: item.Expense.Incurred.ToShortDateString() %></td>
                        <td><%: item.Expense.Vendor %></td>
                        <td><%: item.Details %></td>
                        <td style="text-align: center;"><%: item.Amount.ToString("C") %></td>
                    </tr>
                <% }
                    altRow = !altRow;
                if (altRow)
                { %> <tr style="background-color: #f5f5f5;"> <% }
                else
                { %> <tr> <% } %>
                    <td colspan="3" style="text-align: right; font-weight: bold;">
                        Total:
                    </td>
                    <td style="text-align: center; font-weight: bold;">
                        <%: expSum.ToString("C") %>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        
        <br />

        <div style="text-align: left; margin: 5px 0 0 0; padding: 2px 0px 2px 5px;
            font-size: 12px; font-weight: bold; border-collapse: collapse;
            border-top-left-radius: 5px; border-top-right-radius: 5px; -moz-border-top-left-radius: 5px;
            -moz-border-top-right-radius: 5px; background: #f5f5f5;">Fees</div>
        
        <div style="border: none; padding: 0;">            
            <table cellpadding="0" cellspacing="0" style="border: none; width: 100%;">
                <thead style="background: #dddddd; text-align: center; font-weight: bold;">
                    <tr>
                        <td style="width: 100px;">
                            Incurred
                        </td>
                        <td>
                            Details
                        </td>
                        <td style="width: 100px;">
                            Amount
                        </td>  
                    </tr>      
                </thead>
                <tbody>
                <%
                    altRow = true;
                    decimal feeSum = 0;
                    for (int i=0; i<Model.Fees.Count; i++)
                    {
                        OpenLawOffice.WebClient.ViewModels.Billing.InvoiceFeeViewModel item = Model.Fees[i];
                        altRow = !altRow;
                        feeSum += item.Amount;
                        if (altRow)
                        { %> <tr style="background-color: #f5f5f5;"> <% }
                        else
                        { %> <tr> <% }
                        %>
                        <td><%: item.Fee.Incurred.ToShortDateString() %></td>
                        <td><%: item.Fee.Details %></td>
                        <td style="text-align: center;"><%: item.Fee.Amount.ToString("C") %></td>
                    </tr>
                <% }
                    altRow = !altRow;
                if (altRow)
                { %> <tr style="background-color: #f5f5f5;"> <% }
                else
                { %> <tr> <% } %>
                    <td colspan="2" style="text-align: right; font-weight: bold;">
                        Total:
                    </td>
                    <td style="text-align: center; font-weight: bold;">
                        <%: feeSum.ToString("C") %>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <br />

        <div style="text-align: left; margin: 5px 0 0 0; padding: 2px 0px 2px 5px;
            font-size: 12px; font-weight: bold; border-collapse: collapse;
            border-top-left-radius: 5px; border-top-right-radius: 5px; -moz-border-top-left-radius: 5px;
            -moz-border-top-right-radius: 5px; background: #f5f5f5;">Time</div>
        
        <div style="border: none; padding: 0;">            
            <table cellpadding="0" cellspacing="0" style="border: none; width: 100%;">
                <thead style="background: #dddddd; text-align: center; font-weight: bold;">
                    <tr>
                        <td style="width: 100px;">
                            Date
                        </td>
                        <td>
                            Details
                        </td>
                        <td style="width: 120px;">
                            Duration (h:m)
                        </td>
                        <td style="width: 100px;">
                            Rate ($/hr.)
                        </td>  
                        <td style="width: 100px;">
                            Amount
                        </td>  
                    </tr>      
                </thead>
                <tbody>
                <%
                    altRow = true;
                    decimal timeSum = 0;
                    for (int i=0; i<Model.Times.Count; i++)
                    {
                        OpenLawOffice.WebClient.ViewModels.Billing.InvoiceTimeViewModel item = Model.Times[i];
                        altRow = !altRow;
                        timeSum += (decimal)item.Duration.TotalHours * item.PricePerHour;
                        if (altRow)
                        { %> <tr style="background-color: #f5f5f5;"> <% }
                        else
                        { %> <tr> <% }
                        %>
                        <td><%: item.Time.Start.ToShortDateString() %></td>
                        <td><%: item.Time.Details %></td>
                        <td style="text-align: center;"><%: TimeSpanHelper.TimeSpan(item.Time.Duration, false) %></td>
                        <td style="text-align: center;"><%: item.PricePerHour.ToString("C") %></td>
                        <td style="text-align: center;"><%: string.Format("{0:C}", (decimal)item.Time.Duration.TotalHours * item.PricePerHour) %></td>
                    </tr>
                <% }
                    altRow = !altRow;
                if (altRow)
                { %> <tr style="background-color: #f5f5f5;"> <% }
                else
                { %> <tr> <% } %>
                    <td colspan="4" style="text-align: right; font-weight: bold;">
                        Total:
                    </td>
                    <td style="text-align: center; font-weight: bold;">
                        <%: timeSum.ToString("C") %>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        
        <div style="display: block; text-align: right; padding-top: 20px; padding-right: 20px; height: 100px;">
            <table border="0" cellpadding="0" cellspacing="0" style="float: right; border: none;">
                <tr>
                    <td style="text-align: right; padding-right: 5px;">Subtotal:</td>
                    <td><%: Model.Subtotal.ToString("C") %></td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-right: 5px;">Tax Amount:</td>
                    <td><%: Model.TaxAmount.ToString("C") %></td>
                </tr>
                <tr style="font-weight: bold;">
                    <td style="text-align: right; padding-right: 5px; padding-top: 5px;">Total Due:</td>
                    <td style="padding-top: 5px;"><%: Model.Total.ToString("C") %></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>