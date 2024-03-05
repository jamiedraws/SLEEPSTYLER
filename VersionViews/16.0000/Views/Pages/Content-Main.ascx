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
            <picture class="contain contain--photobar" data-src-img="/images/photo-bar-3.jpg" data-tag='{ "source" : [{ "media" : "(max-width: 600px)", "srcset" : "/images/mobile/photo-bar-3.jpg" }, { "media" : "(min-width: 601px)", "srcset" : "/images/photo-bar-3.jpg" }], "img" : [{ "src" : "/images/photo-bar-3.jpg", "aria-hidden" : "true", "role" : "presentation" }] }'>
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
                    <picture class="contain contain--square" data-src-img="/images/burst-psi--2030.png" data-attr='{ "alt": "2030 Pounds per square inch Max" }'>
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
            <h2 id="features-title" class="features__title title__text">
                SUN JOE<sup>&reg;</sup> FEATURES + BENEFITS
            </h2>
        </div>
        <div class="section__block">
            <div class="features__group">
                <div class="features__item">
                    <img src="/images/spx3000.png" loading="lazy" alt="Sun Joe&reg; SPX3000 Electric Pressure Washer" width="149" height="249">
                    <h3 class="features__item-title">
                        <span>Sun Joe<sup>&reg;</sup> SPX3000</span>
                        <span>Electric Pressure Washer</span>
                    </h3>
                    <ul class="list list--square">
                        <li><strong>DUAL DETERGENT TANKS:</strong> Two 0.9 L onboard, removable tanks carry and store different types of detergent to simultaneously tackle different cleaning projects</li>
                        <li><strong>CLEANING NOZZLES:</strong> 5 Quick-Connect nozzles (0&deg;, 15&deg;, 25&deg;, 40&deg; and soap) in a range of spray patterns from pinpoint jet to fan spray tackle heavy, medium and light duty jobs (<a href="/images/nozzles--alt.jpg" data-fancybox class="link-on-fancybox">Click here for usage guide</a>)</li>
                        <li><strong>RINSING:</strong> Powerful 14.5 amp motor generates 2030 PSI* of maximum pressure and 1.76 GPM* of maximum flow to rinse away dirt and grime for a Sun Joe shine</li>
                        <li><strong>TOTAL STOP SYSTEM (TSS) TECHNOLOGY:</strong> Automatically shuts off both pump and power when the trigger is not engaged to save energy, prolong pump life, and ensure quieter operation when not in use</li>
                        <li><strong>PROFESSIONAL-GRADE CONSTRUCTION:</strong> 20&rsquo; high-pressure hose features high-tensile, wire-reinforced tubing over a smooth inner core to minimize pressure drop and maximize performance</li>
                        <li><strong>LEAK-PROOF PERFORMANCE:</strong> Durable 34&rdquo; spray wand with stainless steel lance, solid brass fittings and all metal connections</li>
                        <li><strong>LIGHTWEIGHT + PORTABLE:</strong> Weighs just under 31 lbs and wheels easily from one dirty job to the next</li>
                        <li><strong>EASY, ELECTRIC, EMISSION-FREE OPERATION:</strong> Starts instantly and reliably by squeezing the trigger; includes 35&rsquo; power cord with GFCI protection and convenient on/off switch</li>
                    </ul>
                    <div class="features__item-btn">
                        <a href="#order" id="features-order-1" class="btn btn--order">Click here to order now</a>
                    </div>
                </div>
                <div class="features__item">
                    <img src="/images/spx3000-xt1.png" loading="lazy" alt="Sun Joe&reg; SPX3000-XT1 XTREAM Electric Pressure Washer" width="149" height="249">
                    <h3 class="features__item-title">
                        <span>Sun Joe<sup>&reg;</sup> SPX3000-XT1 XTREAM</span>
                        <span>Electric Pressure Washer</span>
                    </h3>
                    <ul class="list list--square">
                        <li><strong>XTREAM FOAMING:</strong> Detergent foam cannon aerates detergent and shoots it up to 15&rsquo; to give your cleaning blast a boost</li>
                        <li><strong>XTREAM CLEANING:</strong> 4 Quick-Connect nozzles (0&deg;, 15&deg;, 25&deg;, 40&deg;) in a range of spray patterns from pinpoint jet to fan spray tackle heavy, medium and light duty jobs (<a href="/images/nozzles.jpg" data-fancybox class="link-on-fancybox">Click here for usage guide</a>)</li>
                        <li><strong>XTREAM RINSING:</strong> Powerful 13 amp motor generates 2200 PSI* of maximum pressure and 1.65 GPM* of maximum flow to rinse away dirt and grime for a Sun Joe shine</li>
                        <li><strong>TOTAL STOP SYSTEM (TSS) TECHNOLOGY:</strong> Automatically shuts off both pump and power when the trigger is not engaged to save energy, prolong pump life, and ensure quieter operation when not in use</li>
                        <li><strong>PROFESSIONAL-GRADE CONSTRUCTION:</strong> 20&rsquo; high-pressure hose features high-tensile, wire-reinforced tubing over a smooth inner core to minimize pressure drop and maximize performance</li>
                        <li><strong>LEAK-PROOF PERFORMANCE:</strong> Durable 34&rdquo; spray wand with stainless steel lance, solid brass fittings and all metal connections</li>
                        <li><strong>LIGHTWEIGHT + PORTABLE:</strong> Weighs just under 23 lbs and wheels easily from one dirty job to the next</li>
                        <li><strong>EASY, ELECTRIC, EMISSION-FREE OPERATION:</strong> Starts instantly and reliably by squeezing the trigger; includes 35&rsquo; power cord with GFCI protection and convenient on/off switch</li>
                        <li><strong>BONUS GIFTS:</strong> Includes 3 Year Warranty + 2 Free Brushes</li>
                    </ul>
                    <div class="features__item-btn">
                        <a href="#order" id="features-order-2" class="btn btn--order">Click here to order now</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="section__block text-center">
            <small class="disclaimer">*Max <abbr title="Pounds per square inch">PSI</abbr> at initial discharge per CSA internal pressure testing *Max <abbr title="Gallons per minute">GPM</abbr> with nozzle open at minimum pressure</small>
        </div>
    </div>
