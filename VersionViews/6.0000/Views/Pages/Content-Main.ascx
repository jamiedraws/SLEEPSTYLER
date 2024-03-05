<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<%
    var brandName = SettingsManager.ContextSettings["Label.BrandName"];
    var productName = SettingsManager.ContextSettings["Label.ProductName"];
%>

<section aria-labelledby="media-title" class="view section media">
    <div id="media" class="view__anchor"></div>
    <div class="media__body">
        <div class="media__underlay bg bg--contrast">
            <picture class="contain contain--photobar" data-src-photobar="/images/photo-bar-0.jpg" data-tag='{ "source" : [{ "media" : "(max-width: 600px)", "srcset" : "/images/mobile/photo-bar-0.jpg" }, { "media" : "(min-width: 601px)", "srcset" : "/images/photo-bar-0.jpg" }], "img" : [{ "src" : "/images/photo-bar-0.jpg", "aria-hidden" : "true" }] }'>
            </picture>
        </div>
        <div class="view__in media__in section__in media__overlay media__group">
            <%= Html.Partial("Video") %>
            <div class="media__content media__item">
                <h2 id="media-title" class="media__title">
                    <span>Gas-like power with the ease</span>
                    <span>and convenience of electric!</span>
                </h2>
                <figure class="media__psi">
                    <picture class="contain contain--square" data-src-img="/images/burst-psi.png" data-attr='{ "alt": "2200 Pounds per square inch Max" }'>
                    </picture>
                    <figcaption>
                        <span>*Max <dfn><abbr title="Pounds per square inch">PSI</abbr></dfn> at initial discharge per</span>
                        <span>CSA internal pressure testing.</span>
                    </figcaption>
                </figure>
            </div>
        </div>
    </div>
</section>

<section aria-labelledby="features-title" class="view features section">
    <div id="features" class="view__anchor"></div>
    <div class="view__in features__in section__in">
        <div class="title section__block">
            <h2 id="features-title" class="title__text">
                <span>#1 BEST-SELLING PRESSURE WASHER,</span>
                <span>MADE EVEN BETTER AND MORE POWERFUL!</span>
            </h2>
        </div>
        <div class="section__block">
            <div class="features__group">
                <nav aria-label="Features and benefits" class="features__nav">
                    <div role="presentation" aria-hidden="true" class="features__reveal circular-reveal">
                        <div class="features__reveal__image circular-reveal__content">
                            <%= Html.Partial("Features", new ViewDataDictionary { { "applyPictures", true } }) %>
                        </div>
                    </div>
                    <picture data-src-img="/images/product-xtream-alt.jpg" data-attr='{ "alt" : "Diagram of the <%= productName %>" }' class="contain contain--diagram features__picture">
                        <noscript>
                            <img src="/images/product-xtream-alt.jpg" alt="Diagram of the <%= productName %>">
                        </noscript>
                        <%= Html.Partial("Features", new ViewDataDictionary { { "applyButtons", true } }) %>
                    </picture>
                </nav>
                <div class="features__list">
                    <picture class="contain contain--xtream-arrow" data-src-img="/images/xtream-arrow.jpg" data-attr='{ "alt" : "XTREAM" }'>
                    </picture>
                    <%= Html.Partial("Features", new ViewDataDictionary {
                        { "classes", "features__interactive-list" },
                        { "applyList", true },
                        { "id", "features-list-interactive" }
                    }) %>
                    <%= Html.Partial("Features", new ViewDataDictionary {
                        { "classes", "features__static-list" },
                        { "applyList", true },
                        { "applyId", false },
                        { "id", "features-list-static" }
                    }) %>
                </div>
            </div>
        </div>
        <div class="section__block text-center">
            <a href="#order" id="features-order" class="btn btn--order btn--is-bigger">Click here to order now</a>
            <small class="disclaimer">*Max <abbr title="Pounds per square inch">PSI</abbr> at initial discharge per CSA internal pressure testing. Max <dfn><abbr title="Gallons per minute">GPM</abbr></dfn> with nozzle open at minimum pressure.</small>
        </div>
    </div>
</section>

