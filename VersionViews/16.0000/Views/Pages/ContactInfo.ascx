<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Dtm.Framework.ClientSites.Web.ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<div id="billingInformation" class="form__section">
    <div class="view__scroll">
        <div class="form__border">

            <%-- // @BILLING HEADLINE --%>
            <div class="c-brand--form__legend u-vw--100">
                <h3 class="c-brand--form__headline">
                    <%= LabelsManager.Labels["BillingHeadline"] %>
                </h3>
            </div>

            <div class="form__billing">

                <%-- // BEGIN #billingInformation --%>
                <fieldset>
                    <ul class="form__fieldset">

                        <%-- // @BILLING FULL NAME --%>
                        <li id="BillingFullNameCt" class="form__field">
                            <label id="BillingFullNameLabel" for="BillingFullName" data-required class="c-brand--form__label"><%= LabelsManager.Labels["FullName"] %></label>
                            <input id="BillingFullName" maxlength="50" name="BillingFullName" type="text" value="<%= ViewData["BillingFullName"] %>" placeholder="<%= LabelsManager.Labels["FullNamePlaceholder"] %>" aria-labelledby="BillingFullNameLabel" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <%-- // @BILLING STREET --%>
                        <li id="BillingStreetCt" class="form__field">
                            <label id="BillingStreetLabel" for="BillingStreet" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Address"] %></label>
                            <div class=" @xs-u-bs--reset fld">
                                <input id="BillingStreet" name="BillingStreet" type="text" value="<%= ViewData["BillingStreet"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["AddressPlaceholder"] %>" aria-labelledby="BillingStreetLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                            </div>
                        </li>

                        <%-- // @BILLING STREET 2 --%>
                        <li id="BillingStreet2Ct" class="form__field">
                            <label id="BillingStreet2Label" for="BillingStreet2" class="c-brand--form__label"><%= LabelsManager.Labels["Address2"] %></label>
                            <input id="BillingStreet2" name="BillingStreet2" type="text" value="<%= ViewData["BillingStreet2"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["Address2Placeholder"] %>" aria-labelledby="BillingStreet2Label" aria-required="false" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <%-- // @BILLING CITY --%>
                        <li id="BillingCityCt" class="form__field">
                            <label id="BillingCityLabel" for="BillingCity" data-required class="c-brand--form__label"><%= LabelsManager.Labels["City"] %></label>
                            <input id="BillingCity" name="BillingCity" type="text" value="<%= ViewData["BillingCity"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["CityPlaceholder"] %>" aria-labelledby="BillingCityLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <%-- // @BILLING COUNTRY --%>
                        <li id="BillingCountryCt" class="form__field">
                            <label id="BillingCountryLabel" for="BillingCountry" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Country"] %></label>
                            <%= Html.DropDownListFor(m => m.BillingCountry, new SelectList(Model.Countries, "CountryCode", "CountryName"), LabelsManager.Labels["CountryPlaceholder"], new { @class = "c-brand--form__select o-box o-shadow @xs-u-vw--100 fx--animate" }) %>
                        </li>

                        <%-- // @BILLING STATE --%>
                        <li id="BillingStateCt" class="form__field">
                            <label id="BillingStateLabel" for="BillingState" data-required class="c-brand--form__label"><%= LabelsManager.Labels["State"] %></label>
                            <%= Html.DropDownListFor(m => m.BillingState, new SelectList(Model.States, "StateCode", "StateName"), LabelsManager.Labels["StatePlaceholder"], new { @class = "c-brand--form__select o-box o-shadow @xs-u-vw--100 fx--animate" }) %>
                        </li>

                        <%-- // @BILLING ZIP --%>
                        <li id="BillingZipCt" class="form__field">
                            <label id="BillingZipLabel" for="BillingZip" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Zip"] %></label>
                            <input id="BillingZip" name="BillingZip" type="tel" value="<%= ViewData["BillingZip"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["ZipPlaceholder"] %>" aria-labelledby="BillingZipLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <%-- // @PHONE --%>
                        <li id="PhoneCt" class="form__field">
                            <label id="PhoneLabel" for="Phone" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Phone"] %></label>
                            <input id="Phone" name="Phone" type="tel" value="<%= ViewData["Phone"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["PhonePlaceholder"] %>" aria-labelledby="PhoneLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <%-- // @EMAIL --%>
                        <li id="EmailCt" class="form__field">
                            <label id="EmailLabel" for="Email" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Email"] %></label>
                            <input id="Email" name="Email" type="email" value="<%= ViewData["Email"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["EmailPlaceholder"] %>" aria-labelledby="EmailLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <% if (SettingsManager.ContextSettings["OrderFormReview.ShowPrivacyPolicy", false])
                            { %>
                        <%-- // @PRIVACY POLICY --%>
                        <li id="PrivacyCt" class="form__field">
                            <a href="<%= SettingsManager.ContextSettings["OrderFormReview.PrivacyPolicyLink"] %><%= Model.Extension %>" title="<%= SettingsManager.ContextSettings["Label.ProductName"] %> | <%= LabelsManager.Labels["PrivacyPolicyText"] %>">
                                <%= LabelsManager.Labels["PrivacyPolicyText"] %>
                            </a>
                        </li>
                        <% } %>
                    </ul>
                </fieldset>

                <div class="form__fieldset">
                    <hr>

                <%-- // BEGIN #ShippingIsSame --%>
                    <label id="ShippingIsSame" for="ShippingIsDifferentThanBilling" class="o-grid--vert--center">
                        <div class="o-grid__col u-pad"><%= Html.CheckBoxFor(m => m.ShippingIsDifferentThanBilling) %></div>
                        <p class="o-grid__col u-pad"><%= LabelsManager.Labels["IsShippingDifferentFromBillingDisclaimer"] %></p>
                    </label>
                    <%-- // END #ShippingIsSame --%>
                </div>

                <%-- // BEGIN #shippingInformation --%>
                <fieldset id="shippingInformation" class="u-mar--top">

                    <ul class="form__fieldset">

                        <%-- // @SHIPPING FULL NAME --%>
                        <li id="ShippingFullNameCt" class="form__field">
                            <label id="ShippingFullNameLabel" for="ShippingFullName" data-required class="c-brand--form__label"><%= LabelsManager.Labels["FullName"] %></label>
                            <input id="ShippingFullName" name="ShippingFullName" type="text" value="<%= ViewData["ShippingFullName"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["FullNamePlaceholder"] %>" aria-labelledby="ShippingFullNameLabel" aria-required="true" class="c-brand--form__input o-grid__col o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <%-- // @SHIPPING STREET --%>
                        <li id="ShippingStreetCt" class="form__field">
                            <label id="ShippingStreetLabel" for="ShippingStreet" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Address"] %></label>
                            <input id="ShippingStreet" name="ShippingStreet" type="text" value="<%= ViewData["ShippingStreet"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["AddressPlaceholder"] %>" aria-labelledby="ShippingStreetLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <%-- // @SHIPPING STREET 2 --%>
                        <li id="ShippingStreet2Ct" class="form__field">
                            <label id="ShippingStreet2Label" for="ShippingStreet2" class="c-brand--form__label"><%= LabelsManager.Labels["Address2"] %></label>
                            <input id="ShippingStreet2" name="ShippingStreet2" type="text" value="<%= ViewData["ShippingStreet2"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["Address2Placeholder"] %>" aria-labelledby="ShippingStreet2Label" aria-required="false" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <%-- // @SHIPPING CITY --%>
                        <li id="ShippingCityCt" class="form__field">
                            <label id="ShippingCityLabel" for="ShippingCity" data-required class="c-brand--form__label"><%= LabelsManager.Labels["City"] %></label>
                            <input id="ShippingCity" name="ShippingCity" type="text" value="<%= ViewData["ShippingCity"] %>" maxlength="50" placeholder="<%= LabelsManager.Labels["CityPlaceholder"] %>" aria-labelledby="ShippingCityLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                        <%-- // @SHIPPING COUNTRY --%>
                        <li id="ShippingCountryCt" class="form__field">
                            <label for="ShippingCountry" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Country"] %></label>
                            <%= Html.DropDownListFor(m => m.ShippingCountry, new SelectList(Model.Countries, "CountryCode", "CountryName"), LabelsManager.Labels["CountryPlaceholder"], new { @class = "c-brand--form__select o-grid--col o-box o-shadow @xs-u-vw--100 fx--animate" })%>
                        </li>

                        <%-- // @SHIPPING STATE --%>
                        <li id="ShippingStateCt" class="form__field">
                            <label for="ShippingState" data-required class="c-brand--form__label"><%= LabelsManager.Labels["State"] %></label>
                            <%= Html.DropDownListFor(m => m.ShippingState, new SelectList(Model.States, "StateCode", "StateName"), LabelsManager.Labels["StatePlaceholder"], new { @class = "c-brand--form__select o-grid--col o-box o-shadow @xs-u-vw--100 fx--animate" })%>
                        </li>

                        <%-- // @SHIPPING ZIP --%>
                        <li id="ShippingZipCt" class="form__field">
                            <label id="ShippingZipLabel" for="ShippingZip" data-required class="c-brand--form__label"><%= LabelsManager.Labels["Zip"] %></label>
                            <input id="ShippingZip" name="ShippingZip" type="tel" value="<%= ViewData["ShippingZip"] %>" maxlength="10" placeholder="<%= LabelsManager.Labels["ZipPlaceholder"] %>" aria-labelledby="ShippingZipLabel" aria-required="true" class="c-brand--form__input o-box o-shadow @xs-u-vw--100 fx--animate">
                        </li>

                    </ul>

                </fieldset>
                <%-- // END #shippingInformation --%>
            </div>

        </div>
    </div>
</div>