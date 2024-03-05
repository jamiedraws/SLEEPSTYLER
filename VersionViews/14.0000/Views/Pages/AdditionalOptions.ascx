<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<div class="form__border">
    <div class="c-brand--form__fieldset">
        <h3 class="c-brand--form__headline c-brand--form__legend">
            SIGN UP AND SAVE UP TO 15% ON FUTURE ORDERS!
        </h3>
        <div class="form__fieldset">
            <label for="PromotionalEmails" class="form__checkbox">
                <span>
                    <span>
                        <input class="discount"  type="checkbox" data-eflex="draw" data-eflex-icon="checkmark" id="PromotionalEmails" name="PromotionalEmails" checked value="true">
                    </span>
                </span>
                <span>
                    <strong>Get 10% OFF Your Next Order:</strong> Sign Up to get promotional emails from Snow Joe&reg; + Sun Joe&reg; and we'll email you a Coupon Code eligible for snowjoe.com.
    
                </span>
            </label>
            <label for="PromotionalTexts" class="form__checkbox">
                <span>
                    <span>
                        <input class="discount" type="checkbox" data-eflex="draw" data-eflex-icon="checkmark" id="PromotionalTexts" name="PromotionalTexts" value="true">
                    </span>
                </span>
                <span>
                    <strong>EXTRA 5% OFF:</strong> Sign up for promotional texts from Snow Joe&reg; + Sun Joe&reg; for a total 15% discount on your next order and we'll email you a  Coupon Code eligible for snowjoe.com.
    
                    <span id="PromotionalPhoneCt" class="hide">
                        <label id="PromotionalPhoneLabel" for="PromotionalPhone" data-required class="c-brand--form__label @mv-o-grid--none o-grid__col @xs-u-vw--40 fn--right"><%= LabelsManager.Labels["Phone"] %></label>
                        <input name="PromotionalPhone" id="PromotionalPhone" type="tel" value="<%= ViewData["Phone"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["PhonePlaceholder"] %>" aria-labelledby="PhoneLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                    </span>
                </span>
            </label>
            <p class="bold">By signing up via email or text, you agree to receive marketing and promotional information from Snow Joe&reg; + Sun Joe&reg; at the email or phone number provided above. Consent is not a condition of any purchase. Msg and data rates may apply. View <a data-fancybox data-type="ajax" data-src="/SubPageInfo?page=Terms" href="javascript:;" id="additional-options-terms" aria-label="Terms of use">Terms</a> &amp; <a data-fancybox data-type="ajax" data-src="/SubPageInfo?page=PrivacyPolicy" href="javascript:;" id="additional-options-terms" aria-label="Privacy policy">Privacy</a>. Coupon codes are only valid on snowjoe.com and are not eligible on partner websites, exclusive TV offers, and on excluded items on snowjoe.com including deals and clearance items.</p>
        </div>
    </div>
</div>

<script>
     $("#PromotionalTexts").on("change", function(){
      
      const $email = $("#PromotionalEmails"),
            $txt = $(this);
    
      if ($txt.is(":checked") && !$email.is(":checked")) {
          $email.prop("checked", true);
      }
    });
    $("#PromotionalEmails").on("change", function(){
      	const $email = $(this),
            $txt = $("#PromotionalTexts");
    
      if (!$email.is(":checked") && $txt.is(":checked")) {
          $txt.prop("checked", false);
      }
      
    });
</script>