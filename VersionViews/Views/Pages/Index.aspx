<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    var ext = DtmContext.ApplicationExtension;
    var version = DtmContext.Version;
    var isMobile = DtmContext.IsMobile;
    var isDesktop = !isMobile;

    var savingsBannerImage = "/images/banner-savings-144.svg";
    var savingsBannerAlt =  "Over $144 in savings!";

    if (version != 3)
    {
        savingsBannerImage = "/images/banner-savings.svg";
        savingsBannerAlt =  "Over $120 in savings!";
    }

%>

<main aria-label="Offer" class="view hero">
    <div id="main" class="view__anchor"></div>
    <div class="view__in hero__in">
        <div class="hero__group">
            <div id="hero-carousel" class="hero__picture">
                <picture style="--arp:288/555;--arp-max:277px">
                    <img src="/images/product-xtream.jpg" srcset="/images/product-xtream-sm.jpg 150w, /images/product-xtream.jpg 288w" alt="Product display" sizes="(max-width: 500px) 50px">
                </picture>
            </div>
            <% if (isDesktop) { %>
            <div class="hero__bg" data-src-img="/images/_bg-water-masthead.jpg">
                <noscript>
                    <img src="/images/_bg-water-masthead.jpg" alt="">
                </noscript>
            </div>
            <% } %>
            <div class="hero__offer">
                <%= Html.Partial("OfferGroup", new ViewDataDictionary {
                    { "modifier", "deal--hero reveal-offscreen" },
                    { "id", "hero" }
                }) %>
                <strong class="hero__shipping">Free Shipping</strong>

                <picture class="hero__savings" style="--arp:300/43;--arp-max:422px" data-src-img="<%= savingsBannerImage %>" data-attr='{ "alt" : "<%= savingsBannerAlt %>" }'>
                    <noscript>
                        <img src="<%= savingsBannerImage %>" alt="<%= savingsBannerAlt %>">
                    </noscript>
                </picture>

                <div class="hero__burst">
                    <picture class="hero__value" style="--arp:302/186;--arp-max:140px" data-src-img="/images/badge-value.jpg" data-attr='{ "alt" : "$360 value" }'>
                        <noscript>
                            <img src="/images/badge-value.jpg" alt="$360 value">
                        </noscript>
                    </picture>
                    <picture class="hero__warranty" style="--arp:342/186;--arp-max:163px" data-src-img="/images/badge-warranty.jpg" data-attr='{ "alt" : "3 year warranty" }'>
                        <noscript>
                            <img src="/images/badge-warranty.jpg" alt="3 year warranty">
                        </noscript>
                    </picture>
                    <picture class="hero__mbg" style="--arp:147/150;--arp-max:105px;" data-src-img="/images/burst-mbg.svg" data-attr='{ "alt" : "30 day money back guarantee" }'>
                        <noscript>
                            <img src="/images/burst-mbg.svg" alt="30 day money back guarantee">
                        </noscript>
                    </picture>
                </div>
            </div>
            <div class="hero__addons addons">
                <div class="addons__section">
                    <div class="banner">You will receive</div>
                    <div class="slide">
                        <div id="addons-slide" class="addons__group slide__into">
                            <figure class="addons__item addons__spot-chaser">
                                <picture style="--arp:132/176;--arp-max:68px" data-src-img="/images/product-detergent-foam-cannon.jpg" data-attr='{ "aria-labelledby" : "addons-1" }'>
                                    <noscript>
                                        <img src="/images/product-detergent-foam-cannon.jpg" aria-labelledby="addons-1">
                                    </noscript>
                                </picture>
                                <figcaption id="addons-1">
                                    <span>Detergent</span>
                                    <span>foam cannon</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__pet-tool">
                                <picture style="--arp:136/178;--arp-max:68px" data-src-img="/images/product-spray-tips.jpg" data-attr='{ "aria-labelledby" : "addons-2" }'>
                                    <noscript>
                                        <img src="/images/product-spray-tips.jpg" aria-labelledby="addons-2">
                                    </noscript>
                                </picture>
                                <figcaption id="addons-2">
                                    <span>4 Quick-Connect</span>
                                    <span>Spray Tips</span>
                                    <a id="addons-nozzle" href="/images/nozzles.jpg" class="link-on-fancybox">(See usage guide)</a>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__pet-solution">
                                <picture style="--arp:220/182;--arp-max:110px" data-src-img="/images/product-hose.jpg" data-attr='{ "aria-labelledby" : "addons-3" }'>
                                    <noscript>
                                        <img src="/images/product-hose.jpg" aria-labelledby="addons-3">
                                    </noscript>
                                </picture>
                                <figcaption id="addons-3">
                                    <span>20&rsquo; Steel-Reinforced</span>
                                    <span>High-Pressure Hose</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__power-cord">
                                <picture style="--arp:264/126;--arp-max:128px" data-src-img="/images/product-power-cord.jpg" data-attr='{ "aria-labelledby" : "addons-4" }'>
                                    <noscript>
                                        <img src="/images/product-power-cord.jpg" aria-labelledby="addons-4">
                                    </noscript>
                                </picture>
                                <figcaption id="addons-4">
                                    <span>35&rsquo; Power Cord</span>
                                    <span>with GFCI Protection</span>
                                </figcaption>
                            </figure>
                            <figure class="addons__item addons__steel-lance">
                                <picture style="--arp:340/152;--arp-max:154px" data-src-img="/images/product-steel-lance.jpg" data-attr='{ "aria-labelledby" : "addons-5" }'>
                                    <noscript>
                                        <img src="/images/product-steel-lance.jpg" aria-labelledby="addons-5">
                                    </noscript>
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
                                type="button"
                            >
                                <span class="icon-chevron-thin-left"></span>
                            </button>
                            <button
                                id="addons-slide-next"
                                aria-label="Select the next slide"
                                class="slide__next"
                                type="button"
                            >
                                <span class="icon-chevron-thin-right"></span>
                            </button>
                        </nav>
                    </div>
                </div>

                <div class="addons__section bonus">
                    <div class="banner banner--bonus"><span>Plus bonus items</span></div>
                    <div class="bonus__group">
                        <figure class="bonus__item">
                            <picture style="--arp:300/296;--arp-max:145px" data-src-img="/images/badge-bristle-brush.jpg" data-attr='{ "alt" : "Utility bristle brush" }'>
                                <noscript>
                                    <img src="/images/badge-bristle-brush.jpg" alt="Utility bristle brush">
                                </noscript>
                            </picture>
                        </figure>
                        <figure class="bonus__item">
                            <picture style="--arp:300/296;--arp-max:145px" data-src-img="/images/badge-wheel-rim-brush.jpg" data-attr='{ "alt" : "Wheel and rim brush" }'>
                                <noscript>
                                    <img src="/images/badge-wheel-rim-brush.jpg" alt="Wheel and rim brush">
                                </noscript>
                            </picture>
                        </figure>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<section aria-labelledby="media-title" class="view view--photo view--media media">
    <picture class="view view--photo" style="--arp:1300/524" data-src-img="/images/photo-bar-0.jpg" data-tag='{ "source" : [{ "media" : "(max-width: 600px)", "srcset" : "/images/mobile/photo-bar-0.jpg" }, { "media" : "(min-width: 601px)", "srcset" : "/images/photo-bar-0.jpg" }]}'>
        <noscript>
            <img src="/images/photo-bar-0.jpg" alt="">
        </noscript>
    </picture>
    <div id="media" class="view__anchor"></div>
    <div class="view__in media__in">
        <div class="media__group">
            <div class="media__player media__item">
                <%
                    var videoIds = SettingsManager.ContextSettings["FrameworkJS/CSS.Eflex.Play.Source", "415532882 | 415534574"];
                    var videoLabels = SettingsManager.ContextSettings["FrameworkJS/CSS.Eflex.Play.Labels", "Product Overview | How It Works"];

                    if (!String.IsNullOrEmpty(videoIds) && !String.IsNullOrEmpty(videoLabels))
                    {
                        string[] videoIdArray =
                        string.IsNullOrEmpty(videoIds)
                        ? new string[0]
                        : videoIds
                            .Split(new[] { "|" }, StringSplitOptions.RemoveEmptyEntries)
                            .Select(s => s.Trim())
                            .Where(s => !string.IsNullOrWhiteSpace(s))
                            .ToArray();

                        string[] videoLabelArray =
                        string.IsNullOrEmpty(videoLabels)
                        ? new string[0]
                        : videoLabels
                            .Split(new[] { "|" }, StringSplitOptions.RemoveEmptyEntries)
                            .Select(s => s.Trim())
                            .Where(s => !string.IsNullOrWhiteSpace(s))
                            .ToArray();

                        var firstVideo = videoIdArray.FirstOrDefault();

                        if (firstVideo != null)
                        {
                            %>
                            <div class="media__video" title="Watch the video" data-src-iframe="https://player.vimeo.com/video/<%= firstVideo %>?dnt=1" style="--arp:630/354;" data-attr='{ "width": "630", "height": "354", "allow": "fullscreen"}'></div>
                            <%
                        }

                        int labelLength = videoLabelArray.Count();

                        if (videoIdArray.Count() == labelLength)
                        {
                            %>
                            <nav aria-label="Video playlist">
                            <%
                            for (int i = 0; i < labelLength; i++)
                            {
                                var id = String.Format("video-{0}", videoLabelArray[i].Replace(" ", string.Empty));
                                %>
                                <button id="<%= id %>" class="button button--brand-primary" data-video-id="<%= videoIdArray[i] %>"><%= videoLabelArray[i] %></button>
                                <%
                            }
                            %>
                            </nav>
                            <%
                        }
                    }
                %>

            </div>
            <div class="media__title media__item">
                <h2 id="media-title">
                    <span>Gas-like power with the ease</span>
                    <span>and convenience of electric!</span>
                </h2>
                <figure class="media__psi">
                    <picture data-src-img="/images/burst-psi.png" data-attr='{ "alt": "2200 PSI Max" }' style="--arp:205/205;--arp-max:205px">
                        <noscript>
                            <img src="/images/burst-psi.png" alt="2200 PSI Max">
                        </noscript>
                    </picture>
                    <figcaption>
                        <span>*Max PSI at initial discharge per</span>
                        <span>CSA internal pressure testing.</span>
                    </figcaption>
                </figure>
            </div>
        </div>
    </div>
