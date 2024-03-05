<%@ Page Language="C#" MasterPageFile="~/VersionViews/7.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    var brandName = SettingsManager.ContextSettings["Label.BrandName"];
    var productName = SettingsManager.ContextSettings["Label.ProductName"];
%>

<main aria-label="Offer" class="view hero section">
    <div id="main" class="view__anchor"></div>
    <div class="view__in hero__in section__in bg bg--image">
        <div class="hero__group">
            <picture class="contain contain--hero-product hero__product">
                <source srcset="/images/product-xtream-sm.webp" media="(max-width: 500px)" type="image/webp" />
                <source srcset="/images/product-xtream.webp" media="(min-width: 501px)" type="image/webp" />
                <img src="/images/product-xtream.jpg" alt="Product display of the Sun Joe SPX-3000 XTREAM">
            </picture>
            <div class="hero__offer">
                <%= Html.Partial("OfferGroup", new ViewDataDictionary {
                    { "modifier", "deal--hero reveal-offscreen" },
                    { "id", "hero" },
                    { "exclude", new List<string>
                        { "orderMulti", "orderSingle" }
                    }
                }) %>
                <a href="#order" class="btn btn--order btn--hero hero__order" aria-label="Order <%= productName %>">Click Here To Order Now</a>
                <small class="disclaimer">*Max <abbr title="Pounds per square inch">PSI</abbr> at initial discharge per CSA internal pressure testing. Max <dfn><abbr title="Gallons per minute">GPM</abbr></dfn> with nozzle open at minimum pressure.</small>
                <strong class="hero__shipping">Free Shipping</strong>
                <%
                    var offer = new Offer();
                    var savingsBannerImage = offer.Savings.Src;
                    var savingsBannerAlt = offer.Savings.Alt;
                %>
                <picture class="hero__savings contain contain--hero-savings" data-src-img="<%= savingsBannerImage %>" data-attr='{ "alt" : "<%= savingsBannerAlt %>" }'>
                    <noscript>
                        <img src="<%= savingsBannerImage %>" alt="<%= savingsBannerAlt %>">
                    </noscript>
                </picture>

                <div class="hero__burst">
                    <picture class="hero__value contain contain--badge-value" data-src-img="/images/badge-value-420.jpg" data-attr='{ "alt" : "$420 value" }'>
                    </picture>
                    <picture class="hero__warranty contain contain--warranty" data-src-img="/images/badge-warranty.jpg" data-attr='{ "alt" : "3 year warranty" }'>
                    </picture>
                    <picture class="hero__mbg contain contain--mbg" data-src-img="/images/burst-mbg.svg" data-attr='{ "alt" : "30 day money back guarantee" }'>
                    </picture>
                </div>
            </div>
            <div class="hero__addons addons">
                <div class="addons__section">
                    <div class="banner banner--offer">You will receive</div>
                    <div class="slide slide--addons">
                        <div id="addons-slide" class="addons__group slide__into" data-slide-config='{ "displayAll" : "(min-width: 1000px)" }'>
                            <figure class="addons__item addons__item--detergent-foam-cannon slide__item">
                                <picture class="contain contain--addon-detergent-foam-cannon" data-src-img="/images/product-detergent-foam-cannon.jpg" data-attr='{ "aria-labelledby" : "addons-1" }'>
                                </picture>
                                <figcaption id="addons-1">
                                    <span>Detergent</span>
                                    <span>foam cannon</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__item--spray-tips slide__item">
                                <picture class="contain contain--addon-spray-tips" data-src-img="/images/product-spray-tips.jpg" data-attr='{ "aria-labelledby" : "addons-2" }'>
                                </picture>
                                <figcaption id="addons-2">
                                    <span>4 Quick-Connect</span>
                                    <span>Spray Tips</span>
                                    <a id="addons-nozzle" href="/images/nozzles.jpg" data-fancybox class="link-on-fancybox">(See usage guide)</a>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__item--hose slide__item">
                                <picture class="contain contain--addon-hose" data-src-img="/images/product-hose.jpg" data-attr='{ "aria-labelledby" : "addons-3" }'>
                                </picture>
                                <figcaption id="addons-3">
                                    <span>20&rsquo; Steel-Reinforced</span>
                                    <span>High-Pressure Hose</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__item--power-cord slide__item">
                                <picture class="contain contain--addon-power-cord" data-src-img="/images/product-power-cord.jpg" data-attr='{ "aria-labelledby" : "addons-4" }'>
                                </picture>
                                <figcaption id="addons-4">
                                    <span>35&rsquo; Power Cord</span>
                                    <span>with GFCI Protection</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__item--steel-lance slide__item">
                                <picture class="contain contain--addon-steel-lance" data-src-img="/images/product-steel-lance.jpg" data-attr='{ "aria-labelledby" : "addons-5" }'>
                                </picture>
                                <figcaption id="addons-5">
                                    <span>Stainless Steel Lance</span>
                                    <span>with Solid Brass Fittings</span>
                                </figcaption>
                            </figure>
                        </div>
                        <nav aria-label="Addons previous and next slides" class="addons__nav slide__nav">
                            <button
                                id="addons-slide-prev"
                                aria-label="Select the previous slide"
                                class="slide__prev"
                                type="button">
                                <svg class="icon icon-chevron-thin-left">
                                    <use href="#icon-chevron-thin-left"></use>
                                </svg>
                            </button>
                            <button
                                id="addons-slide-next"
                                aria-label="Select the next slide"
                                class="slide__next"
                                type="button">
                                <svg class="icon icon-chevron-thin-right">
                                    <use href="#icon-chevron-thin-right"></use>
                                </svg>
                            </button>
                        </nav>
                    </div>
                </div>

                <div class="addons__section bonus">
                    <div class="banner banner--offer"><span>Plus bonus items</span></div>
                    <div class="bonus__group">
                        <picture class="contain contain--bonus-badge" data-src-img="/images/badge-bristle-brush.jpg" data-attr='{ "alt" : "Utility bristle brush" }'>
                        </picture>
                        <picture class="contain contain--bonus-badge" data-src-img="/images/badge-wheel-rim-brush.jpg" data-attr='{ "alt" : "Wheel and rim brush" }'>
                        </picture>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%= Html.Partial("Content-Main", Model, new ViewDataDictionary {
    { "type", "standard" }
}) %>

</asp:Content>