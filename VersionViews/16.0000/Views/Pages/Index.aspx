<%@ Page Language="C#" MasterPageFile="~/VersionViews/14.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
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
                <source srcset="/images/16.0000/product-xtream.webp" type="image/webp" />
                <img src="/images/16.0000/product-xtream.jpg" alt="Product display of the Sun Joe SPX-3000 XTREAM">
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

                <div class="hero__burst">
                    <picture class="hero__warranty contain contain--warranty" data-src-img="/images/badge-warranty--2.jpg" data-attr='{ "alt" : "2 year warranty" }'>
                    </picture>
                    <picture class="hero__mbg contain contain--mbg" data-src-img="/images/burst-mbg--alt.svg" data-attr='{ "alt" : "30 day money back guarantee" }'>
                    </picture>
                </div>
            </div>
            <div class="hero__addons addons">
                <div class="addons__section">
                    <div class="banner banner--offer">You will receive</div>
                    <div class="slide slide--addons">
                        <div id="addons-slide" class="addons__group slide__into" data-slide-config='{ "displayAll" : "(min-width: 1000px)" }'>
                            <figure class="addons__item addons__item--hose slide__item">
                                <picture class="contain contain--addon-hose" data-src-img="/images/16.0000/hose.jpg" data-attr='{ "aria-labelledby" : "addons-1" }'>
                                </picture>
                                <figcaption id="addons-1">
                                    <span>20-foot</span>
                                    <span>High Pressure Hose</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__item--spray-wand slide__item">
                                <picture class="contain contain--addon-spray-wand" data-src-img="/images/16.0000/wand.jpg" data-attr='{ "aria-labelledby" : "addons-2" }'>
                                </picture>
                                <figcaption id="addons-2">
                                    <span>Stainless Steel</span>
                                    <span>Spray Wand</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__item--trigger-gun slide__item">
                                <picture class="contain contain--addon-trigger-gun" data-src-img="/images/16.0000/trigger-gun.jpg" data-attr='{ "aria-labelledby" : "addons-3" }'>
                                </picture>
                                <figcaption id="addons-3">
                                    <span>Trigger Gun +</span>
                                    <span>Spray Wand Holder</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__item--tanks slide__item">
                                <picture class="contain contain--addon-tanks" data-src-img="/images/16.0000/tanks.jpg" data-attr='{ "aria-labelledby" : "addons-4" }'>
                                </picture>
                                <figcaption id="addons-4">
                                    <span>Dual</span>
                                    <span>Detergent Tanks</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__item--spray-tips slide__item">
                                <picture class="contain contain--addon-spray-tips-new" data-src-img="/images/16.0000/tips.jpg" data-attr='{ "aria-labelledby" : "addons-5" }'>
                                </picture>
                                <figcaption id="addons-5">
                                    <span>4 Quick-Connect</span>
                                    <span>Spray Tips</span>
                                    <a id="addons-nozzle" href="/images/nozzles--alt.jpg" data-fancybox class="link-on-fancybox">(See usage guide)</a>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__item--power-cord slide__item">
                                <picture class="contain contain--addon-power-cord-new" data-src-img="/images/16.0000/power-cord.jpg" data-attr='{ "aria-labelledby" : "addons-6" }'>
                                </picture>
                                <figcaption id="addons-6">
                                    <span>35&rsquo; Power Cord</span>
                                    <span>with GFCI Protection</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__item--hose-adapter slide__item">
                                <picture class="contain contain--addon-hose-adapter" data-src-img="/images/16.0000/hose-adapter.jpg" data-attr='{ "aria-labelledby" : "addons-7" }'>
                                </picture>
                                <figcaption id="addons-7">
                                    <span>Garden Hose</span>
                                    <span>Adapter</span>
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
            </div>
        </div>
    </div>
</main>

<section aria-labelledby="publications-title" class="view section publications">
    <div id="publications" class="view__anchor"></div>
    <div class="view__in section__in">
        <h2 class="publications__title" id="publications-title">As Featured In:</h2>
        <div class="publications__group">
            <img src="/images/publications/usa-today.jpg" loading="lazy" alt="USA Today" width="109" height="52">
            <img src="/images/publications/new-york-times.png" loading="lazy" alt="New York Times" width="244" height="39">
            <img src="/images/publications/real-simple.jpg" loading="lazy" alt="Real Simple" width="158" height="25">
            <img src="/images/publications/popular-mechanics.png" loading="lazy" alt="Popular Mechanics" width="165" height="52">
            <img src="/images/publications/people.png" loading="lazy" alt="People" width="104" height="52">
            <img src="/images/publications/good-housekeeping.jpg" loading="lazy" alt="Good Housekeeping" width="158" height="51">
        </div>
    </div>
</section>

<%= Html.Partial("Content-Main", Model, new ViewDataDictionary {
    { "type", "standard" }
}) %>

</asp:Content>