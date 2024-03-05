<%@ Control Language="C#" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<div class="form__section">
    <div class="view__scroll">
        <%-- // BEGIN #paymentForm --%>
        <fieldset id="paymentForm" class="form__border">

            <%-- // @PAYMENT HEADLINE --%>
            <div class="c-brand--form__legend u-vw--100">
                <h3 class="c-brand--form__headline">Select Your Payment Method
                </h3>
            </div>

            <div class="form__payment">
                <ul class="form__fieldset">

                    <%-- // @PAYMENT ICONS --%>
                    <li class="c-brand--form__item o-grid--vert--center u-vw--100">
                        <div id="cc" class="c-brand--form__field o-grid__col @xs-u-bs--reset @xs-u-vw--100"></div>
                    </li>

                    <%-- // @PAYMENT TYPE --%>
                    <li id="CardTypeCt" class="c-brand--form__item o-grid--vert--center u-vw--100">
                        <label for="CardType" data-required class="c-brand--form__label">Type</label>
                        <%= Html.DropDownList("CardType", new[]
                                    {
                                    new SelectListItem { Text = "Visa", Value = "V"},
                                    new SelectListItem { Text = "Mastercard", Value = "M"},
                                    new SelectListItem { Text = "Discover", Value = "D"},
                                    new SelectListItem { Text = "American Express", Value= "AX"}
                                }, new { @class = "c-brand--form__select o-box o-shadow u-vw--100 fx--animate" })
                        %>
                    </li>

                    <%-- // @PAYMENT NUMBER --%>
                    <li id="CardNumberCt" class="c-brand--form__item o-grid--vert--center u-vw--100 form__field">
                        <label id="CardNumberLabel" for="CardNumber" data-required class="c-brand--form__label"><%= LabelsManager.Labels["CardNumber"] %></label>
                        <input id="CardNumber" name="CardNumber" type="tel" value="<%= ViewData["CardNumber"] %>" placeholder="<%= LabelsManager.Labels["CardNumberPlaceholder"] %>" aria-labelledby="CardNumberLabel" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @mv-u-vw--100 fx--animate">
                    </li>

                    <%-- // @PAYMENT EXP. DATE --%>
                    <li id="CardExpirationCt" class="c-brand--form__item o-grid--vert--center u-vw--100 form__field">
                        <label for="CardExpirationMonth" data-required class="c-brand--form__label"><%= LabelsManager.Labels["ExpirationDate"] %></label>
                        <div class="form__group form__group--item">
                            <div class="form__item">
                                <%= Html.CardExpirationMonth("CardExpirationMonth", new { @class = "c-brand--form__select o-box o-shadow u-vw--100 fx--animate" }) %>
                            </div>
                            <div class="form__item">
                                <%= Html.NumericDropDown("CardExpirationYear", DateTime.Now.Year, DateTime.Now.Year + 10, ViewData["CardExpirationYear"], new { @class = "c-brand--form__select o-box o-shadow u-vw--100 fx--animate" }) %>
                            </div>
                        </div>
                    </li>

                    <%-- // @PAYMENT CVV2 --%>
                    <li id="CardCvv2Ct" class="c-brand--form__item o-grid--vert--center u-vw--100 form__field">
                        <label id="CardCvv2Label" for="CardCvv2" data-required class="c-brand--form__label"><%= LabelsManager.Labels["CVV2"] %></label>
                        <div class="form__group form__group--item">
                            <div class="form__item">
                                <input id="CardCvv2" name="CardCvv2" type="tel" value="<%= ViewData["CardCvv2"] %>" maxlength="5" placeholder="<%= LabelsManager.Labels["CVV2Placeholder"] %>" aria-labelledby="CardCvv2Label" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
                            </div>
                            <div class="form__item">
                                <a href="<%= LabelsManager.Labels["CVV2DisclaimerLink"] %>" title="<%= LabelsManager.Labels["CVV2DisclaimerLinkTitle"] %>" id="cvv2" class="c-brand--form__hint o-grid__col @xs-u-vw--100 has-fancybox fancybox.ajax"><%= LabelsManager.Labels["CVV2Disclaimer"] %></a>
                            </div>
                        </div>
                    </li>

                </ul>
            </div>

        </fieldset>
        <%-- // END #paymentForm --%>
    </div>
</div>