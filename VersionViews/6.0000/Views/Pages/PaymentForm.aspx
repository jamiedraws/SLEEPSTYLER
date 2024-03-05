<%@ Page Language="C#" MasterPageFile="~/Shared/Templates/DTM/Layouts/ConfirmationLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>

<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="defer defer--from-top">
        <div class="defer__progress">


    <% using (Html.BeginForm())
        { %>
    <div class="form__group c-brand--form">
        <div class="form__row">
            <h2 class="title section__block">Items In Cart</h2>
            <div class="form__review">
                <%=Html.Partial("SummaryReview") %>
                <p class="form__abbr">*Please enter your address information below for the State Tax to populate above.</p>
            </div>
        </div>

        <div class="form__row">
            <h2 class="title section__block">Enter Payment And Billing Information</h2>
            <div class="form__vse view">
                <div id="vse-error" class="view__anchor"></div>
                <strong class="form__abbr">
                    <abbr title="Asterisks can appear beside the form field name and can apply to both text fields and drop down fields.">*</abbr><%= LabelsManager.Labels["RequiredFieldDisclaimer"] %>
                </strong>
                <div class="vse" data-vse-scroll>
                    <%= Html.ValidationSummary("The following errors have occured:") %>
                </div>
            </div>

            <div class="form__group">
                <%
                    Html.RenderPartial("PaymentInfo");
                    if (DtmContext.Order != null)
                    {

                        var billFullName = DtmContext.Order.BillingFirstName;
                        if (!string.IsNullOrWhiteSpace(DtmContext.Order.BillingLastName))
                        {
                            billFullName += " " + DtmContext.Order.BillingLastName;
                        }
                        ViewData["BillingFullName"] = ViewData["BillingFullName"] ?? billFullName;
                        ViewData["BillingStreet"] = ViewData["BillingStreet"] ?? DtmContext.Order.BillingStreet;
                        ViewData["BillingStreet2"] = ViewData["BillingStreet2"] ?? DtmContext.Order.BillingStreet2;
                        ViewData["BillingCity"] = ViewData["BillingCity"] ?? DtmContext.Order.BillingCity;
                        ViewData["BillingState"] = ViewData["BillingState"] ?? DtmContext.Order.BillingState;
                        ViewData["BillingZip"] = ViewData["BillingZip"] ?? DtmContext.Order.BillingZip;
                        ViewData["Phone"] = ViewData["Phone"] ?? DtmContext.Order.Phone;
                        ViewData["Email"] = ViewData["Email"] ?? DtmContext.Order.Email;

                        if (!DtmContext.Order.ShippingIsSameAsBilling)
                        {
                            var shipFullName = DtmContext.Order.ShippingFirstName;
                            if (!string.IsNullOrWhiteSpace(DtmContext.Order.ShippingLastName))
                            {
                                shipFullName += " " + DtmContext.Order.ShippingLastName;
                            }
                            ViewData["ShippingFullName"] = ViewData["ShippingFullName"] ?? shipFullName;
                            ViewData["ShippingStreet"] = ViewData["ShippingStreet"] ?? DtmContext.Order.ShippingStreet;
                            ViewData["ShippingStreet2"] = ViewData["ShippingStreet2"] ?? DtmContext.Order.ShippingStreet2;
                            ViewData["ShippingCity"] = ViewData["ShippingCity"] ?? DtmContext.Order.ShippingCity;
                            ViewData["ShippingState"] = ViewData["ShippingState"] ?? DtmContext.Order.ShippingState;
                            ViewData["ShippingZip"] = ViewData["ShippingZip"] ?? DtmContext.Order.ShippingZip;
                        }

                    }

                    Html.RenderPartial("ContactInfo");
               %>
            </div>
        </div>

        <div class="form__row">
            <% Html.RenderPartial("AdditionalOptions"); %>
        </div>

        <div class="form__row">
            <%-- // BEGIN #calltoAction --%>
            <fieldset id="calltoAction">

                <ul class="form__fieldset">

                    <%-- // @PROCESS ORDER BUTTON --%>
                    <li class="form__field form__submit">
                        <button id="AcceptOfferButton" name="acceptOffer" type="submit" class="btn btn--order">
                            Process Order
                        </button>
                    </li>

                    <%-- // @PROCESS ORDER TEXT --%>
                    <li class="c-brand--form__submission o-grid--vert--center u-vw--100 fn--center u-mar--top">
                        <p><%= LabelsManager.Labels["SubmissionDisclaimer"] %></p>
                        <% Html.RenderSiteControl("InsureShipCheckbox"); %>
                    </li>

                    <%-- // @SSL BADGE --%>
                    <li class="form__field u-mar--vert @x2-mar">
                        <picture class="contain contain--square" data-src-img="/shared/images/PositiveSSL_tl_trans.png" data-attr='{ "alt" : "Secure Site. SSL Encryption" }'>
                            <noscript>
                                <img src="/shared/images/PositiveSSL_tl_trans.png" alt="Secure Site. SSL Encryption">
                            </noscript>
                        </picture>
                    </li>

                </ul>

            </fieldset>
            <%-- // END #calltoAction --%>
        </div>
    </div>

    <script>
        let orderTotal = <%=DtmContext.Order.OrderTotal %>;
        registerEvent("SummaryCartUpdated", function (event) {
            handleAffirmEstimate();
            $('tfoot tr:nth-child(3) .tfoot_td--label').text('State Tax*');
            let orderTotalHtml = $("#OrderTotal").html();
            orderTotal = parseFloat(orderTotalHtml.substring(1, orderTotalHtml.length));
            calculateTax();

        });

        $(window).load(function () {
            handleAffirmEstimate();
            $('tfoot tr:nth-child(3) .tfoot_td--label').text('State Tax*');
            calculateTax();

        });

        $('form input').on('change keyup', function () {

            calculateTax();

        });

        function calculateTax() {
            var countryCode = $('#BillingCountry').val();
            var stateCode = $('#BillingState').val();
            var zipCode = $('#BillingZip').val();
            var hasAllValues = countryCode.length > 1 && stateCode.length > 1 && zipCode.length > 4;

            if (hasAllValues) {
                getTax(countryCode, stateCode, zipCode, true);

            }
        }
        function getTax(countryCode, stateCode, zipCode, isStartPageType) {
            var url = "/shared/services/GetTax.ashx";
            try {
                $.post(url,
                    {
                        c: countryCode,
                        s: stateCode,
                        z: zipCode,
                        pt: isStartPageType,
                        o: '<%=DtmContext.OfferCode%>',
                        v: '<%=DtmContext.Version%>'
                    },
                    function (data) {
                        if (data) {
                            $('#TotalTax').html('$' + data.TaxAmount);
                            let $orderTotal = $("#OrderTotal"),
                                orderTotalFloat = orderTotal + parseFloat(data.TaxAmount);
                            $orderTotal.html("$" + orderTotalFloat.toFixed(2));
                        } else {
                            console.log('could not estimate tax');
                        }
                    });
            } catch (e) {
                console.log(e);
            }
        }
        function handleAffirmEstimate() {
            var items = __cartItems;
            var hasShovel = $.inArray("MAIN1A", items) !== -1;
            var hasBlower = $.inArray("MAIN2A", items) !== -1;
            var hasBoth = hasShovel && hasBlower;
            var estimateText = "";
            var estimateAmount = 0;
            var orderTotal = $('#OrderTotal').html().replace('$', '');
            var orderTotalAmount = parseFloat(orderTotal) * 100;
            var finalTotalAmount = parseInt(orderTotalAmount);

            if (hasBoth) {
                estimateText = "Payments as low as $56 / mo";

            } else if (hasBlower) {
                estimateText = "Payments as low as $37 / mo";
            } else if (hasShovel) {
                estimateText = "Payments as low as $19 / mo";
            }

            $('#affirmLearnMore_PaymentForm').attr('data-amount', finalTotalAmount);
            $('.affirm__prefix').text(estimateText);

            if ("affirm" in window) {
                affirm.ui.refresh();
            }
        }
    </script>
    <% } %>
        </div>
    </div>
</asp:Content>

