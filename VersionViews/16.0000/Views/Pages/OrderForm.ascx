<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="SJOXTREAM.Models" %>                                                                          

<%
    var productName = SettingsManager.ContextSettings["Label.ProductName"];

     Func<string, CampaignProductView> getProductByCode = ((productCode) => {
        var product = DtmContext.CampaignProducts.Where(cp => cp.ProductCode == productCode);

        return product.Any() ? product.FirstOrDefault() : new CampaignProductView();
    });

    Func<CampaignProductView, string> getOriginalPrice = ((product) =>
    {
        var discountOf = product.PropertyIndexer["DiscountOf"] ?? string.Empty;
        var plaTargetPageCodes = product.PropertyIndexer["PLATargetPageCodes"] ?? string.Empty;
        var plaDiscountOf = product.PropertyIndexer["PLADiscountOf"] ?? string.Empty;

        if (!string.IsNullOrWhiteSpace(plaTargetPageCodes) && !string.IsNullOrWhiteSpace(plaDiscountOf))
        {
            if (plaTargetPageCodes.Equals(DtmContext.PageCode))
            {
                discountOf = plaDiscountOf;
            }
        }

        return discountOf;
    });

    Func<CampaignProductView, string> getAffirmInstallmentByProductCode = ((product) =>
    {
        var installment = product.PropertyIndexer["AffirmEstimatePaymentAmount", string.Empty];

        var affirmProduct = DtmContext.CampaignProducts.Where(cp => cp.ProductCode == string.Format("AFF{0}", product.ProductCode));

        if (affirmProduct.Any())
        {
            installment = affirmProduct.Select(cp => cp.PropertyIndexer["AffirmEstimatePaymentAmount", string.Empty]).FirstOrDefault();
        }

        return installment;
    });

    Func<string, string> getOfferPricesByProductCode = ((productCode) =>
    {
        var viewData = new ViewDataDictionary
        {
            { "id", productCode },
            { "optionId", 3 },
            { "modifier", "package__affirm" }
        };

        var product = getProductByCode(productCode);

        viewData.Add("amount", product.Price.ToString());

        string originalPrice = getOriginalPrice(product);

        bool hasOriginalPrice = !string.IsNullOrEmpty(originalPrice) && !string.IsNullOrWhiteSpace(originalPrice);

        var messageTemplate = @"{{DiscountPrice}} or 12 monthly payments of ${{AffirmInstallment}} <br>with";

        if (hasOriginalPrice)
        {
            messageTemplate = string.Format(@"<s class=""package__price-discount-of"">${0}</s> {1}", originalPrice, messageTemplate);
        }

        var message = messageTemplate
            .Replace("{{DiscountPrice}}", product.Price.ToString("C2"))
            .Replace("{{AffirmInstallment}}", getAffirmInstallmentByProductCode(product));

        viewData.Add("message", message);

        return Html.Partial("AffirmVerbiage", viewData).ToString();
    });

%>

