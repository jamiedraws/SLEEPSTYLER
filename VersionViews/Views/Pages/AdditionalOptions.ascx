<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<fieldset class="form__extra-options extra-options form__fieldset">
    <div class="c-brand--form__legend u-vw--100">
        <h3 class="c-brand--form__headline">
            SIGN UP AND SAVE UP TO 15% ON FUTURE ORDERS!
        </h3>
    </div>
    <div class="form__group">
        <label for="PromotionalEmails" class="row form__checkbox">
            <div class="col">
                <div>
                    <input class="discount"  type="checkbox" data-eflex="draw" data-eflex-icon="checkmark" id="PromotionalEmails" name="PromotionalEmails" checked value="true">
                </div>
            </div>
            <div class="col left-padding">
                <strong>Get 10% OFF Your Next Order:</strong> Sign Up to get promotional emails from Snow Joe&reg; + Sun Joe&reg; and we'll email you a Coupon Code eligible for snowjoe.com.
    
            </div>
        </label>
        <label for="PromotionalTexts" class="row form__checkbox">
            <div class="col">
                <div>
                    <input class="discount" type="checkbox" data-eflex="draw" data-eflex-icon="checkmark" id="PromotionalTexts" name="PromotionalTexts" value="true">
                </div>
            </div>
            <div class="col left-padding">
                <strong>EXTRA 5% OFF:</strong> Sign up for promotional texts from Snow Joe&reg; + Sun Joe&reg; for a total 15% discount on your next order and we'll email you a  Coupon Code eligible for snowjoe.com.
    
                <div id="PromotionalPhoneCt" class="hide">
                    <label id="PromotionalPhoneLabel" for="PromotionalPhone" data-required class="c-brand--form__label @mv-o-grid--none o-grid__col @xs-u-vw--40 fn--right"><%= LabelsManager.Labels["Phone"] %></label>
                    <input name="PromotionalPhone" id="PromotionalPhone" type="tel" value="<%= ViewData["Phone"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["PhonePlaceholder"] %>" aria-labelledby="PhoneLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                </div>
    
            </div>
        </label>
        <p class="bold">By signing up via email or text, you agree to receive marketing and promotional information from Snow Joe&reg; + Sun Joe&reg; at the email or phone number provided above. Consent is not a condition of any purchase. Msg and data rates may apply. <a href="Terms<%= Model.Extension %>">View Terms</a> &amp; <a href="Privacy-Policy<%= Model.Extension %>">Privacy</a>. Coupon codes are only valid on snowjoe.com and are not eligible on partner websites, exclusive TV offers, and on excluded items on snowjoe.com including deals, clearance and SupplyAID.</p>
    </div>
    <script>

        addEventListener("PaymentOptionSelected", function () {
            togglePhone();
        });
    
        addEventListener("DOMContentLoaded", function () {
            $(".discount").on("change", togglePhone);
            $('#PromotionalPhone').on('input', function () {
                var val = $(this).val() || '';
                var items = val.replace(/[^0-9]/gi, '').match(/^([0-9]{3})?([0-9]{3})?([0-9]+)$/);
                var newVal = '';
                if (items) {
                    items.splice(0, 1);
                    for (var i = 0; i < items.length; i++) {
                        if (typeof (items[i]) == 'undefined') {
                            items.splice(i, 1);
                            i--;
                        }
                        else {
                            items[i] = items[i].substr(0, 4);
                        }
                    }
                    newVal = items.join('-');
                }
                $(this).val(newVal);
            });
        });
    
        function togglePhone() {
            const promoPhone = $("#PromotionalPhoneCt"),
                hideClass = "hide";
            if ($("[name='OrderType']:checked").val() == "PayPalEC" && $("#PromotionalTexts").is(":checked")) {
                promoPhone.removeClass(hideClass);
            } else {
                promoPhone.addClass(hideClass);
            }
        }
    
    </script>
</fieldset>