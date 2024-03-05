<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<%
    var version = DtmContext.Version;
    var modifier = ViewData["modifier"] as string ?? string.Empty;
    var id = ViewData["id"] as string ?? string.Empty;
    var standfirst = ViewData["standfirst"] as string ?? string.Empty;
    var bannerType = ViewData["bannerType"] as string ?? "discount";
    var excludeList = ViewData["exclude"] as List<string> ?? new List<string>();

    var offer = new Offer();
    var productCodeSingle = offer.ProductCodeSingleOffer;
    var productCodeMulti = offer.ProductCodeMultiOffer;

    // exclude components from rendering
    var excludeBanner = excludeList.Any(el => el.Equals("banner"));

    var excludeOfferMulti = excludeList.Any(el => el.Equals("offerMulti"));
    var excludeOrderMulti = excludeList.Any(el => el.Equals("orderMulti"));
    var excludeDiscountOfMulti = excludeList.Any(el => el.Equals("discountOfMulti"));

    var excludeOfferSingle = excludeList.Any(el => el.Equals("offerSingle"));
    var excludeOrderSingle = excludeList.Any(el => el.Equals("orderSingle"));
    var excludeDiscountOfSingle = excludeList.Any(el => el.Equals("discountOfSingle"));

    var offerSingle = new ViewDataDictionary
    {
        { "productCode", productCodeSingle },
        { "id", id },
        { "excludeDiscountOf", excludeDiscountOfSingle },
        { "type", bannerType }
    };

    if (!String.IsNullOrEmpty(standfirst))
    {
        offerSingle.Add("standfirst", standfirst);
    }

    var offerMulti = new ViewDataDictionary
    {
        { "productCode", productCodeMulti },
        { "id", id },
        { "excludeDiscountOf", excludeDiscountOfMulti }
    };
%>
<div id="deal-<%= id %>" class="deal <%= modifier %>">
    <%
        if (!excludeBanner)
        {
            Html.RenderPartial("OfferBanner", offerSingle);
        }
    %>
	<div class="deal__group">
        <% if (!excludeOfferMulti)
            { %>
		<div class="deal__item">
			<div class="deal__offer">
				<%= Html.Partial("OfferMulti", offerMulti) %>
			</div>
            <% if (!excludeOrderMulti)
                { %>
			<div class="deal__order">
				<a id="<%= id %>-multi-pay" href="#order" class="btn btn--order deal__btn">
					<span>Order Now</span>
				</a>
			</div>
            <% } %>
		</div>
        <% } %>
        <% if (!excludeOfferSingle)
            { %>
        <div class="deal__separate divider-line">
            <span class="deal__burst">Or</span>
        </div>
		<div class="deal__item">
			<div class="deal__offer">
				<%= Html.Partial("OfferSingle", offerSingle) %>
			</div>
            <% if (!excludeOrderSingle)
                { %>
			<div class="deal__order">
				<a id="<%= id %>-single-pay" href="#order" class="btn btn--order deal__btn">
					<span>Order Now</span>
				</a>
			</div>
            <% } %>
		</div>
        <% } %>
	</div>
</div>