<div class="form c-brand--form" id="form">
    <%
        using (Html.BeginForm())
        {
    %>
    <div class="form__group">
        <div class="form__row">
            <div class="form__vse view">
                <div id="vse-error" class="view__anchor"></div>
                <div id="errorDiv" class="vse" data-vse-scroll>
                    <%= Html.ValidationSummary("The following errors have occured:") %>
                </div>
            </div>
            <div class="form__border">
                <div class="c-brand--form__fieldset">
                    <h2 class="c-brand--form__headline c-brand--form__legend">CHOOSE YOUR KIT</h2>
                    <div class="form__fieldset">
                        <input type="hidden" name="OrderType" value="none"/>
                        <div class="group group--options">

                            <div class="view offer-card">
                                <div id="SPX3000" class="view__anchor"></div>
                                <h3 class="offer-card__bar">SPX3000</h3>
                                <a id="DOWN1" data-code-custom="DOWN1" href="javascript:void(0);" class="cartBtn btn btn--order btn--cart">
                                   Add To Cart
                                </a>
                                <picture class="offer-card__picture contain contain--offer-card-picture" data-src-img="/images/products/SPX3000.jpg" data-attr='{ "alt" : "SPX3000 Package" }'>
                                    <noscript>
                                        <img src="/images/products/SPX3000.jpg" alt="SPX3000 Package" />
                                    </noscript>
                                </picture>
                                <div class="offer-card__in offer-card__fit">
                                    <div class="offer-card__copy">
                                        <h4>Includes:</h4>
                                        <ul class="list list--disc">
                                            <li>Sun Joe<sup>&reg;</sup> SPX3000 Electric Pressure Washer (14.5 amp motor, 2030 PSI Max, 1.76 GPM)</li>
                                            <li>5 Quick Connect Spray Tips</li>
                                            <li>Dual Detergent Tanks</li>
                                            <li>34-inch Extension Wand</li>
                                            <li>20-foot High Pressure Hose</li>
                                            <li>35-foot Power Cord w/ GFCI protection</li>
                                            <li>Includes Free Shipping, 2-Year Manufacturer's Warranty + 30-Day Money Back Guarantee</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="offer-card__in offer-card__fill">
                                    <div class="offer-card__group">
                                        <div class="offer-card__bar offer-card__bar--alt">
                                            <span>Special Introductory Offer!</span>
                                        </div>
                                    </div>
                                    <hr class="offer-card__push"/>
                                    <div class="group offer-card__bursts">
                                        <figure>
                                            <picture class="contain contain--free-shipping" data-src-img="/images/free-shipping.svg" data-attr='{ "alt" : "Free shipping" }'>
                                                <noscript>
                                                    <img src="/images/free-shipping.svg" alt="Free shipping" />
                                                </noscript>
                                            </picture>
                                        </figure>
                                        <figure>
                                            <picture class="contain contain--warranty" data-src-img="/images/badge-warranty--2.jpg" data-attr='{ "alt" : "2 year warranty" }'>
                                                <noscript>
                                                    <img src="/images/badge-warranty--2.jpg" alt="2 year warranty" />
                                                </noscript>
                                            </picture>
                                        </figure>
                                        <figure>
                                            <picture class="offer-card__burst contain contain--mbg" data-src-img="/images/burst-mbg--alt.svg" data-attr='{ "alt" : "30 day money back guarantee" }'>
                                                <noscript>
                                                    <img src="/images/burst-mbg--alt.svg" alt="30 day money back guarantee" />
                                                </noscript>
                                            </picture>
                                        </figure>
                                    </div>
                                    <hr />
                                    <div class="offer-card__price copy">
                                        <div class="offer-card__price-desc">
                                            <%= getOfferPricesByProductCode("DOWN1") %>
                                        
                                        </div>
                                        <a id="DOWN1_Second" data-code-custom="DOWN1" href="javascript:void(0);" class="cartBtn btn btn--order btn--cart">
                                           Add To Cart
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="view offer-card">
                                <div id="SPX3000-XT1" class="view__anchor"></div>
                                <h3 class="offer-card__bar">SPX3000-XT1 KIT</h3>
                                <a id="MAINTVLOW" data-code-custom="MAINTVLOW" href="javascript:void(0);" class="cartBtn btn btn--order btn--cart">
                                   Add To Cart
                                </a>
                                <picture class="offer-card__picture contain contain--offer-card-picture" data-src-img="/images/products/SPX3000-XT1.jpg" data-attr='{ "alt" : "SPX3000-XT1 Package" }'>
                                    <noscript>
                                        <img src="/images/products/SPX3000-XT1.jpg" alt="SPX3000-XT1 Package" />
                                    </noscript>
                                </picture>
                                <div class="offer-card__in offer-card__fit">
                                    <div class="offer-card__copy">
                                        <h4>Includes:</h4>
                                        <ul class="list list--disc">
                                            <li>Sun Joe<sup>&reg;</sup> SPX3000 Electric Pressure Washer (13 amp motor, 2200 PSI Max, 1.65 GPM)</li>
                                            <li>4 Quick Connect Spray Tips</li>
                                            <li>Detergent Foam Cannon</li>
                                            <li>34-inch Extension Wand</li>
                                            <li>20-foot High Pressure Hose</li>
                                            <li>35-foot Power Cord w/ GFCI protection</li>
                                            <li>Includes Free Shipping, 3-Year Manufacturer's Warranty + 30-Day Money Back Guarantee</li>
                                        </ul>
                                        <h5 class="offer-card__highlight">Bonus Items:</h5>
                                        <ul class="list list--disc">
                                            <li>Wheel + Rim Brush, Utility Brush</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="offer-card__in offer-card__fill">
                                    <div class="offer-card__group">
                                        <div class="offer-card__bar offer-card__bar--alt">
                                            <span>Over $120 In Bonus Items!</span>
                                        </div>
                                    </div>
                                    <hr class="offer-card__push"/>
                                    <div class="group offer-card__bursts">
                                        <figure>
                                            <picture class="contain contain--free-shipping" data-src-img="/images/free-shipping.svg" data-attr='{ "alt" : "Free shipping" }'>
                                                <noscript>
                                                    <img src="/images/free-shipping.svg" alt="Free shipping" />
                                                </noscript>
                                            </picture>
                                        </figure>
                                        <figure>
                                            <picture class="contain contain--warranty" data-src-img="/images/badge-warranty.jpg" data-attr='{ "alt" : "3 year warranty" }'>
                                                <noscript>
                                                    <img src="/images/badge-warranty.jpg" alt="3 year warranty" />
                                                </noscript>
                                            </picture>
                                        </figure>
                                        <figure>
                                            <picture class="offer-card__burst contain contain--mbg" data-src-img="/images/burst-mbg--alt.svg" data-attr='{ "alt" : "30 day money back guarantee" }'>
                                                <noscript>
                                                    <img src="/images/burst-mbg--alt.svg" alt="30 day money back guarantee" />
                                                </noscript>
                                            </picture>
                                        </figure>
                                    </div>
                                    <hr />
                                    <div class="offer-card__price copy">
                                        <div class="offer-card__price-desc">
                                           <%= getOfferPricesByProductCode("MAINTVLOW") %>
                                        </div>
                                        <a id="MAINTVLOW_Second" data-code-custom="MAINTVLOW" href="javascript:void(0);" class="cartBtn btn btn--order btn--cart">
                                           Add To Cart
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="view offer-card">
                                <div id="SPX3000-XT1-upgrade" class="view__anchor"></div>
                                <h3 class="offer-card__bar">SPX3000-XT1 UPGRADED KIT</h3>
                                <a id="MAINMP3LOW" data-code-custom="MAINMP3LOW" href="javascript:void(0);" class="cartBtn btn btn--order btn--cart">
                                   Add To Cart
                                </a>
                                <picture class="offer-card__picture contain contain--offer-card-picture" data-src-img="/images/products/SPX3000-XT1-upgrade.jpg" data-attr='{ "alt" : "SPX3000-XT1 Upgraded Package" }'>
                                    <noscript>
                                        <img src="/images/products/SPX3000-XT1-upgrade.jpg" alt="SPX3000-XT1 Upgraded Package" />
                                    </noscript>
                                </picture>
                                <div class="offer-card__in offer-card__fit">
                                    <div class="offer-card__copy">
                                        <h4>Includes:</h4>
                                        <ul class="list list--disc">
                                            <li>Sun Joe<sup>&reg;</sup> SPX3000 Electric Pressure Washer (13 amp motor, 2200 PSI Max, 1.65 GPM)</li>
                                            <li>4 Quick Connect Spray Tips</li>
                                            <li>Detergent Foam Cannon</li>
                                            <li>34-inch Extension Wand</li>
                                            <li>20-foot High Pressure Hose</li>
                                            <li>35-foot Power Cord w/ GFCI protection</li>
                                            <li>Includes Free Shipping, 3-Year Manufacturer's Warranty + 30-Day Money Back Guarantee</li>
                                        </ul>
                                        <h5 class="offer-card__highlight">Bonus Items:</h5>
                                        <ul class="list list--disc">
                                            <li>Wheel + Rim Brush, Utility Brush</li>
                                            <li>Sun Joe<sup>&reg;</sup> Detergent Trio (<a href="javascript:void(0);" class="bonuses__item bonuses__button link-on-fancybox" data-fancybox="" data-type="ajax" data-src="/BonusInfo?code=TRIO">Learn More</a>)</li>
                                            <li>Turbo Spray Nozzle (<a href="javascript:void(0);" class="bonuses__item bonuses__button link-on-fancybox" data-fancybox="" data-type="ajax" data-src="/BonusInfo?code=NOZZLE">Learn More</a>)</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="offer-card__in offer-card__fill">
                                    <div class="offer-card__group">
                                        <div class="offer-card__bar offer-card__bar--alt">
                                            <span>Over $200 In Bonus Items!</span>
                                        </div>
                                    </div>
                                    <hr class="offer-card__push"/>
                                    <div class="group offer-card__bursts">
                                        <figure>
                                            <picture class="contain contain--free-shipping" data-src-img="/images/free-shipping.svg" data-attr='{ "alt" : "Free shipping" }'>
                                                <noscript>
                                                    <img src="/images/free-shipping.svg" alt="Free shipping" />
                                                </noscript>
                                            </picture>
                                        </figure>
                                        <figure>
                                            <picture class="contain contain--warranty" data-src-img="/images/badge-warranty.jpg" data-attr='{ "alt" : "3 year warranty" }'>
                                                <noscript>
                                                    <img src="/images/badge-warranty.jpg" alt="3 year warranty" />
                                                </noscript>
                                            </picture>
                                        </figure>
                                        <figure>
                                            <picture class="offer-card__burst contain contain--mbg" data-src-img="/images/burst-mbg--alt.svg" data-attr='{ "alt" : "30 day money back guarantee" }'>
                                                <noscript>
                                                    <img src="/images/burst-mbg--alt.svg" alt="30 day money back guarantee" />
                                                </noscript>
                                            </picture>
                                        </figure>
                                    </div>
                                    <hr />
                                    <div class="offer-card__price copy">
                                        <div class="offer-card__price-desc">
                                         <%= getOfferPricesByProductCode("MAINMP3LOW") %>
                                        </div>
                                        <a id="MAINMP3LOW_Second" data-code-custom="MAINMP3LOW" href="javascript:void(0);" class="cartBtn btn btn--order btn--cart btn--cart">
                                           Add To Cart
                                        </a>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="form__row view">
            <div id="checkout" class="view__anchor"></div>
            <div class="form__border form__summary-review">
                <div class="c-brand--form__fieldset">
                    <h2 class="c-brand--form__headline c-brand--form__legend">Review Your Order</h2>
                    <div class="form__fieldset">
                        <%= Html.Partial("OrderFormReviewTable", Model) %>
                    </div>
                </div>
            </div>
        </div>

        <div class="form__row">
            <div class="form__field form__submit">
                <input type="hidden" name="OrderType" value="None" />
                <button id="AcceptOfferButton" name="acceptOffer" type="submit" class="btn btn--order">
                    Continue
                </button>
                <small class="disclaimer form__disclaimer">*Max <abbr title="Pounds per square inch">PSI</abbr> at initial discharge per CSA internal pressure testing. Max <dfn><abbr title="Gallons per minute">GPM</abbr></dfn> with nozzle open at minimum pressure.</small>
            </div>

            <div class="form__field u-mar--vert @x2-mar">
                <picture class="contain contain--square" data-src-img="/shared/images/PositiveSSL_tl_trans.png" data-attr='{ "alt" : "Secure Site. SSL Encryption" }'>
                </picture>
            </div>

            <div class="offer-details copy">
                <% Html.RenderSnippet("OFFERDETAILS"); %>
            </div>
        </div>

    </div>
    <%
        }
    %>
</div>
