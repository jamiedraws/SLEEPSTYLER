<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var version = DtmContext.Version;
    var isIndex = DtmContext.PageCode == "Index";
    var isMobile = DtmContext.IsMobile;
    var isDesktop = !isMobile;
    var isStartPage = DtmContext.Page.IsStartPageType && DtmContext.PageCode != "PaymentForm";
    var productName = SettingsManager.ContextSettings["Label.ProductName"];

    var hashIndex = "#main";
    var hashReviews = "#reviews";
    var hashFAQ = "#faq";

    var linkIndex = isIndex ? hashIndex : String.Format("Index{0}{1}", DtmContext.ApplicationExtension, hashIndex);
    var linkReviews = isIndex ? hashReviews : String.Format("Index{0}{1}", DtmContext.ApplicationExtension, hashReviews);
    var linkFAQ = String.Format("FAQ{0}", DtmContext.ApplicationExtension);
    var linkOrder = "#order";

    if (!isStartPage) {
        linkIndex = "#";
    }

    var displayBanner = true;

    if (version != 3)
    {
		displayBanner = false;
    }
%>

<% if (isDesktop) { %>
<header aria-labelledby="header-title" class="view header view--header">
	<div class="view__in">
		<div class="header__group">
			<a href="<%= linkIndex %>" id="header-logo" class="header__logo">
				<picture class="arp header__sunjoe" style="--arp: 310/160; max-width: 155px">
					<img src="/images/logo-sunjoe.jpg" alt="<%= productName %>">
				</picture>
				<picture class="arp header__xtream" style="--arp: 622/162; max-width: 311px">
					<img src="/images/logo-xtream.jpg" alt="<%= productName %>">
				</picture>
			</a>
			<h1 id="header-title" class="header__title title">
				<span>You Name It. You Aim It.</span>
				<span>Grime is Gone.<sup>&reg;</sup></span>
			</h1>
		</div>
	</div>
</header>
<% } %>


<nav aria-label="Website pages links" class="view nav nav--banner">
    <div class="reveal nav__carousel relative">
		<div class="reveal__in reveal__item nav__float mini">
			<%= Html.Partial("OfferGroup", new ViewDataDictionary {
				{ "modifier", "deal--hero mini__deal" },
				{ "id", "nav-reveal" },
				{ "exclude", new List<string> {
					"orderSingle", "orderMulti", "banner"
				} }
			}) %>
			<a id="nav-fixed-order" href="#order" class="button button--order mini__button">
				<span>Order Now</span>
			</a>
		</div>
		<a href="<%= linkIndex %>" id="nav-logo" class="nav__logo reveal__item reveal__out">
			<picture class="arp nav__sunjoe" style="--arp: 310/160; max-width: 155px">
				<img src="/images/logo-sunjoe.jpg" srcset="/images/logo-sunjoe-60px.jpg 60w, /images/logo-sunjoe.jpg 310w" sizes="(max-width: 600px) 40px" alt="<%= productName %>">
			</picture>
			<picture class="arp nav__xtream" style="--arp: 622/162; max-width: 311px">
				<img src="/images/logo-xtream-sans-text.jpg" srcset="/images/logo-xtream-sans-text-120px.jpg 120w, /images/logo-xtream-sans-text.jpg 622w" sizes="(max-width: 600px) 60px" alt="<%= productName %>">
			</picture>
		</a>
    </div>
	<% if (isStartPage) { %>
	<input class="nav__toggle" type="checkbox" id="nav__toggle">
	<label class="nav__label" for="nav__toggle" aria-label="Toggle Menu">
		<span></span>
	</label>
	<div class="nav__underlay" for="nav__toggle" role="presentation" aria-label="Hide Menu"></div>
	<% } %>
	<% if (isStartPage) { %>
	<div class="nav__pane">
		<div class="nav__group">
			<% if (displayBanner)
                { %>
			<div class="nav__promo">
				<%= Html.Partial("OfferGroup", new ViewDataDictionary {
                    { "modifier", "deal--header" },
                    { "id", "header" },
					{ "standfirst", "Now Only" },
                    { "exclude", new List<string> {
                        "offerMulti", "orderSingle"
                    } }
                }) %>
			</div>
			<% } %>
			<div class="nav__list">
				<a href="<%= linkIndex %>" id="nav-logo" class="nav__logo">
					<picture class="arp nav__sunjoe" style="--arp: 310/160; max-width: 95px">
						<img src="/images/logo-sunjoe.jpg" srcset="/images/logo-sunjoe-60px.jpg 60w, /images/logo-sunjoe.jpg 310w" sizes="(max-width: 600px) 40px" alt="<%= productName %>">
					</picture>
					<picture class="arp nav__xtream" style="--arp: 622/162; max-width: 190px">
						<img src="/images/logo-xtream-sans-text.jpg" srcset="/images/logo-xtream-sans-text-120px.jpg 120w, /images/logo-xtream-sans-text.jpg 622w" sizes="(max-width: 600px) 60px" alt="<%= productName %>">
					</picture>
				</a>
				<% if (isMobile) { %>
				<h1 class="nav__title title">
					<span>You Name It. You Aim It.</span>
					<span>Grime is Gone.<sup>&reg;</sup></span>
				</h1>
				<% } %>
				<a class="nav__link" href="<%= linkIndex %>" id="nav-home" aria-label="Home">
					<span>Home</span>
				</a>
				<a class="nav__link" href="<%= linkFAQ %>" id="nav-faq" aria-label="Frequently Asked Questions">
					<span>FAQs</span>
				</a>
				<a class="nav__link" href="<%= linkReviews %>" id="nav-reviews" aria-label="Reviews From Customers">
					<span>Reviews</span>
				</a>
				<a class="nav__link nav__link--order" href="<%= linkOrder %>" id="nav-order" aria-label="Order <%= productName %> Now">
					<span>Order Now</span>
				</a>
				<div class="nav__deal">
					<%= Html.Partial("OfferGroup", new ViewDataDictionary {
                        { "modifier", "deal--nav" },
                        { "id", "nav" },
                        { "exclude", new List<string> {
							"discountOfSingle", "discountOfMulti", "banner"
						} }
                    }) %>
				</div>
			</div>
		</div>
	</div>
	<% Html.RenderPartial("OfferBanner", Model, new ViewDataDictionary { { "type", "countdown" } }); %>
	<% } %>
</nav>