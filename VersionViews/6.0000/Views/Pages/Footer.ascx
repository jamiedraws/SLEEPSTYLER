<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var isIndex = DtmContext.PageCode == "Index";
    var isPaymentForm = DtmContext.PageCode.Equals("PaymentForm", StringComparison.InvariantCultureIgnoreCase);
    var isPaymentPage = isPaymentForm || DtmContext.PageCode == "ProcessPayment";
    var isFrontPage = DtmContext.Page.IsStartPageType && !isPaymentPage;
    var isUpsell = DtmContext.Page.PageType.Equals("Upsell", StringComparison.InvariantCultureIgnoreCase);
    var v = String.Format("?v={0}", 0);

    var productName = SettingsManager.ContextSettings["Label.ProductName", string.Empty];
%>

<footer aria-label="Copyrights and policies" class="view footer section bg bg--contrast @print-only-hide">
    <div class="view__in section__in">

        <div class="section__block">
            <%
                var logo = string.Format(@"<picture 
                    class=""footer__logo contain contain--logo-sunjoe"" 
                    data-src-img=""/images/logo-sunjoe.svg"" 
                    data-attr='{{ ""alt"" : ""{0}"" }}'>
                        <noscript>
                            <img src=""/images/logo-sunjoe.svg"" alt=""{0}"" />
                        </noscript>
                    </picture>", productName);

                if (!DtmContext.IsProxyIpAddress)
                {
                    logo = string.Format(@"<a 
                        href=""https://snowjoe.com"" 
                        id=""footer-logo-link"" 
                        aria-label=""Official Snow Joe website""
                        target=""_blank"">{0}</a>", logo);
                }
            %>
            <%= logo %>
        </div>

        <% if (isFrontPage)
            {
        %>
        <div class="section__block">
            <% Html.RenderPartial("SitemapList"); %>
        </div>
        <%
            }
        %>
        <address class="section__block footer__copyright">
            <% Html.RenderSnippet("COMMON-FOOTER"); %>
        </address>
    </div>
    <script>
        function scrollToErrorMessages() {
            if ("app" in window) {
                app.require(["order"], function () {
                    app.order.scrollToErrors();
                });
            } else {
                let className = "validation-summary-errors";
                let elements = document.getElementsByClassName(className);
                if (elements.length > 0) {
                    elements[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        }
    </script>
    <%
        if (isFrontPage)
        {


    %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src=\"\/shared\/js\/jquery-3.3.1.min.js\"><\/script>')</script>

    <%
    
        }
    %>
    <%
        if (isPaymentForm)
        {
    %>
    <script type="text/javascript">
            (function () {
                $(document).ready(function () {
                    $("#AcceptOfferButton").on("click", validateForm);
                    $("#AcceptOfferButton").on("click", scrollToErrorMessages);
                    $('#ShippingIsDifferentThanBilling').on("click", toggleShipping);
                    toggleShipping();

                });

                addEventListener("PaymentOptionSelected", function () {
                    togglePhone();
                });

                window.addEventListener("load", function () {
                    scrollToErrorMessages();
                });

                addEventListener("DOMContentLoaded", function () {
                    $(".discount").on("change", togglePhone);
                    $('#PromotionalPhone').on('input', function () {
                        var val = $(this).val() || '';
                        var items = val.replace(/[^0-9]/gi, '').match(/^([0-9]{3})?([0-9]{3})?([0-9]+)$/);
                        var newVal = '';
                        if (items) {
                            items.splice(0, 1);
                            for (var i = 0; i < items.length; i++) {
                                if (typeof (items[i]) == 'undefined') {
                                    items.splice(i, 1);
                                    i--;
                                }
                                else {
                                    items[i] = items[i].substr(0, 4);
                                }
                            }
                            newVal = items.join('-');
                        }
                        $(this).val(newVal);
                    });

                    _dtm.callbackAlert = function () { $.scrollTo($(".vse"), -200); }

                    if ($(".vse").html().length > 0 && typeof $('.validation-summary-errors') != "undefined" && $('.validation-summary-errors').length > 0 && $('.validation-summary-errors').html().length > 0) {
                        $.scrollTo($(".vse"), -200);
                    }
                });

                function togglePhone() {
                    const promoPhone = $("#PromotionalPhoneCt"),
                        hideClass = "hide";
                    if ($("[name='OrderType']:checked").val() == "PayPalEC" && $("#PromotionalTexts").is(":checked")) {
                        promoPhone.removeClass(hideClass);
                    } else {
                        promoPhone.addClass(hideClass);
                    }
                }

            })();
        function customPaypalValidation() {
            if ($("#PromotionalTexts").is(":checked") && $("#PromotionalPhone").val() == "") {
                _dtm.alert("Please enter a valid phone number to recieve the extra 5% off");
                return false;
            }
            return true;
        }

        <% var orderType = ViewData["OrderType"] as string;
        if (orderType != null)
        {
            %>
        window.addEventListener("DOMContentLoaded", function () {
            let otype = $("[name='OrderType'][value='<%=orderType%>']");
            if (otype.length > 0) {
                otype.click();
            }

        });

        <%
        }
        %>

</script>
    <%
        }
    %>
    <script>const loadFWSnippets = false; const loadFacebox = false;</script>
    <script type="text/javascript" src="/shared/js/common.js?v=<%= Dtm.Framework.ClientSites.Web.DtmContext.ApplicationVersion %>&language=<%=Dtm.Framework.ClientSites.SettingsManager.ContextSettings["Language.LanguageType", "English"] %>&cb=1"></script>

    <div class="l-controls left-absolute top-absolute">
        <% 
            if (isFrontPage)
            {
                ViewData["asyncInit"] =  true;
                TempData["asyncInit"] =  true;
            }
        %>
        <% Html.RenderSiteControls(SiteControlLocation.ContentTop); %>
        <% Html.RenderSiteControls(SiteControlLocation.ContentBottom); %>

        
        <% Html.RenderSiteControls(SiteControlLocation.PageBottom); %>

        <style>
            .hud {
                display: none;
            }
        </style>
    </div>
</footer>
<div class="modal" role="dialog" aria-labelledby="modal-text">
    <div class="modal__load-state"></div>
    <div id="modal-text" class="modal__text">Loading</div>

    <% if (!isPaymentForm)
        { %>
    <button type="button" class="modal__button button">Close</button>
    <% } %>
</div>