</section>

<% if (isMobile) { %>
<div class="copy">
    <div class="copy__footer">
        <a href="#order" id="display-order" class="button">
            <span>Click Here To Order Now</span>
        </a>
    </div>
</div>
<% } %>

<section aria-label="Features and benefits" class="view view--product view--observe">
    <div id="features" class="view__anchor"></div>
    <div class="view__in">
        <div class="copy copy--title">
            <h2>
                <span>#1 BEST-SELLING PRESSURE WASHER,</span>
                <span>MADE EVEN BETTER AND MORE POWERFUL!</span>
            </h2>

            <figure class="copy__group">
                <nav aria-label="Product features and benefits" class="product product--figure">
                    <div class="product__picture">
                        <div class="product__reveal circular-reveal">
                            <div class="product__reveal__image circular-reveal__content">
                                <%= Html.Partial("_Perks", new ViewDataDictionary { { "applyPictures", true } }) %>
                            </div>
                        </div>
                        <picture style="--arp:330/664;--arp-max:330px" data-src-img="/images/product-xtream-alt.jpg">
                            <noscript>
                                <img src="/images/product-xtream-alt.jpg" alt="">
                            </noscript>
                        </picture>
                        <%= Html.Partial("_Perks", new ViewDataDictionary { { "applyButtons", true } }) %>
                    </div>
                </nav>
                <div class="product product--list">
                    <picture data-src-img="/images/xtream-arrow.jpg" style="--arp:1084/196;--arp-max:542px;">
                        <noscript>
                            <img src="/images/xtream-arrow.jpg" alt="">
                        </noscript>
                    </picture>
                    <%= Html.Partial("_Perks") %>
                    <% if (isMobile) { %>
                       <%= Html.Partial("_Perks", new ViewDataDictionary { { "id", "mobile-features-list" }, { "applyId", false }, { "modifier", "product__list--static" } }) %>
                    <% } %>
                </div>
            </figure>
            <div class="copy__footer">
                <a href="#order" id="display-order" class="button">
                    <span>Click Here To Order Now</span>
                </a>
                <small>*Max PSI at initial discharge per CSA internal pressure testing. Max GPM with nozzle open at minimum pressure.</small>
            </div>
        </div>
    </div>
