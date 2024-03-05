<%@ Control Language="C#" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<% 

    // Columns
    var showPriceColumn = SettingsManager.ContextSettings["OrderFormReview.ShowPriceColumn", false];
    var showShippingColumn = SettingsManager.ContextSettings["OrderFormReview.ShowShippingColumn", false];
    var showRemoveButtonColumn = SettingsManager.ContextSettings["OrderFormReview.ShowRemoveButtonColumn", false];
    var showItemTotalColumn = SettingsManager.ContextSettings["OrderFormReview.ShowItemTotalColumn", false];
    var showQuantityColumnFirst = SettingsManager.ContextSettings["OrderFormReview.ShowQuantityColumnFirst", false];

    // Footers
    var showSubTotalFooter = SettingsManager.ContextSettings["OrderFormReview.ShowSubTotalFooter", false];
    var showShippingFooter = SettingsManager.ContextSettings["OrderFormReview.ShowShippingFooter", false];
    var showStateTaxFooter = SettingsManager.ContextSettings["OrderFormReview.ShowStateTaxFooter", false];
    var showOrderTotalFooter = SettingsManager.ContextSettings["OrderFormReview.ShowOrderTotalFooter", true];
    var showSaleTaxLink = SettingsManager.ContextSettings["OrderFormReview.ShowSalesTax", true];
    var showShippingMessage = SettingsManager.ContextSettings["OrderFormReview.ShowShippingMessage", false];

    // Text
  
    var textOrderTotalFooter = SettingsManager.ContextSettings["OrderFormReview.OrderTotalFooterText", "<b>Estimated Order Total</b>"];
    var textSubTotalFooter = SettingsManager.ContextSettings["OrderFormReview.SubTotalFooterText", "Sub Total:"];
    var textShippingFooter = SettingsManager.ContextSettings["OrderFormReview.ShippingFooterText", "Process & Handling"];
    var textStateTaxFooter = SettingsManager.ContextSettings["OrderFormReview.StateTaxFooterText", "State Tax:"];
    
    var textSaleTaxLink = SettingsManager.ContextSettings["OrderFormReview.SalesTaxLink", "/shared/sales-tax.html"];
    var textSaleTaxLinkTitle = SettingsManager.ContextSettings["OrderFormReview.SalesTaxLinkTitle", "Sales Tax"];
    var textSaleTaxLinkText = SettingsManager.ContextSettings["OrderFormReview.SalesTaxLinkText", "Sales Tax Info"];
    var textSaleTaxPlaceHolder = SettingsManager.ContextSettings["OrderFormReview.SaleTaxBoxText", "Enter Zip Code"];
    var textShippingMessage = SettingsManager.ContextSettings["OrderFormReview.ShippingMessageText", "Standard ground delivery"];
    
    var totalColumnLength = 1 + (showPriceColumn ? 1 : 0) + (showShippingColumn ? 1 : 0) + (showItemTotalColumn ? 1 : 0) + (showRemoveButtonColumn ? 1 : 0);

%>

<%if (showSubTotalFooter)
                { %>
            <tr>
                <td colspan="<%=totalColumnLength %>"><%=textSubTotalFooter %></td>
                <td>
                    <label class="subtotal"><%=DtmContext.ShoppingCart.SubTotal.ToString("C") %></label>
                </td>
            </tr>
            <%} %>
            <%if (showShippingFooter)
                { %>
            <tr>
                <td colspan="<%=totalColumnLength %>"><%=textShippingFooter %></td>
                <td>
                    <label class="phtotal"><%=DtmContext.ShoppingCart.ShippingTotal.ToString("C") %></label>
                </td>
            </tr>
            <%} %>
            <%if (showStateTaxFooter)
                { %>
            <tr>
                <td colspan="<%=totalColumnLength %>">
                    <label for="zc">
                        <%=textStateTaxFooter%>&nbsp;&nbsp;

                  <input type="text" class="zc" id="zc" name="zc" value="<%=ViewData["zc"] %>" placeholder="<%=textSaleTaxPlaceHolder%>" /></label>
                </td>
                <td>
                    <span class="taxtotal"><%=DtmContext.ShoppingCart.GetTotalTax(DtmContext.Order.TaxRate, false).ToString("C") %></span></td>
            </tr>
            <%} %>
            <%if (showOrderTotalFooter)
                { %>
            <tr>
                <td colspan="<%=totalColumnLength %>"><%=textOrderTotalFooter %></td>
                <td>
                    <span class="summary-total"><%=DtmContext.ShoppingCart.Total.ToString("C") %></span></td>
            </tr>
            <%} %>
            <%if (showSaleTaxLink)
                {%>
            <tr>
                <td class="sales-tax-link" colspan="4" align="left"><b><a data-fancybox-url="<%= textSaleTaxLink %>" href="javascript:MM_openBrWindow('<%=textSaleTaxLink%>','window','scrollbars=yes,width=450,height=400,left=0,top=0');" title="<%=textSaleTaxLinkTitle%>"><%=textSaleTaxLinkText%></a></b></td>
            </tr>
            <%} %>
            <%if (showShippingMessage)
                {%>
            <tr>
                <td colspan="4" align="left"><%=textShippingMessage%></td>
            </tr>
            <%} %>

