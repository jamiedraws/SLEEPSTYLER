<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    using (Html.BeginForm())
    {
        var products = DtmContext.CampaignProducts.Where(cp => cp.ProductTypeId == 2).ToList();

        if (products != null && products.Any())
        {
            var snackbarLayout = new ViewDataDictionary { { "layoutMode", "snackbar" } };



%>

<link rel="stylesheet" href="/shared/css/slide/1/slide.css">
<link rel="stylesheet" href="/shared/css/slide/1/slide.thumbnails.css">
<link rel="stylesheet" href="/shared/css/upsell/upsell-carousel.css">

<noscript>
    <style>
        /* when javascript is not supported */
        .slide__into {
            display: flex;
        }

        .slide__into {
            overflow-x: auto;
            overflow-y: hidden;
            scroll-behavior: smooth;
            -webkit-overflow-scrolling: touch;
            scroll-snap-points-x: repeat(100%);
            scroll-snap-type: mandatory;
            -ms-overflow-style: -ms-autohiding-scrollbar;
        }

        .slide__js {
            display: none;
        }
    </style>
</noscript>

<%
    var upsellTitle = Model.UpsellTitle ?? string.Empty;
    var vimeoSrc = "https://player.vimeo.com/video/{0}";
%>

<% if (!String.IsNullOrEmpty(upsellTitle))
    { %>
<div class="upsell__banner">
    <h2 class="upsell__banner__title"><%= upsellTitle %></h2>
</div>
<% } %>

<section class="upsell-card">
    <div class="upsell-card__group">
        <%
            var productUP5 = products.FirstOrDefault(p => string.Equals(p.ProductCode, "UP11", StringComparison.InvariantCultureIgnoreCase));
            var vimeoUP5Id = "454797317";
            var vimeoUP5Src = String.Format(vimeoSrc, vimeoUP5Id);
        %>
        <div class="upsell-card__img c-brand__img">
            <div class="c-brand__upsell-carousel">
                <div class="slide slide--alpha">
                    <div class="slide__in">
                        <div id="beta2" class="slide__into" aria-live="polite">
                            <picture id="beta2-1" class="slide__item load-item" style="--arp: 1/1;" aria-hidden="true"><img src="/images/upsells/AJWV100/AJWV100_1.jpg" alt="" class="slide__item"></picture>
                            <picture id="beta2-2" class="slide__item load-item" style="--arp: 1/1;" aria-hidden="true"><img src="/images/upsells/AJWV100/AJWV100_2.jpg" alt="" class="slide__item"></picture>
                            <picture id="beta2-3" class="slide__item load-item" style="--arp: 1/1;" aria-hidden="true"><img src="/images/upsells/AJWV100/AJWV100_3.jpg" alt="" class="slide__item"></picture>
                            <picture id="beta2-4" class="slide__item load-item" style="--arp: 1/1;" aria-hidden="true"><img src="/images/upsells/AJWV100/AJWV100_4.jpg" alt="" class="slide__item"></picture>
                        </div>
                    </div>
                    <nav aria-label="Product gallery" class="slide__thumbnails">
                        <a href="#beta2-1" id="thumbnail_AJWV100_1" data-slide-index="0" class="slide__thumbnail" style="--arp: 1/1;">
                            <img src="/images/upsells/AJWV100/AJWV100_1.jpg" alt=""></a>
                        <a href="#beta2-2" id="thumbnail_AJWV100_2" data-slide-index="1" class="slide__thumbnail" style="--arp: 1/1;">
                            <img src="/images/upsells/AJWV100/AJWV100_2.jpg" alt=""></a>
                        <a href="#beta2-3" id="thumbnail_AJWV100_3" data-slide-index="2" class="slide__thumbnail" style="--arp: 1/1;">
                            <img src="/images/upsells/AJWV100/AJWV100_3.jpg" alt=""></a>
                        <a href="#beta2-4" id="thumbnail_AJWV100_4" data-slide-index="3" class="slide__thumbnail" style="--arp: 1/1;">
                            <img src="/images/upsells/AJWV100/AJWV100_4.jpg" alt=""></a>
                    </nav>
                </div>
            </div>
        </div>

        <div class="upsell-card__copy c-brand--upsell">
            <h2 class="c-brand__headline">WHISK AWAY DIRT + GRIME</h2>

            <div class="c-brand__txt">
                <p>Get a squeaky-clean, streak-free finish with the Sun Joe&reg; Cordless Multi-Surface Window Vacuum Cleaner. The soft, flexible squeegee blade is safe on glass and delicate surfaces. Simply spray and vacuum away soap scum, dirt, smudges, and haze. No wiping required &ndash; and no more piles of grimy paper towels! For a clearly better way to clean your windows and shine your surfaces &ndash; Go With Joe&reg;!</p>

                Features:
                <ul>
                    <li>Cordless convenience </li>
                    <li>Great for indoor + outdoor jobs</li>
                    <li>Easily clean windows, counters, mirrors, shower doors, auto glass + more</li>
                    <li>Cleans up to 50 standard-sized windows per charge</li>
                    <li>15-watt motor instantly dries your surfaces in seconds</li>
                    <li>Easy-empty 3.4 fl oz collection tank collects dirty water</li>
                    <li>Includes Universal USB charger + AC adapter</li>
                    <li>2-year warranty protection</li>
                </ul>
            </div>

            <%
                Html.RenderPartial("UpsellActionCard", productUP5);
                Html.RenderPartial("UpsellActionCard", productUP5, snackbarLayout);
            %>
        </div>
    </div>
</section>

<section class="upsell-card">
    <div class="upsell-card__group">
        <%
            var productUP6 = products.FirstOrDefault(p => string.Equals(p.ProductCode, "UP6", StringComparison.InvariantCultureIgnoreCase));
            var vimeoUP6Id = "438624832";
            var vimeoUP6Src = String.Format(vimeoSrc, vimeoUP6Id);
        %>
        <div class="upsell-card__img c-brand__img">
            <div class="c-brand__upsell-carousel">
                <div class="slide slide--alpha">
                    <div class="slide__in">
                        <div id="beta" class="slide__into" aria-live="polite">
                            <a data-type="iframe" id="beta-0" class="slide__item slide__has-play slide__video has-fancybox fancybox.iframe" data-thumbnail-vimeo-id="<%= vimeoUP6Id %>" data-fancybox-method="vimeo" href="<%= vimeoUP6Src %>" style="--arp: 1/1" aria-hidden="false">
                                <div class="play"></div>
                            </a>
                            <picture id="beta-1" class="slide__item load-item" style="--arp: 1/1;" aria-hidden="true"><img src="/images/upsells/SPX_PCA10/SPX_PCA10_1.jpg" alt="" class="slide__item"></picture>
                            <picture id="beta-2" class="slide__item load-item" style="--arp: 1/1;" aria-hidden="true"><img src="/images/upsells/SPX_PCA10/SPX_PCA10_2.jpg" alt="" class="slide__item"></picture>
                            <picture id="beta-3" class="slide__item load-item" style="--arp: 1/1;" aria-hidden="true"><img src="/images/upsells/SPX_PCA10/SPX_PCA10_3.jpg" alt="" class="slide__item"></picture>
                        </div>
                    </div>
                    <nav aria-label="Product gallery" class="slide__thumbnails">
                        <a data-type="iframe" id="thumbnail_SPX_PCA10_0" data-thumbnail-vimeo-id="<%= vimeoUP6Id %>" data-slide-index="0" data-fancybox-method="vimeo" href="<%= vimeoUP6Src %>" class="slide__thumbnail has-fancybox fancybox.iframe slide__video slide__has-play slide__thumbnail--is-selected" style="--arp: 1/1;">
                            <div class="play"></div>
                        </a>
                        <a href="#beta-1" id="thumbnail_SPX_PCA10_1" data-slide-index="1" class="slide__thumbnail" style="--arp: 1/1;">
                            <img src="/images/upsells/SPX_PCA10/SPX_PCA10_1.jpg" alt=""></a>
                        <a href="#beta-2" id="thumbnail_SPX_PCA10_2" data-slide-index="2" class="slide__thumbnail" style="--arp: 1/1;">
                            <img src="/images/upsells/SPX_PCA10/SPX_PCA10_2.jpg" alt=""></a>
                        <a href="#beta-3" id="thumbnail_SPX_PCA10_3" data-slide-index="3" class="slide__thumbnail" style="--arp: 1/1;">
                            <img src="/images/upsells/SPX_PCA10/SPX_PCA10_3.jpg" alt=""></a>
                    </nav>
                </div>
            </div>
        </div>

        <div class="upsell-card__copy c-brand--upsell">
            <h2 class="c-brand__headline">Get The Big Jobs Done Faster</h2>

            <div class="c-brand__txt">
                <p>You can also use your new Sun Joe XTREAM to keep decks and patios clean with these two best-selling accessories with our Home Maintenance Kit.</p>

                <ul>
                    <li>Skip the scrub brush! The Surface, Deck + Patio Cleaning Attachment deep cleans with ease and saves time too. Ideal for an endless array of surface cleaning projects from porch to patio, driveways and decks, pavers, bricks, and more!</li>
                    <li>You'll also receive the Sun Joe Power Scrubbing Broom that quickly sweeps away dirt, debris and grime with the power of water pressure! Twice as effective as dry sweeping for a deep down clean.</li>
                </ul>
            </div>
            <%
                Html.RenderPartial("UpsellActionCard", productUP6);
                Html.RenderPartial("UpsellActionCard", productUP6, snackbarLayout);
            %>
        </div>
    </div>
</section>


<div style="display: none">
    <%=Html.Partial("SummaryReview") %>

    <button id="acceptOffer" name="acceptOffer" type="submit" class="upsell__link">Add To Cart</button>
    <button id="rejectOffer" name="rejectOffer" type="submit" class="upsell__link">No, Thanks</button>
    <input type="hidden" name="SKIP" id="SKIP" value="false" />
</div>

<nav class="upsell__nav upsell__nav--center">
    <a href="javascript:document.getElementById('acceptOffer').click();" class="upsell__link upsell__link--contrast" id="upsell-checkout-inline">Checkout</a>
    <span class="upsell__fab-position">
        <a href="javascript:document.getElementById('acceptOffer').click();" id="upsell-checkout-fab" aria-label="Proceed to checkout" title="Proceed to checkout" class="upsell__fab">
            <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24">
                <path d="M11 9h2V6h3V4h-3V1h-2v3H8v2h3v3zm-4 9c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zm10 0c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2zm-9.83-3.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.86-7.01L19.42 4h-.01l-1.1 2-2.76 5H8.53l-.13-.27L6.16 6l-.95-2-.94-2H1v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.13 0-.25-.11-.25-.25z" />
            </svg>
        </a>
    </span>
</nav>
<input type="hidden" name="Up11hiddenQty" id="Up11hiddenQty" />
<input type="hidden" name="Up11Active" id="Up11Active" />
<input type="hidden" name="Up6hiddenQty" id="Up6hiddenQty" />
<input type="hidden" name="Up6Active" id="Up6Active" />
<script>

    function updateHiddenFields() {
        $('#Up6hiddenQty').val($('#UP6Qty').val());
        $('#Up11hiddenQty').val($('#UP11Qty').val());
        if ($('#UP11Btn').hasClass('added')) {
            $('#Up11Active').val('true');
        } else {
            $('#Up11Active').val('false');
        }
        if ($('#UP6Btn').hasClass('added')) {
            $('#Up6Active').val('true');
        } else {
            $('#Up6Active').val('false');
        }
    }

    $(function () {

        $('#skipToCheckout-UP11A').on('click', function () {
            updateHiddenFields();
        });

    });

    document.addEventListener("DOMContentLoaded", function () {
        var upsellEngine = new UpsellEngine();
        upsellEngine.UpdateState();
        addEventListener("SummaryCartUpdated", upsellEngine.UpdateState);


    });



</script>

<script defer src="/shared/js/slide/1/slide.js"></script>
<script defer src="/shared/js/slide/1/components/slide.a11y.js"></script>
<script defer src="/shared/js/slide/1/components/slide.thumbnails.js"></script>
<script defer src="https://player.vimeo.com/api/player.js"></script>
<script defer src="/shared/js/upsell/upsell-carousel.js"></script>

<%
        }
    }

%>
