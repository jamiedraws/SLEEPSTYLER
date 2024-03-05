<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<%
    var version = DtmContext.Version;
    var isIndex = DtmContext.PageCode == "Index";
    var isMobile = DtmContext.IsMobile;
    var isDesktop = !isMobile;
    var isFAQ = DtmContext.PageCode == "FAQ";
    var isStartPage = DtmContext.Page.IsStartPageType && DtmContext.PageCode != "PaymentForm";
    var isPaymentPage = DtmContext.PageCode == "PaymentForm" || DtmContext.PageCode == "ProcessPayment";
    var brandName = SettingsManager.ContextSettings["Label.BrandName"];
    var productAttributeName = SettingsManager.ContextSettings["Label.ProductName"];
    var productName = productAttributeName;

    var hashIndex = "#main";
    var hashReviews = "#reviews";
    var hashFAQ = hashIndex;

    var linkIndex = isIndex ? hashIndex : String.Format("Index{0}", DtmContext.ApplicationExtension);
    var linkReviews = isIndex ? hashReviews : String.Format("Index{0}{1}", DtmContext.ApplicationExtension, hashReviews);
    var linkFAQ = isFAQ ? hashFAQ : String.Format("FAQ{0}", DtmContext.ApplicationExtension);

    var sunjoeImage = string.Format(@"
        <picture class=""contain contain--logo-sunjoe logos__sunjoe"">
            <source srcset=""/images/logo-sunjoe-60px.webp"" media=""(max-width: 600px)"" type=""image/webp"">
            <source srcset=""/images/logo-sunjoe.webp"" media=""(min-width: 601px)"" type=""image/webp"">
			<img src=""/images/logo-sunjoe.jpg"" alt=""{0}"">
        </picture>", brandName);

    var xtreamImage = string.Format(@"
        <picture 
            class=""contain contain--logo-xtream logos__xtream"" 
            data-src-img=""/images/logo-xtream-sans-text.jpg""
            data-attr='{{ ""srcset"" : ""/images/logo-xtream-sans-text-120px.jpg 120w, /images/logo-xtream-sans-text.jpg 622w"", ""sizes"" : ""(max-width: 600px) 60px"", ""alt"" : ""{0}"" }}'
        >
        </picture>
    ", productAttributeName);

        var logo = string.Format("{0}{1}", sunjoeImage, xtreamImage);
        var navLogo = logo;

        if (isStartPage)
        {
            var logoContainer = @"<a href=""{0}"" id=""{2}"" class=""{3} logos"">{1}</a>";

            logo = string.Format(logoContainer, linkIndex, logo, "header-logo", "header__logo logos--header");
            navLogo = string.Format(logoContainer, linkIndex, navLogo, "nav-logo", "nav__logo logos--nav");
        } else
        {
            var logoContainer = @"<div class=""logos {1}"">{0}</a>";

            logo = string.Format(logoContainer, logo, "logos--header header__logo");
            navLogo = string.Format(logoContainer, logo, "logos--nav nav__logo");
        }

        var headerTitle = String.Format(@"
        <span class=""title__italicize title__wrap"">
		    <span>You Name It. You Aim It.</span>
		    <span>Grime is Gone.<sup>&reg;</sup></span>
        </span>
    ", productAttributeName);
        var headerClasses = "header__group";
        var navParentClasses = "nav--banner";
        var navClasses = "nav__group";

        if (!isStartPage)
        {
            headerTitle = string.Empty;
            headerClasses = String.Format("{0} header__center", headerClasses);
            navParentClasses = "";
        }

        if (!DtmContext.Page.IsStartPageType || isPaymentPage)
        {
            navClasses = String.Format("{0} nav__center", navClasses);
        }
%>

<header aria-labelledby="header-title" class="view header section @print-only-hide">
  <div class="view__in header__in section__in">
    <div class="<%= headerClasses %>">
      <%= logo %>
      <h1 id="header-title" class="header__title title title--main"><%= headerTitle %></h1>
    </div>
  </div>
</header>

<nav aria-label="Website pages links" class="view nav <%= navParentClasses %> section @print-only-hide">
    <div class="view__in <%= navClasses %>">
        <% if (isStartPage) { %>
            <input class="nav__toggle" type="checkbox" id="nav__toggle" aria-label="Toggle Menu">
            <label class="nav__label" for="nav__toggle" aria-label="Toggle Menu">
                <span></span>
            </label>
        <% } %>

        <%= logo.Replace("header-logo", "nav-logo").Replace("header__logo", "logos--navbar") %>

        <% if (isStartPage) { %>
            <div class="nav__hide-on-bar nav__hide-on-smaller-screen">
                <a id="nav-fixed-order" href="#order" class="btn btn--order btn--is-bigger nav__btn">
			        <span>Order Now</span>
		        </a>
            </div>
            <div class="nav__underlay nav__hide-on-bar" role="presentation"></div>
        <% } else { %>
            <h1 class="nav__title title"><%= headerTitle %></h1>
        <% } %>

        <% if (isStartPage) { %>
        <div class="nav__pane">
            <div class="nav__group nav__in">
                <div class="nav__list">
                    <%= navLogo.Replace("nav-logo", "nav-list-logo") %>
                    <h1 class="nav__title title">
                      <%= headerTitle %>
                    </h1>
                    <a class="nav__link" href="<%= linkIndex %>" id="nav-home" aria-label="Home">
                        <span>Home</span>
                    </a>
                    <a class="nav__link" href="<%= linkFAQ %>" id="nav-faq" aria-label="Frequently Asked Questions">
                        <span>FAQS</span>
                    </a>
                    <a class="nav__link" href="<%= linkReviews %>" id="nav-reviews" aria-label="Real User Reviews">
                        <span>Reviews</span>
                    </a>
                    <a class="nav__link nav__link--order" href="#order" id="nav-order" aria-label="Order a <%= productName %>">
                        <span>Order Now</span>
                    </a>
				    <div class="nav__deal">
					    <a id="nav-pane-order" href="#order" class="btn btn--order nav__btn">
				            <span>Order Now</span>
			            </a>
				    </div>
                </div>
            </div>
        </div>
      <% } %>
    </div>
</nav>

<%
    if (isStartPage)
    {
        Html.RenderPartial("OfferBanner", new ViewDataDictionary { { "type", "none" } });
    }
%>