<%@ Control Language="C#" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>


<%
    var product = Model as Dtm.Framework.Base.Models.CampaignProductView;
    var layoutMode = ViewData["layoutMode"] as string ?? "inline";

    if (product != null)
    {

        var price = string.Format("${0}<sup>{1:00}</sup> {2}",
            (int)product.Price, (product.Price % (int)product.Price) * 100,
            product.ProductCode == "UP5ALL" ? string.Empty : " + Free Shipping");
        var minQty = product.MinQuantity == 0 ? 1 : product.MinQuantity;
        var hasAffirm = DtmContext.Order != null && DtmContext.Order.SiteExtraInfo3 != null && DtmContext.Order.SiteExtraInfo3 == "true";
        var affirmStartText = string.Empty;
        var affirmEndText = string.Empty;

        if (hasAffirm)
        {
            var maximumPaymentInstallment = SettingsManager.ContextSettings["Affirm.MaximumPaymentInstallment", 3];
            var imageUpUrl = String.Format("https://cdn-assets.affirm.com/images/black_logo-white_bg.svg?appV={0}", DtmContext.ApplicationVersion);
            var singlePayment = product.Price / maximumPaymentInstallment;
            var dollarText = (int)singlePayment;
            var centText = (singlePayment % dollarText) * 100;
            centText = (int)centText;

            affirmStartText = string.Format("<span>{0} payments of</span> ${1}<sup>{2:00}</sup> ", maximumPaymentInstallment, dollarText, centText);
            affirmEndText = string.Format("${0}<sup>{1:00}</sup> each", (int)product.Price, (product.Price % (int)product.Price) * 100);
            Html.Partial("AffirmJS");
        }

%>
<% if (layoutMode == "inline")
    { %>
<div class="upsell-card__action">
    <div class="upsell-offer upsell-card__action-item">
        <h3 class="upsell-offer__standfirst">Your Price Today:</h3>
        <%
    if (hasAffirm)
    {
        %>
        <div class="upsell-offer__price c-brand__headline">
            <%= affirmStartText %>
            <%= Html.Partial("AffirmVerbiage", new ViewDataDictionary { { "optionId", 0 }, { "modifier", "upsell__affirm" } }) %>
        </div>
        <span class="upsell-offer__total-price">
            <h3 class="upsell-offer__standfirst">Total Price:</h3>
            <div class="upsell-offer__price c-brand__headline">
                <%= affirmEndText %>
            </div>
        </span>
        <% }
    else
    {
        if (product.PropertyIndexer.Has("OriginalPrice"))
        {
        %>
        <div class="upsell-offer__price upsell-offer__price--strike c-brand__headline"><%=product.PropertyIndexer["OriginalPrice"]%></div>
        <%
    }
        %>
        <div class="upsell-offer__price c-brand__headline"><%=price %></div>
    <%} %>
    </div>

    <div class="upsell-cart upsell-card__action-item">
        <button class="upsell-cart__btn upsell-cart__btn--circle upsell-cart__btn--disable" data-mode="cart" data-exp="min" data-product="<%=product.ProductCode %>" id="<%=product.ProductCode %>Min" onclick="event.preventDefault();_upsellEngine.AddQuantity(this);updateHiddenFields();">
            <span>-</span>
        </button>
        <label class="upsell-cart__text" for="">
            <input type="tel" class="upsell-cart__input dtm__restyle" id="<%=product.ProductCode %>Qty" name="<%=product.ProductCode %>Qty" data-max="<%=product.MaxQuantity %>" data-min="<%=minQty %>" value="<%=minQty %>" disabled />
            <span>Qty</span>
        </label>
        <button class="upsell-cart__btn upsell-cart__btn--circle upsell-cart__btn--enable" data-mode="cart" data-exp="add" data-product="<%=product.ProductCode %>" id="<%=product.ProductCode %>Add" onclick="event.preventDefault();_upsellEngine.AddQuantity(this);updateHiddenFields();">
            <span>+</span>
        </button>
    </div>
</div>

<div class="vse"></div>
<% if (!DtmContext.IsMobile) { %>
<nav class="upsell__nav">
    <button type="button" id="<%=product.ProductCode %>Btn" data-product="<%=product.ProductCode %>" onclick="event.preventDefault();_upsellEngine.AddToCart(this);updateHiddenFields();" class="upsell__link upsell__link--contrast upsellItem">Add To Cart</button>
</nav>
<% } %>
<% } %>

<% if (layoutMode == "snackbar" && DtmContext.IsMobile)
    { %>
<div class="upsell-card__action-item upsell-snackbar">
    <div class="upsell-snackbar__group">
    <div class="upsell-snackbar__offer upsell-offer">
        <%if (hasAffirm)
                                { %>
            <div class="upsell-offer__price c-brand__headline">
                <%= affirmStartText %>
                <%= Html.Partial("AffirmVerbiage", new ViewDataDictionary { { "optionId", 0 }, { "modifier", "upsell__affirm" } }) %>
            </div>
        <%}
                                else
                                { %>
            <div class="upsell-offer__price c-brand__headline">
                <%= price %>
            </div>
        <%} %>
    </div>
    <nav class="upsell-snackbar__actions">
        <button type="button" id="snackbar-<%=product.ProductCode %>Btn" data-product="<%=product.ProductCode %>" onclick="event.preventDefault();_upsellEngine.AddToCart(this);updateHiddenFields();" class="upsell__link upsell__link--contrast upsellItem">Add To Cart</button>
    </nav>
    </div>
</div>
<% } %>

<%
    }

%>

