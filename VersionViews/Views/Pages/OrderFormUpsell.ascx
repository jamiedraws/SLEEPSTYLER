<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<% 
    var affirm = Html.Partial("AffirmVerbiage", new ViewDataDictionary {
        { "optionId", 0 },
        { "modifier", "form__affirm" }
    });
%>
<fieldset class="steps form__fieldset" id="upgradeFieldset">
    <div class="c-brand--form__legend width-at-100">
        <h3 class="c-brand--form__headline">
            <b>STEP 2:</b> UPGRADE YOUR ORDER
        </h3>
    </div>
    <div class="form__group">
        <figure class="group group--upsell">
            <picture class="form__upsell-image" style="--arp:320/360;" data-src-img="/images/upsells/UP8/UP8.jpg" data-attr='{ "alt": "Xtream Clean Kit contains bottle of heavy duty cleaner, house and deck wash and auto foam" }'>
                <noscript>
                <img
                    src="/images/upsells/UP8/UP8.jpg"
                    alt="Xtream Clean Kit contains bottle of heavy duty cleaner, house and deck wash and auto foam"
                />
                </noscript>
            </picture>
            <figcaption class="form__upsell-text">
                <div class="form__upsell-bar">
                    <div 
                        class="form__radio form__radio--inline"
                        data-offer-type="none"
                    >
                        <label for="checkboxUP8">
                            <input
                                data-eflex="draw"
                                type="checkbox"
                                id="checkboxUP8"
                                data-code="UP8"
                                data-code-toggle="true"
                                disabled
                            />
                        </label>
                        <span class="form__radio__group">
                            <span class="form__radio__text form__radio--multi">
                                <label for="checkboxUP8">Yes, I would like to add the XTREAM CLEAN KIT</label>
                                <span class="form__affirm-text">As low as $3.33/mo + FREE SHIPPING <%= affirm %></span>
                            </span>
                            <span class="form__radio__text form__radio--single">
                                <span>Yes, I would like to add the XTREAM CLEAN KIT</span>
                                <span class="form__affirm-text">$39.99 + FREE SHIPPING</span>
                            </span>
                        </span>
                        
                    </div>
                </div>
                <p>
                    Boost the cleaning power of your new Sun Joe XTREAM's foamer
                    cannon with a 3-pack of our most popular detergents.
                </p>
                <p>
                    <strong
                        >You'll get 1 qt. of each of the following
                        ultra-concentrate formulas</strong
                    >
                    <span class="block"
                        >(we recommend a 1:10 or 1:20 dilution with
                        water):</span
                    >
                </p>

                <ul>
                    <li>
                        <strong>Heavy Duty Cleaner + Degreaser:</strong> Tackle
                        all kinds of tough stains
                    </li>
                    <li>
                        <strong>Auto Foam:</strong> Specially formulated to
                        clean and shine your car
                    </li>
                    <li>
                        <strong>House + Deck Wash:</strong> Revive your deck and
                        the exterior of your home
                    </li>
                </ul>
            </figcaption>
        </figure>
    </div>
</fieldset>