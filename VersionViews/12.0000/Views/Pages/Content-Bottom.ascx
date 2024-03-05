<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%
  var EnableOrderForm = SettingsManager.ContextSettings["Order.EnableOrderform", true];
  var ShowMobileOrderForm = SettingsManager.ContextSettings["FrameworkJS/CSS.DtmStyle.ShowOrderFormOnMobile", false];
  var isDesktop = !DtmContext.IsMobile;
  var productName = SettingsManager.ContextSettings["Label.ProductName"];
%>


<section aria-label="Order" class="view section defer defer--from-top">
    <div id="order" class="view__anchor"></div>
    <div class="defer__progress">
    <% if ( EnableOrderForm && !DtmContext.PageCode.Equals("PaymentForm", StringComparison.InvariantCultureIgnoreCase)) { %>
        <%= Html.Partial("OfferBanner", new ViewDataDictionary { { "type", "fall" } }) %>
        <div class="view__in section__in form-title">
            <%
                var domain = DtmContext.Domain.Domain;

                if (DtmContext.IsStage)
                {
                    domain = Request["testdomain"] as string ?? domain;
                }

                var callToOrderGroup = new Dictionary<string, string>()
                {
                    { "www.getsunjoe.com", "800-203-9737" },
                    { "www.buysunjoe.com", "800-203-9737" },
                    { "www.trysunjoe.com", "800-203-9737" },
                    { "www.sunjoeontv.com", "800-203-9737" },
                    { "www.sunjoetvoffer.com", "800-203-9737" },
                    { "www.gowithsunjoe.com", "800-203-9737" }
                };

                var callToOrderLink = string.Empty;

                foreach (var callToOrder in callToOrderGroup)
                {
                    if (String.Equals(callToOrder.Key, domain, StringComparison.InvariantCultureIgnoreCase))
                    {
                        callToOrderLink = String.Format(" or call <a id=\"form-title-call-to-order\" href=\"tel:{0}\">{0}</a>", callToOrder.Value);
                    }
                }

                var formTitle = String.Format("Fill Out The Form Below {0} To Order Your <span>{1}</span>", callToOrderLink, productName);
            %>

	        <span class="form-title__not-available">THIS OFFER IS NOT AVAILABLE IN STORES!</span>
	        <span class="form-title__fill-out"><%= formTitle %></span>
        </div>

        <div class="view__in section__in form__in dtm__in">
            <% Html.RenderPartial("OrderForm", Model); %>
        </div>
    <% } %>
    </div>
</section>