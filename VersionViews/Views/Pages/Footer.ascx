<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var isFrontPage = DtmContext.Page.IsStartPageType;
    var isUpsell = DtmContext.Page.PageType.Equals("Upsell", StringComparison.InvariantCultureIgnoreCase);
%>

<footer aria-label="Copyrights and policies" class="view view--footer footer">
    <div class="view__in">

        <picture class="footer__logo" data-src-img="/images/logo-sunjoe.svg" style="--arp: 300/149; --arp-max: 150px;">
      <noscript>
        <img src="/images/logo-sunjoe.svg" alt="">
      </noscript>
    </picture>

        <% if (isFrontPage)
            {
                Html.RenderSnippet("FOOTER-FRONTEND");
            }
            else
            {
                Html.RenderSnippet("COMMON-FOOTER");
            } %>
    </div>

    <% if (isFrontPage)
       {
            Html.RenderSnippet("ORDERFORMSCRIPT");

            Html.RenderPartial("Scripts");
            var cardPaymentSelection = (string)ViewData["CardPaymentSelection"] ?? string.Empty;
            if (cardPaymentSelection == "true")
            {%>
                <script type="text/javascript">

                    $(window).load(function () {
                        $('#otCARD').click();
                    });

                </script>
          <%}%>

            <script defer src="/js/nav.js?v=2"></script>
    <% } %>

    <div class="l-controls top-absolute">
        <% Html.RenderSiteControls(SiteControlLocation.ContentTop); %>
        <% Html.RenderSiteControls(SiteControlLocation.ContentBottom); %>
        <% Html.RenderSiteControls(SiteControlLocation.PageBottom); %>
        <%= Html.Partial("AffirmJs") %>
    </div>
</footer>