</section>

<div class="view view--photo">
    <picture style="--arp:1300/520" data-src-img="/images/photo-bar-1.jpg" data-tag='{ "source" : [{ "media" : "(max-width: 600px)", "srcset" : "/images/mobile/photo-bar-1.jpg" }, { "media" : "(min-width: 601px)", "srcset" : "/images/photo-bar-1.jpg" }]}'>
        <noscript>
            <img src="/images/photo-bar-1.jpg" alt="">
        </noscript>
    </picture>
</div>

<section aria-labelledby="offers-title" class="view view--addons">
    <div id="offers" class="view__anchor"></div>
    <div class="view__in">
        <div class="copy">
            <h2 id="offers-title">NOW YOU CAN WIN THE WAR ON GRIME!</h2>

            <div class="copy__group copy__group--carousel copy__group--image">
                <figure class="copy__figure">
                    <%= Html.Partial("_Carousel", new ViewDataDictionary {
                        { "id", "grime" }
                    }) %>
                    <figcaption>
                        <div class="copy__caption">
                            <h3>GRIME + STAINS</h3>
                            <p>Mold + Mildew, Rust,<br>Oil + Grease, Tar + Mud</p>
                        </div>
                    </figcaption>
                    <%= Html.Partial("_Carousel", new ViewDataDictionary {
                        { "id", "grime" }, { "display", "thumbnails" }
                    }) %>
                </figure>
                <figure class="copy__figure">
                    <%= Html.Partial("_Carousel", new ViewDataDictionary {
                        { "id", "surfaces" }
                    }) %>
                    <figcaption>
                        <div class="copy__caption">
                            <h3>MULTIPLE SURFACES</h3>
                            <p>Concrete, Brick, Tile,<br>Wood + Metal</p>
                        </div>
                    </figcaption>
                    <%= Html.Partial("_Carousel", new ViewDataDictionary {
                        { "id", "surfaces" }, { "display", "thumbnails" }
                    }) %>
                </figure>
                <figure class="copy__figure">
                    <%= Html.Partial("_Carousel", new ViewDataDictionary {
                        { "id", "applications" }
                    }) %>
                    <figcaption>
                        <div class="copy__caption">
                            <h3>VARIOUS APPLICATIONS</h3>
                            <p>Furniture, Lawn Gear, Exteriors,<br>Auto + Boat, Porch + Decks</p>
                        </div>
                    </figcaption>
                    <%= Html.Partial("_Carousel", new ViewDataDictionary {
                        { "id", "applications" }, { "display", "thumbnails" }
                    }) %>
                </figure>
            </div>
            <div class="copy__footer">
                <a href="#order" id="display-order" class="button">
                    <span>Click Here To Order Now</span>
                </a>
            </div>
        </div>
    </div>
