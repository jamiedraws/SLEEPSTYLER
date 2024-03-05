<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var v = 55;
    var url = "{0}?v={1}";

    var preconnect = ViewData["preconnect"] as bool? ?? false;
    var preload = ViewData["preload"] as bool? ?? false;
    var defer = ViewData["defer"] as bool? ?? false;

    var isPaymentPage = DtmContext.PageCode == "PaymentForm" || DtmContext.PageCode == "ProcessPayment";
    var isProcessPayment = DtmContext.PageCode.ToUpper() == "PROCESSPAYMENT";
    var isIndex = DtmContext.PageCode == "Index" || DtmContext.PageCode == "MostPopular" || DtmContext.PageCode == "BestValue" || DtmContext.PageCode == "TVOffer";
    var isLandingPage = DtmContext.Page.IsStartPageType && !isPaymentPage;
    var isReviewPage = DtmContext.PageCode == "ReviewPage";
    var isUpsell = DtmContext.Page.PageType.Equals("Upsell", StringComparison.InvariantCultureIgnoreCase) || isReviewPage;
    var isConfirmation = DtmContext.Page.PageType == "Confirmation";
    var isFAQ = DtmContext.PageCode == "FAQ";
    var isReviews = DtmContext.PageCode == "Reviews";
    var pagesToExcludeFromSubPage = new string[] { "FAQ", "Reviews", "Index", "MostPopular", "BestValue", "TVOffer" };
    var isSubPage = isLandingPage && !pagesToExcludeFromSubPage.Contains(DtmContext.PageCode);

    // inform browser to preconnect to critical origins 
    if (preconnect) {
        %>
        <!--<link rel="preconnect" href="https://use.typekit.net" crossorigin />-->
        <%
    }

    // inform browser to preload all critical resources ahead of schedule
    if (preload)
    {
        var images = new List<string> {

        };

        foreach (var image in images) {
            var resource = String.Format(url, image, v);
            %>
            <link rel="preload" href="<%= resource %>" as="image">
            <%
        }

        // preload critical images
        if (isIndex)
        {
            var defaultImage = DtmContext.IsMobile ? "/images/product-xtream-sm.webp" : "/images/product-xtream.webp";
            %>
            <link rel="preload" href="<%= defaultImage %>" as="image" imagesrcset="/images/product-xtream-sm.webp 150w, /images/product-xtream.webp 288w" imagesizes="(max-width: 500px) 50px">
            <%
        }

        // preload critical stylesheets
        var styles = new List<string>
        {
            "/csstemplate2/default/shell.css"
        };

        if (isIndex)
        {
            styles.Add("/csstemplate2/default/index.crp.css");
        }

        if (isSubPage) {
            styles.Add("/csstemplate2/default/landing-page.css");
        }

        if (isFAQ) {
            styles.Add("/csstemplate2/default/faq.css");
        }

        if (isReviews) {
            styles.Add("/csstemplate2/default/reviews.css");
        }

        if (isPaymentPage) {
            styles.Add("/csstemplate2/default/checkout.css");
        }

        if (isUpsell) {
            styles.Add("/csstemplate2/default/upsell.css");
        }

        if (isConfirmation) {
            styles.Add("/csstemplate2/default/confirmation.css");
        }

        styles.Add("https://use.typekit.net/xkh1fab.css");

        foreach (var style in styles)
        {
            var resource = String.Format(url, style, v);
            %>
            <link rel="preload" href="<%= resource %>" as="style">
            <%
        }

        // preload critical fonts
        var fonts = new List<string>
        {
            // futura pt bold 700
            "https://use.typekit.net/af/053fc9/00000000000000003b9af1e4/27/l?primer=81a69539b194230396845be9681d114557adfb35f4cccc679c164afb4aa47365&fvd=n7&v=3",
            // futura pt 700
            "https://use.typekit.net/af/c4c302/000000000000000000012192/27/l?primer=81a69539b194230396845be9681d114557adfb35f4cccc679c164afb4aa47365&fvd=n6&v=3"
        };

        if (isIndex) {
            // open sans 600
            fonts.Add("https://use.typekit.net/af/8c3639/00000000000000007735a07c/30/l?primer=81a69539b194230396845be9681d114557adfb35f4cccc679c164afb4aa47365&fvd=n6&v=3");
        }

        if (isIndex || !DtmContext.IsMobile) {
            // futura pt bold italic 700
            fonts.Add("https://use.typekit.net/af/72575c/00000000000000003b9af1e5/27/l?primer=81a69539b194230396845be9681d114557adfb35f4cccc679c164afb4aa47365&fvd=i7&v=3");
        }

        if (isLandingPage && !isIndex) {
            // open sans 400
            fonts.Add("https://use.typekit.net/af/f18587/00000000000000007735a07a/30/l?primer=81a69539b194230396845be9681d114557adfb35f4cccc679c164afb4aa47365&fvd=n4&v=3");
        }

        foreach (var font in fonts)
        {
            %>
            <link rel="preload" href="<%= font %>" as="font" type="font/woff2" crossorigin="">
            <%
        }

        // preload critical scripts
        var scripts = new List<string>
        {

        };

        foreach (var script in scripts)
        {
            var resource = String.Format(url, script, v);
            %>
            <link rel="preload" href="<%= resource %>" as="script">
            <%
        }
    }

    // inform browser to request resources on document parse. dispatch as critical resources
    if (!preload && !defer)
    {
        // request critical stylesheets
        var styles = new List<string>
        {
            "https://use.typekit.net/xkh1fab.css",
            "/csstemplate2/default/shell.css"
        };

        if (isIndex) {
            styles.Add("/csstemplate2/default/index.crp.css");
        }

        if (isSubPage) {
            styles.Add("/csstemplate2/default/landing-page.css");
        }

        if (isFAQ) {
            styles.Add("/csstemplate2/default/faq.css");
        }

        if (isReviews) {
            styles.Add("/csstemplate2/default/reviews.css");
        }

        if (isPaymentPage) {
            styles.Add("/csstemplate2/default/checkout.css");
        }

        if (isUpsell) {
            styles.Add("/csstemplate2/default/upsell.css");
        }

        if (isConfirmation) {
            styles.Add("/csstemplate2/default/confirmation.css");
        }

        foreach (var style in styles)
        {
            var resource = String.Format(url, style, v);
            %>
            <link rel="stylesheet" href="<%= resource %>">
            <%
        }


        // request critical scripts. inform browser to defer script execution to document parse completion
        var scripts = new List<string>
        {

        };

        foreach (var script in scripts)
        {
            var resource = String.Format(url, script, v);
            %>
            <script src="<%= resource %>"></script>
            <%
        }
    }

    // inform browser to request resources on document parse. dispatch as deferred resources
    if (!preload && defer)
    {
        // request deferred stylesheets
        var styles = new List<string> {

        };

        if (isPaymentPage || isLandingPage) {
            var lightboxStyles = SettingsManager.ContextSettings["FrameworkJS/CSS.DtmStyle.Lightbox.Stylesheet", string.Empty];

            if (!string.IsNullOrEmpty(lightboxStyles)) {
                styles.Add(lightboxStyles);
            }
        }

        if (isPaymentPage) {
            styles.Add("/csstemplate2/default/checkout.css");
        }

        if (isProcessPayment)
        {
            styles.Add("/Shared/facebox/facebox.css");
        }

        if (isUpsell) {
            styles.Add("/csstemplate2/default/upsell.css");
        }

        if (isConfirmation) {
            styles.Add("/csstemplate2/default/confirmation.css");
        }

        foreach (var style in styles)
        {
            var resource = String.Format(url, style, v);
            %>
            <link rel="stylesheet" href="<%= resource %>" media="print" onload="this.media='all'; this.onload=null;">
            <noscript>
                <link rel="stylesheet" href="<%= resource %>">
            </noscript>
            <%
        }


        // request deferred scripts. inform browser to defer script execution to document parse completion
        var scripts = new List<string>
        {
            "/js/5.0000/app.js",
            "/js/5.0000/observer.js",
            "/js/5.0000/lazy.js",
            "/js/5.0000/page.js",
            "/js/5.0000/nav.js",
            "/Shared/js/ModalMaster/modal.js"
        };

        if (isIndex) {
            scripts.Add("https://player.vimeo.com/api/player.js");
            scripts.Add("/js/5.0000/slide/slide.js");
            scripts.Add("/js/5.0000/slide/components/slide.a11y.js");
            scripts.Add("/js/5.0000/slide/components/slide.thumbnails.js");
            scripts.Add("/js/5.0000/carousel.js");
            scripts.Add("/js/5.0000/index.js");
        }

        if (isLandingPage) {
            scripts.Add("/js/5.0000/landing-page.js");
            scripts.Add("/js/9.0000/cart.js");
            scripts.Add("/js/8.0000/countdown-discount.js");
        }

        if (isPaymentPage || isLandingPage) {
            var lightboxScript = SettingsManager.ContextSettings["FrameworkJS/CSS.DtmStyle.Lightbox.Script", string.Empty];

            if (!string.IsNullOrEmpty(lightboxScript))
            {
                scripts.Add(lightboxScript);
            }
        }

        if (isPaymentPage) {
            scripts.Add("/js/5.0000/checkout.js");
        }

        if (isProcessPayment)
        {

            scripts.Add("/Shared/facebox/facebox.js");

        }

        foreach (var script in scripts)
        {
            var resource = String.Format(url, script, v);
            %>
            <script defer src="<%= resource %>"></script>
            <%
        }
    }
%>