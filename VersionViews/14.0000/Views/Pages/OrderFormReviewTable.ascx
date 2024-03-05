<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Dtm.Framework.Base.Models.BaseClientViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%
    var enableOrderFormReviewTable = SettingsManager.ContextSettings["OrderFormReview.Enable", false];
    var enableEditableQuantity = SettingsManager.ContextSettings["OrderFormReview.EnableEditableQuantity", false];
    var enableClearCartOnAdd = SettingsManager.ContextSettings["OrderFormReview.EnableClearCartOnAdd", false];
    var readOnlyTable = SettingsManager.ContextSettings["OrderFormReview.ReadOnlyTable", false];
    var enableJumpToCartOnChange = SettingsManager.ContextSettings["OrderFormReview.EnableJumpToCartOnChange", false];
    var enableAddPhToSubtotal = SettingsManager.ContextSettings["OrderFormReview.EnableAddPhToSubtotal", false];
    var enableCustomCartMode = SettingsManager.ContextSettings["OrderFormReview.EnableCustomCartMode", false];
    var enableZeroQuantity = SettingsManager.ContextSettings["OrderFormReview.AllowZeroQuantityWhenEditable", true];
    var enableKeepItemIfZero = SettingsManager.ContextSettings["OrderFormReview.KeepItemIfZero", false] && enableEditableQuantity;
    var enableToggleShippingFields = SettingsManager.ContextSettings["OrderFormReview.EnableToggleShippingFields", false];
    var enableActionQuantityTextbox = SettingsManager.ContextSettings["OrderFormReview.EnableActionQuantityTextBox", false];

    var __afId = Request.QueryString["a"];
    var __subAfId = Request.QueryString["s"];
    var __clickId = Request.QueryString["clickID"];
    var __mediaId = Request.QueryString["mid"];

    var customCartPageCodes = (SettingsManager.ContextSettings["OrderFormReview.CustomCartModePageCodesCSV", string.Empty] ?? string.Empty)
                                        .Split(',');

    if (customCartPageCodes.Any(pc => !string.IsNullOrWhiteSpace(pc) && pc.Equals(DtmContext.PageCode, StringComparison.InvariantCultureIgnoreCase)))
    {
        enableCustomCartMode = true;
    }

    var showOrderFormReviewTable = SettingsManager.ContextSettings["OrderFormReview.ShowReviewTable", true];

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
    var textItemColumn = SettingsManager.ContextSettings["OrderFormReview.ItemColumnText", "Item"];
    var textItemTotalColumn = SettingsManager.ContextSettings["OrderFormReview.ItemTotalColumnText", "Total"];
    var textQuantityColumn = SettingsManager.ContextSettings["OrderFormReview.QuantityColumnText", "Quantity"];
    var textPriceColumn = SettingsManager.ContextSettings["OrderFormReview.PriceColumnText", "Price"];
    var textShippingColumn = SettingsManager.ContextSettings["OrderFormReview.ShippingColumnText", "P&H"];
    var textStepHeader = SettingsManager.ContextSettings["OrderFormReview.StepHeaderText", "<strong>STEP 2:</strong><br />Review your order"];

    //Table Label Variables
    var textFutureCharges = LabelsManager.Labels["FutureChargesText"] ?? "Future Charges";

    //Currency symbol
    var currencySymbol = SettingsManager.ContextSettings["OrderFormReview.CurrencySymbol", "$"];

    //SubTables
    var showFutureChargesSubTable = SettingsManager.ContextSettings["OrderFormReview.ShowFutureChargesSubTable", false];
    var showFullPaymentSummarySubTable = SettingsManager.ContextSettings["OrderFormReview.ShowFullPaymentSummarySubTable", false];
    var futureChargesTableOffset = SettingsManager.ContextSettings["OrderFormReview.FutureChargesIndexOffset", 0];

    //PromoCodes
    var showPromoCodeButton = SettingsManager.ContextSettings["OrderFormReview.ShowPromoCodeButton", false];

    var totalColumnLength = 1 + (showPriceColumn ? 1 : 0) + (showShippingColumn ? 1 : 0) + (showItemTotalColumn ? 1 : 0) + (showRemoveButtonColumn ? 1 : 0);

    Func<int, string> getFuturePaymentSuffix = (number) =>
    {
        if (number > 3)
        {
            return "th";
        }
        else if (number > 2)
        {
            return "rd";
        }
        else if (number > 1)
        {
            return "nd";
        }
        else
        {
            return "st";
        }
    };

%>

<%if (enableOrderFormReviewTable)
    { %>
<%if (!enableCustomCartMode)
    { %>

<div id="reviewOrder" <%if (!showOrderFormReviewTable)
    {%>class="hide" <%} %>>
    <div class="FormHeadlineL"><%=textStepHeader %></div>

    <style>
        .alignTextRight {
            text-align: right;
        }

        .alignTextLeft {
            text-align: left;
        }

        .disableToggleClick {
            pointer-events: none;
        }
    </style>

    <table id="orderReview" class="orderItemsTable reviewTable">
        <thead class="reviewTableHead">
            <tr>
                <%if (showQuantityColumnFirst)
                    {%>
                <th><%=textQuantityColumn %></th>
                <%} %>
                <th><%=textItemColumn %></th>
                <%if (showQuantityColumnFirst == false)
                    {%>
                <th><%=textQuantityColumn %></th>
                <%} %>
                <%if (showPriceColumn)
                    { %>
                <th><%=textPriceColumn %></th>
                <%} %>
                <%if (showShippingColumn)
                    { %>
                <th><%=textShippingColumn %></th>
                <%} %>
                <%if (showItemTotalColumn)
                    { %>
                <th><%=textItemTotalColumn %></th>
                <%} %>
                <%if (showRemoveButtonColumn)
                    { %>
                <th></th>
                <%} %>
            </tr>
        </thead>
        <tbody class="reviewTableBody">
            <%Html.RenderPartial("OrderFormReviewTableRow"); %>
        </tbody>
        <tfoot class="reviewTableFoot alignTextRight">
            <%Html.RenderPartial("OrderFormReviewTableFooter"); %>
        </tfoot>
    </table>
</div>
<script>
    window['CartItems'] = [];
    window['PageCode'] = '<%=DtmContext.PageCode%>';
<%
    foreach (var item in DtmContext.ShoppingCart.Items)
    {
%>
    window['CartItems'].push('<%=item.ProductCode%>');
<%
    }
%>

</script>
<%
        }
    }
%>
