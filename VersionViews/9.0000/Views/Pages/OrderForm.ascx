<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<%
    var productName = SettingsManager.ContextSettings["Label.ProductName"];
%>

<div class="form c-brand--form" id="form">
    <%
        using (Html.BeginForm())
        {
            var pageCode = DtmContext.PageCode.ToUpper();
            var mainItemDefaultDictionary = new Dictionary<string, string>
            {
                { "BESTVALUE", "MAINBV3" },
                { "TVOFFER", "MAINTV" }
            };
            var filterMainItemDefault = mainItemDefaultDictionary.Where(i => i.Key == pageCode);
            var mainItemDefault = filterMainItemDefault.Any() ? filterMainItemDefault.Select(i => i.Value).FirstOrDefault() : "MAINMP3";
            var mainItem = DtmContext.ShoppingCart.Items.Where(i => i.CampaignProduct.ProductTypeId == 1).Select(i=> i.ProductCode).FirstOrDefault();
            mainItem = mainItem != null ? mainItem : mainItemDefault;
            var affirmPrefix = mainItem.StartsWith("AFF") ? "AFF" : string.Empty;
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
                    <h2 class="c-brand--form__headline c-brand--form__legend">You get all this when you order now</h2>
                    <div class="form__fieldset">
                        <div class="offer-card offer-card--double-offer">
                            <div class="offer-card__group">
                                <div class="offer-card__pictures">
                                    <picture class="offer-card__picture contain contain--offer-card-picture" data-src-img="/images/sunjoe-set.jpg" data-attr='{ "alt" : "Complete Sun Joe&reg; set" }'>
                                    </picture>
                                </div>
                                <div class="offer-card__copy">
                                    <h3 class="offer-card__list-title">Includes:</h3>
                                    <ul class="list list--bullet">
                                        <li>Sun Joe SPX3000-XT XTREAM Electric Pressure Washer</li>
                                        <li>Foamer Soap Cannon</li>
                                        <li>4 Quick Connect Tips</li>
                                        <li>Stainless Steel Lance</li>
                                        <li>20' High-Pressure Hose</li>
                                        <li><strong>BONUS Items</strong> <span class="form__accent">(Select bonus package below)</span></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="form__row view">
            <div id="kit-selection" class="view__anchor"></div>
            <div class="form__border">
                <div class="c-brand--form__fieldset">
                    <h2 class="c-brand--form__headline c-brand--form__legend">Customize Your Kit - Select Your Bonus Package</h2>
                    <div class="form__fieldset">
                        <%
                            var isCheckedForMAINTV = mainItem.Contains("MAINTV");
                        %>
                        <div id="main-offer" class="package <%= isCheckedForMAINTV ? "package--is-selected" : string.Empty %>">
                            <label for="product1" class="package__checkbox form__checkbox-label">
                               <input type="radio" data-item="<%=affirmPrefix %>MAINTV" <%= isCheckedForMAINTV ? "checked" :  string.Empty%> id="product1" name="cartitem" class="cartRadio">
                               <span class="form__checkbox"></span>
                            </label>
                            <span class="package__copy">
                                <label for="product1" class="package__label">
                                    <span class="package__title">TV Offer</span>
                                    <span class="package__subtitle">Bonus Items <span class="form__accent">$120 Value</span></span>
                                </label>
                                <span class="package__details">
                                    <%= Html.Partial("AffirmVerbiage", new ViewDataDictionary {
                                        { "optionId", 3 },
                                        { "id", "MAINTV" },
                                        { "modifier", "package__affirm" },
                                        { "amount", "23999" },
                                        { "message", "$239.99 or 12 monthly payments of $23 <br>with" }
                                    }) %>
                                </span>
                            </span>
                            <label for="product1" class="package__bonuses">
                                <%= Html.Partial("Bonuses", new ViewDataDictionary { 
                                    { "id", "product1" } 
                                }) %>
                            </label>
                        </div>

                        <%
                            var isCheckedForMAINMP = mainItem.Contains("MAINMP3"); 
                        %>
                        <div id="most-popular" class="package <%= isCheckedForMAINMP ? "package--is-selected" : string.Empty %>">
                            <label for="product2" class="package__checkbox form__checkbox-label">
                               <input type="radio" data-item="<%=affirmPrefix %>MAINMP3" <%= isCheckedForMAINMP ? "checked" :  string.Empty%> id="product2" name="cartitem" class="cartRadio">
                               <span class="form__checkbox"></span>
                            </label>
                            <span class="package__copy">
                                <label for="product2" class="package__label">
                                    <span class="package__title">Most Popular</span>
                                    <span class="package__subtitle">Bonus Items <span class="form__accent">$200 Value</span></span>
                                </label>
                                <span class="package__details">
                                    <%= Html.Partial("AffirmVerbiage", new ViewDataDictionary {
                                        { "optionId", 3 },
                                        { "id", "MAINMP3" },
                                        { "modifier", "package__affirm" },
                                        { "amount", "29997" },
                                        { "message", "$299.97 or 12 monthly payments of $29 <br>with" }
                                    }) %>
                                 </span>
                            </span>
                            <label for="product2" class="package__bonuses">
                                <%= Html.Partial("Bonuses", new ViewDataDictionary { 
                                    { "id", "product2" },
                                    { "include", new string[] { "most-popular" } }
                                }) %>
                            </label>
                        </div>
                        <%
                            var isCheckedForMAINBV = mainItem.Contains("MAINBV3"); 
                        %>
                        <div id="best-value" class="package <%= isCheckedForMAINBV ? "package--is-selected" : string.Empty %>">
                            <label for="product3" class="package__checkbox form__checkbox-label">
                                <input type="radio" data-item="<%=affirmPrefix %>MAINBV3" <%= isCheckedForMAINBV ? "checked" :  string.Empty%>  id="product3" name="cartitem" class="cartRadio">
                                <span class="form__checkbox"></span>
                            </label>
                            <span class="package__copy">
                                <label for="product3" class="package__label">
                                    <span class="package__title">Best Value</span>
                                    <span class="package__subtitle">Bonus Items <span class="form__accent">$360 Value</span></span>
                                </label>
                                <span class="package__details">
                                    <%= Html.Partial("AffirmVerbiage", new ViewDataDictionary {
                                        { "optionId", 3 },
                                        { "id", "MAINBV3" },
                                        { "modifier", "package__affirm" },
                                        { "amount", "39996" },
                                        { "message", "$399.96 or 12 monthly payments of $38 <br>with" }
                                    }) %>
                                </span>
                            </span>
                            <label for="product3" class="package__bonuses">
                                <%= Html.Partial("Bonuses", new ViewDataDictionary { 
                                    { "id", "product3" },
                                    { "include", new string[] { "most-popular", "best-value" } }
                                }) %>
                            </label>
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