</section>

<div class="view view--photo">
    <picture style="--arp:1300/520" data-src-img="/images/photo-bar-2.jpg" data-tag='{ "source" : [{ "media" : "(max-width: 600px)", "srcset" : "/images/mobile/photo-bar-2.jpg" }, { "media" : "(min-width: 601px)", "srcset" : "/images/photo-bar-2.jpg" }]}'>
        <noscript>
            <img src="/images/photo-bar-2.jpg" alt="">
        </noscript>
    </picture>
</div>

<section aria-labelledby="offers-title" class="view view--addons">
    <div id="offers" class="view__anchor"></div>
    <div class="view__in">
        <div class="copy">
            <h2 id="offers-title">CLEAN XTREAM WITH TRIPLE-ACTION POWER</h2>

            <div class="copy__group copy__group--display copy__group--image">
                <figure class="copy__figure">
                    <picture class="copy__image" style="--arp:433/323;" data-src-img="/images/xtream-foaming.jpg">
                        <noscript>
                            <img src="/images/xtream-foaming.jpg" alt="">
                        </noscript>
                    </picture>
                    <figcaption>
                        <div class="copy__caption">
                            <h3>XTREAM Foaming</h3>
                            <p>Aerates detergent and sprays it up to<br>15&rsquo; for maximum coverage </p>
                        </div>
                    </figcaption>
                </figure>
                <figure class="copy__figure">
                    <picture class="copy__image" style="--arp:433/323;" data-src-img="/images/xtream-cleaning.jpg">
                        <noscript>
                            <img src="/images/xtream-cleaning.jpg" alt="">
                        </noscript>
                    </picture>
                    <figcaption>
                        <div class="copy__caption">
                            <h3>XTREAM Cleaning</h3>
                            <p>4 Quick-Connect nozzles with a wide<br>range of spray patterns</p>
                        </div>
                    </figcaption>
                </figure>
                <figure class="copy__figure">
                    <picture class="copy__image" style="--arp:433/323;" data-src-img="/images/xtream-rinsing.jpg">
                        <noscript>
                            <img src="/images/xtream-rinsing.jpg" alt="">
                        </noscript>
                    </picture>
                    <figcaption>
                        <div class="copy__caption">
                            <h3>XTREAM Rinsing</h3>
                            <p>Delivers up to 2200 PSI* + 1.65 GPM*<br>to rinse the grime away!</p>
                        </div>
                    </figcaption>
                </figure>
            </div>

            <div class="copy__footer">
                <a href="#order" id="display-order" class="button">
                    <span>Click Here To Order Now</span>
                </a>
                <small>*Max PSI at initial discharge per CSA internal pressure testing. Max GPM with nozzle open at minimum pressure.</small>
            </div>
        </div>
    </div>