</section>

<div class="bg bg--contrast">
    <picture class="contain contain--photobar" data-src-img="/images/photo-bar-4.jpg" data-tag='{ "source" : [{ "media" : "(max-width: 600px)", "srcset" : "/images/mobile/photo-bar-4.jpg" }, { "media" : "(min-width: 601px)", "srcset" : "/images/photo-bar-4.jpg" }], "img" : [{ "src" : "/images/photo-bar-4.jpg", "aria-hidden" : "true", "role" : "presentation" }] }'>
    </picture>
</div>

<section aria-labelledby="grime-title" class="view section">
    <div id="grime" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="title section__block">
            <h2 id="grime-title" class="title__text title__wrap">
                <span>WIN THE WAR ON GRIME WITH</span>
                <span>AMERICA&rsquo;S #1 PRESSURE WASHER!</span>
            </h2>
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
    <picture class="contain contain--photobar" data-src-img="/images/photo-bar-5.jpg" data-tag='{ "source" : [{ "media" : "(max-width: 600px)", "srcset" : "/images/mobile/photo-bar-5.jpg" }, { "media" : "(min-width: 601px)", "srcset" : "/images/photo-bar-5.jpg" }], "img" : [{ "src" : "/images/photo-bar-5.jpg", "aria-hidden" : "true", "role" : "presentation" }] }'>
    </picture>
</div>

<section aria-labelledby="product-usage-title" class="view section">
    <div id="product-usage" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="title section__block">
            <h2 id="product-usage-title" class="title__text">CLEAN WITH TRIPLE-ACTION POWER</h2>
        </div>

        <div class="section__block mask">
            <div class="figure figure--fill bg bg--light">
                <figure class="figure__item">
                    <picture class="contain contain--figure figure__frame" data-src-img="/images/power-foam.jpg" data-attr='{ "alt" : "Nozzle spraying foam" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>POWER FOAM</h3>
                        <p>
                            Use the soap nozzle to apply a rich <br>lather of detergent.
                        </p>
                    </figcaption>
                </figure>
                <figure class="figure__item">
                    <picture class="contain contain--figure figure__frame" data-src-img="/images/power-clean.jpg" data-attr='{ "alt" : "Different degrees with different nozzles" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>POWER CLEAN</h3>
                        <p>
                            5 Quick-Connect nozzles with a wide <br>range of spray patterns.
                        </p>
                    </figcaption>
                </figure>
                <figure class="figure__item">
                    <picture class="contain contain--figure figure__frame" data-src-img="/images/power-rinse.jpg" data-attr='{ "alt" : "Man pressure washing a deck (2030 PSI MAX)" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>POWER RINSE</h3>
                        <p>
                            Delivers up to 2030 PSI* + 1.76 GPM* <br>to rinse the grime away!
                        </p>
                    </figcaption>
                </figure>
            </div>
        </div>

        <div class="section__block text-center">
            <a href="#order" id="product-usage-order" class="btn btn--order btn--is-bigger">Click here to order now</a>
            <small class="disclaimer">*Max <abbr title="Pounds per square inch">PSI</abbr> at initial discharge per CSA internal pressure testing. *Max <abbr title="Gallons per minute">GPM</abbr> with nozzle open at minimum pressure.</small>
        </div>
    </div>
</section>

<%
    Html.RenderPartial("Testimonials", Model, new ViewDataDictionary {
        { "useThumbnails", false },
        { "showMoreLink", true },
        { "title", "show" }
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
                    <picture class="contain contain--figure2 figure__frame" data-src-img="/images/close-up-tanks.jpg" data-attr='{ "alt" : "Close up of the detergent tanks" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>2 ON-BOARD <br>DETERGENT TANKS</h3>
                        <p>Conveniently switch between different detergents with its detergent selection dial and blast away all sorts of grime</p>
                    </figcaption>
                </figure>
                <figure class="figure__item">
                    <picture class="contain contain--figure2 figure__frame" data-src-img="/images/close-up-lance-2.jpg" data-attr='{ "alt" : "Close up of the stainless steel and brass lance" }'>
                    </picture>
                    <figcaption class="copy">
                        <h3>STAINLESS STEEL +<br>BRASS LANCE</h3>
                        <p>Rust- and corrosion-resistant, the highest quality in the industry, for long-lasting durability</p>
                    </figcaption>
                </figure>
                <figure class="figure__item">
                    <picture class="contain contain--figure2 figure__frame" data-src-img="/images/close-up-trigger.jpg" data-attr='{ "alt" : "Close up of trigger" }'>
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

