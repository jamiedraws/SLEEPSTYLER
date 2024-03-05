<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%
	var EnableOrderForm = SettingsManager.ContextSettings["Order.EnableOrderform", true];
	var ShowMobileOrderForm = SettingsManager.ContextSettings["FrameworkJS/CSS.DtmStyle.ShowOrderFormOnMobile", false];
	var renderOfferDetailsAboveAcceptOffer = SettingsManager.ContextSettings["Order.RenderOfferDetailsAboveAcceptOffer", false];
	var productName = SettingsManager.ContextSettings["Label.ProductName"];
	var isDesktop = !DtmContext.IsMobile;
%>


<section aria-label="Order <%= productName %>" class="view view--section view--form form">
	<div id="order" class="view__anchor"></div>
	<% if (isDesktop) { %>
	<div class="form__bg" data-src-img="/images/_bg-water-footer.jpg">
		<noscript>
			<img src="/images/_bg-water-footer.jpg" alt="">
		</noscript>
	</div>
	<% } %>
	<div class="view__in">
		<div class="form-title reveal-onscreen">
            <%
                var callToOrderGroup = new Dictionary<string, string>()
                {
                    { "www.getsunjoe.com", "800-203-9737" }
                };

                var callToOrderLink = string.Empty;

                foreach (var callToOrder in callToOrderGroup)
                {
                    if (String.Equals(callToOrder.Key, DtmContext.Domain.Domain, StringComparison.InvariantCultureIgnoreCase))
                    {
                        callToOrderLink = String.Format(" Or Call <a id=\"form-title-call-to-order\" href=\"tel:{0}\">{0}</a>", callToOrder.Value);
                    }
                }

                var formTitle = String.Format("Fill out the form below{1} to order your <strong>{0}</strong> now.", productName, callToOrderLink);
            %>

			<span class="form-title__not-available">THIS OFFER IS NOT AVAILABLE IN STORES!</span>
			<span class="form-title__fill-out"><%= formTitle %></span>
		</div>

		<% if ( EnableOrderForm ) { %>

			<%-- // Displays the order form --%>
			<% Html.RenderPartial("OrderForm", Model); %>

		<% } %>
	</div>
</section>