<div class="bg bg--contrast">
    <picture class="contain contain--photobar" data-src-img="/images/photo-bar-1.jpg" data-tag='{ "source" : [{ "media" : "(max-width: 600px)", "srcset" : "/images/mobile/photo-bar-1.jpg" }, { "media" : "(min-width: 601px)", "srcset" : "/images/photo-bar-1.jpg" }], "img" : [{ "src" : "/images/photo-bar-1.jpg", "aria-hidden" : "true", "role" : "presentation" }] }'>
    </picture>
</div>

<section aria-labelledby="grime-title" class="view section">
    <div id="grime" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="title section__block">
            <h2 id="grime-title" class="title__text">Now you can win the war on grime!</h2>
        </div>
        <%
            var grimeList = new SortedList<int, Tuple<string, string>>()
            {
                {
                    0, new Tuple<string, string>("grime", @"<h3>GRIME + STAINS</h3>
                        <p>Mold + Mildew, Rust,<br>Oil + Grease, Tar + Mud</p>")
                },
                {
                    1, new Tuple<string, string>("surfaces", @"<h3>MULTIPLE SURFACES</h3>
                        <p>Concrete, Brick, Tile,<br>Wood + Metal</p>")
                },
                {
                    2, new Tuple<string, string>("applications", @"<h3>VARIOUS APPLICATIONS</h3>
                        <p>Furniture, Lawn Gear, Exteriors,<br>Auto + Boat, Porch + Decks</p>")
                }
            };
        %>
        <div class="section__block mask">
            <div class="figure bg bg--light">
                <%
                    var figureItemTemplate = @"
                    <figure class=""figure__item slide slide--in-use"">
                        {0}
                        <figcaption class=""copy"">
                            {1}
                        </figcaption>
                        {2}
                    </figure>
                    ";

                    foreach (var grimeItem in grimeList)
                    {
                        var id = grimeItem.Value.Item1;
                        var caption = grimeItem.Value.Item2;

                        var slideImages = new List<string>();
                        var thumbnailImages = new List<string>();

                        for (var i = 0; i < 5; i++)
                        {
                            slideImages.Add(string.Format("{0}-slide-{1}.jpg", id, i));
                            thumbnailImages.Add(string.Format("{0}-thumb-{1}.jpg", id, i));
                        }

                        var carouselSlideDictionary = new ViewDataDictionary{
                            { "id", id },
                            { "imageDirectory", "images/inuse-gallery" },
                            { "images", slideImages }
                        };

                        var carouselThumbnailDictionary = new ViewDataDictionary
                        {
                            { "id", id },
                            { "imageDirectory", "images/inuse-gallery" },
                            { "images", thumbnailImages },
                            { "display", "thumbnails" },
                            { "useThumbnailImages", true }
                        };

                        var figureItem = string.Format(
                            figureItemTemplate,
                            Html.Partial("PictureCarousel", carouselSlideDictionary),
                            caption,
                            Html.Partial("PictureCarousel", carouselThumbnailDictionary));

                        %>
                        <%= figureItem %>
                        <%
                    }
                %>
            </div>
        </div>
        <div class="section__block text-center">
            <a href="#order" id="grime-order" class="btn btn--order btn--is-bigger">Click here to order now</a>
            <small class="disclaimer">*Max <abbr title="Pounds per square inch">PSI</abbr> at initial discharge per CSA internal pressure testing. Max <dfn><abbr title="Gallons per minute">GPM</abbr></dfn> with nozzle open at minimum pressure.</small>
        </div>
    </div>
</section>

<div class="bg bg--contrast">
    <picture class="contain contain--photobar" data-src-img="/images/photo-bar-2.jpg" data-tag='{ "source" : [{ "media" : "(max-width: 600px)", "srcset" : "/images/mobile/photo-bar-2.jpg" }, { "media" : "(min-width: 601px)", "srcset" : "/images/photo-bar-2.jpg" }], "img" : [{ "src" : "/images/photo-bar-2.jpg", "aria-hidden" : "true", "role" : "presentation" }] }'>
    </picture>
</div>

<section aria-labelledby="product-usage-title" class="view section">
    <div id="product-usage" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="title section__block">
            <h2 id="product-usage-title" class="title__text">CLEAN XTREAM WITH TRIPLE-ACTION POWER</h2>
        </div>

        <div class="section__block mask">
            <div class="figure figure--fill bg bg--light">
                <figure class="figure__item">
                    <picture class="contain contain--figure figure__frame" data-src-img="/images/xtream-foaming.jpg" data-attr='{ "alt" : "Man spray-cleaning the side of a motorhome" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>XTREAM Foaming</h3>
                        <p>Aerates detergent and sprays it up to<br>15&rsquo; for maximum coverage</p>
                    </figcaption>
                </figure>
                <figure class="figure__item">
                    <picture class="contain contain--figure figure__frame" data-src-img="/images/xtream-cleaning.jpg" data-attr='{ "alt" : "Person spraying sidewalk" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>XTREAM Cleaning</h3>
                        <p>4 Quick-Connect nozzles with a wide<br>range of spray patterns</p>
                    </figcaption>
                </figure>
                <figure class="figure__item">
                    <picture class="contain contain--figure figure__frame" data-src-img="/images/xtream-rinsing.jpg" data-attr='{ "alt" : "Man rinsing grime off a driveway" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>XTREAM Rinsing</h3>
                        <p>Delivers up to 2200 <abbr title="Pounds per square inch">PSI</abbr>* + 1.65 <abbr title="Gallons per minute">GPM</abbr>*<br>to rinse the grime away!</p>
                    </figcaption>
                </figure>
            </div>
        </div>

        <div class="section__block text-center">
            <a href="#order" id="product-usage-order" class="btn btn--order btn--is-bigger">Click here to order now</a>
            <small class="disclaimer">*Max <abbr title="Pounds per square inch">PSI</abbr> at initial discharge per CSA internal pressure testing. Max <abbr title="Gallons per minute">GPM</abbr> with nozzle open at minimum pressure.</small>
        </div>
    </div>
</section>

<%
    Html.RenderPartial("Testimonials", Model, new ViewDataDictionary {
        { "useThumbnails", false },
        { "showMoreLink", true }
    });
%>

<section aria-labelledby="construction-title" class="view section">
    <div class="section__in view__in">
        <div class="title section__block">
            <h2 id="construction-title" class="title__text">Sun Joe<sup>&reg;</sup> Construction Is Superior</h2>
        </div>

        <div class="section__block mask">
            <div class="figure bg bg--light">
                <figure class="figure__item">
                    <picture class="contain contain--figure figure__frame" data-src-img="/images/close-up-hose.jpg" data-attr='{ "alt" : "Close up of the high-pressure hose" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>STEEL-REINFORCED<br>HIGH-PRESSURE HOSE</h3>
                        <p>High-tensile, wire-reinforced tubing over a smooth inner core minimizes pressure drop and maximizes performance</p>
                    </figcaption>
                </figure>
                <figure class="figure__item">
                    <picture class="contain contain--figure figure__frame" data-src-img="/images/close-up-lance.jpg" data-attr='{ "alt" : "Close up of the stainless steel adn brass lance" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>STAINLESS STEEL +<br>BRASS LANCE</h3>
                        <p>Rust- and corrosion-resistant, the highest quality in the industry, for long-lasting durability</p>
                    </figcaption>
                </figure>
                <figure class="figure__item">
                    <picture class="contain contain--figure figure__frame" data-src-img="/images/close-up-motor.jpg" data-attr='{ "alt" : "Close up inside of the motor" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>TOTAL STOP SYSTEM<br>TECHNOLOGY</h3>
                        <p>Automatically shuts off pump when trigger is not engaged to save energy, prolong pump and motor life</p>
                    </figcaption>
                </figure>
            </div>
        </div>
    </div>
</section>

<span class="svg-symbols">
    <svg>
        <symbol id="icon-chevron-thin-left" viewBox="0 0 20 20">
            <path d="M13.891 17.418c0.268 0.272 0.268 0.709 0 0.979s-0.701 0.271-0.969 0l-7.83-7.908c-0.268-0.27-0.268-0.707 0-0.979l7.83-7.908c0.268-0.27 0.701-0.27 0.969 0s0.268 0.709 0 0.979l-7.141 7.419 7.141 7.418z"></path>
        </symbol>
        <symbol id="icon-chevron-thin-right" viewBox="0 0 20 20">
            <path d="M13.25 10l-7.141-7.42c-0.268-0.27-0.268-0.707 0-0.979 0.268-0.27 0.701-0.27 0.969 0l7.83 7.908c0.268 0.271 0.268 0.709 0 0.979l-7.83 7.908c-0.268 0.271-0.701 0.27-0.969 0s-0.268-0.707 0-0.979l7.141-7.417z"></path>
        </symbol>
    </svg>
</span>