</section>

<section aria-label="Reviews" class="view view--reviews view--observe">
    <div id="reviews" class="view__anchor"></div>
    <div class="view__in">
        <div class="copy">
            <div class="slide review">
                <div class="slide__js">
                    <noscript>
                        <style>
                            .slide__js {
                                display: none;
                            }
                        </style>
                    </noscript>
                </div>
                <div id="reviews-slide" class="slide__into">
                    <div class="slide__item">
                        <blockquote class="review__item">
                            <picture class="review__stars" style="--arp:300/49;--arp-max:300px" data-src-img="/images/stars.svg">
                                <noscript>
                                    <img src="/images/stars.svg" alt="">
                                </noscript>
                            </picture>
                            <h3>More Bang For Your Buck</h3>
                            <p>&ldquo;The Sun Joe has really made it easy to kinda do a little bit and get a lot out of it. It's kinda like more bang for your buck.&rdquo;</p>
                            <footer><strong>- Shawn S.</strong></footer>
                        </blockquote>
                    </div>
                    <div class="slide__item">
                        <blockquote class="review__item">
                            <picture class="review__stars" style="--arp:300/49;--arp-max:300px" data-src-img="/images/stars.svg">
                                <noscript>
                                    <img src="/images/stars.svg" alt="">
                                </noscript>
                            </picture>
                            <h3>love it!</h3>
                            <p>&ldquo;Yes, fantastic item. Took all of three minutes maybe, and I would&rsquo;ve been 15, 20 minutes of sanding. This machine is so easy to use.&rdquo;</p>
                            <footer><strong>- Suzanne B.</strong></footer>
                        </blockquote>
                    </div>
                    <div class="slide__item">
                        <blockquote class="review__item">
                            <picture class="review__stars" style="--arp:300/49;--arp-max:300px" data-src-img="/images/stars.svg">
                                <noscript>
                                    <img src="/images/stars.svg" alt="">
                                </noscript>
                            </picture>
                            <h3>Absolutely Incredible!</h3>
                            <p>&ldquo;I completely thought that I was going to have to repaint this entire place, but it looks brand new.&rdquo;</p>
                            <footer><strong>- Michelle P.</strong></footer>
                        </blockquote>
                    </div>
                    <div class="slide__item">
                        <blockquote class="review__item">
                            <picture class="review__stars" style="--arp:300/49;--arp-max:300px" data-src-img="/images/stars.svg">
                                <noscript>
                                    <img src="/images/stars.svg" alt="">
                                </noscript>
                            </picture>
                            <h3>Wow!</h3>
                            <p>&ldquo;It's amazing without spending hours sweeping, scrubbing, and brushing.&rdquo;</p>
                            <footer><strong>- Bruce B.</strong></footer>
                        </blockquote>
                    </div>
                    <div class="slide__item">
                        <blockquote class="review__item">
                            <picture class="review__stars" style="--arp:300/49;--arp-max:300px" data-src-img="/images/stars.svg">
                                <noscript>
                                    <img src="/images/stars.svg" alt="">
                                </noscript>
                            </picture>
                            <h3>Handy Tool</h3>
                            <p>&ldquo;As I use the pressure washer, [dirt] comes off so quick and easy. I love having handy tools like this.&rdquo;</p>
                            <footer><strong>- Stephanie W.</strong></footer>
                        </blockquote>
                    </div>
                </div>
                <nav aria-label="Reviews previous and next slides" class="slide__nav">
                    <button
                        id="slide-prev"
                        aria-label="Select the previous slide"
                        class="slide__prev"
                        type="button"
                    >
                        <span class="icon-chevron-thin-left"></span>
                    </button>
                    <button
                        id="slide-next"
                        aria-label="Select the next slide"
                        class="slide__next"
                        type="button"
                    >
                        <span class="icon-chevron-thin-right"></span>
                    </button>
                </nav>
            </div>
            <div class="copy__footer">
                <a href="Reviews<%= ext %>" id="index-reviews"  class="button">
                    <span>More Reviews</span>
                </a>
            </div>
        </div>
    </div>
</section>

<section aria-labelledby="offers-title" class="view view--addons">
    <div id="offers" class="view__anchor"></div>
    <div class="view__in">
        <div class="copy">
            <h2 id="offers-title"><%= Brand.NAMEHTML %> CONSTRUCTION IS SUPERIOR</h2>

            <div class="copy__group copy__group--image">
                <figure class="copy__figure">
                    <picture class="copy__image" style="--arp:348/271;--arp-max:348px" data-src-img="/images/close-up-hose.jpg">
                        <noscript>
                            <img src="/images/close-up-hose.jpg" alt="">
                        </noscript>
                    </picture>
                    <figcaption>
                        <div class="copy__caption">
                            <h3>STEEL-REINFORCED<br>HIGH-PRESSURE HOSE</h3>
                            <p>High-tensile, wire-reinforced tubing over a smooth inner core minimizes pressure drop and maximizes performance</p>
                        </div>
                    </figcaption>
                </figure>
                <figure class="copy__figure">
                    <picture class="copy__image" style="--arp:348/271;--arp-max:348px" data-src-img="/images/close-up-lance.jpg">
                        <noscript>
                            <img src="/images/close-up-lance.jpg" alt="">
                        </noscript>
                    </picture>
                    <figcaption>
                        <div class="copy__caption">
                            <h3>STAINLESS STEEL +<br>BRASS LANCE</h3>
                            <p>Rust- and corrosion-resistant, the highest quality in the industry, for long-lasting durability </p>
                        </div>
                    </figcaption>
                </figure>
                <figure class="copy__figure">
                    <picture class="copy__image" style="--arp:348/271;--arp-max:348px" data-src-img="/images/close-up-motor.jpg">
                        <noscript>
                            <img src="/images/close-up-motor.jpg" alt="">
                        </noscript>
                    </picture>
                    <figcaption>
                        <div class="copy__caption">
                            <h3>TOTAL STOP SYSTEM<br>TECHNOLOGY</h3>
                            <p>Automatically shuts off pump when trigger is not engaged to save energy, prolong pump and motor life</p>
                        </div>
                    </figcaption>
                </figure>
            </div>
        </div>
    </div>
</section>

</asp:Content>