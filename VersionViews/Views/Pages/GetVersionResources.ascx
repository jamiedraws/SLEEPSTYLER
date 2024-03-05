<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>

<%
    var v = 33;
    var url = "{0}?v={1}";

    var preload = ViewData["preload"] as bool? ?? false;
    var defer = ViewData["defer"] as bool? ?? false;

    var isPaymentPage = DtmContext.PageCode == "PaymentForm" || DtmContext.PageCode == "ProcessPayment";
    var isIndex = DtmContext.PageCode == "Index";
    var isStartPage = DtmContext.Page.IsStartPageType;
    var isLandingPage = isStartPage && !isPaymentPage && !isIndex;
    var isReviewPage = DtmContext.PageCode == "ReviewPage";
    var isUpsell = DtmContext.Page.PageType.Equals("Upsell", StringComparison.InvariantCultureIgnoreCase) || isReviewPage;
    var isConfirmation = DtmContext.Page.PageType.Equals("Confirmation", StringComparison.InvariantCultureIgnoreCase);
    var isFAQ = DtmContext.PageCode == "FAQ";
    var version = DtmContext.Version;

    // inform browser to preload all critical resources ahead of schedule
    if (preload)
    {
        // preload critical stylesheets
        var styles = new List<string>
        {
            "/css/1.0000/header.css",
            "https://use.typekit.net/xkh1fab.css"
        };

        foreach (var style in styles)
        {
            var resource = String.Format(url, style, v);
            %>
            <link rel="preload" href="<%= resource %>" as="style">
            <%
        }

        if (isIndex) {
            if (version == 3) {
                styles.Add("/css/3.0000/index.css");
            } else {
                styles.Add("/css/1.0000/index.css");
            }
        }

        if (isLandingPage) {
            if (version == 3) {
                styles.Add("/css/3.0000/style.css");
            } else {
                styles.Add("/css/1.0000/style.css");
            }
        }

        if (!isStartPage) {
            styles.Add("/css/1.0000/upsell.css");
        }

        if (isFAQ) {
            styles.Add("/css/1.0000/faq.css");
        }

        if (isPaymentPage) {
            styles.Add("/css/default/checkout.css");
        }

        // preload critical fonts
        var fonts = new List<string>
        {
            "https://use.typekit.net/af/602e61/00000000000000003b9ad063/27/l?subset_id=2&fvd=n9&v=3",
            "https://use.typekit.net/af/72575c/00000000000000003b9af1e5/27/l?primer=7cdcb44be4a7db8877ffa5c0007b8dd865b3bbc383831fe2ea177f62257a9191&fvd=i7&v=3"
        };

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

        // preload critical images
        if (isIndex)
        {
            %>

            <%
        }
    }

    // inform browser to request resources on document parse. dispatch as critical resources
    if (!preload && !defer)
    {
        // request critical stylesheets
        var styles = new List<string>
        {
            "/css/1.0000/header.css",
            "https://use.typekit.net/xkh1fab.css"
        };

        if (isIndex) {
            if (version == 3) {
                styles.Add("/css/3.0000/index.css");
            } else {
                styles.Add("/css/1.0000/index.css");
            }
        }

        if (isLandingPage) {
            if (version == 3) {
                styles.Add("/css/3.0000/style.css");
            } else {
                styles.Add("/css/1.0000/style.css");
            }
        }

        if (!isStartPage) {
            styles.Add("/css/1.0000/upsell.css");
        }

        if (isFAQ) {
            styles.Add("/css/1.0000/faq.css");
        }

        if (isPaymentPage) {
            styles.Add("/css/default/checkout.css");
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
            "/js/app.js"
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
        var styles = new List<string>();

        if (isIndex) {
            styles.Add("/css/slide/slide.css");
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
            "/js/observer.js",
            "/js/lazy.js",
            "/js/page.js",
            "/js/nav.js"
        };

        if (isIndex) {
            scripts.Add("/js/slide/js/slide.js");
            scripts.Add("/js/slide/js/components/slide.a11y.js");
            scripts.Add("/js/slide/js/components/slide.thumbnails.js");
            scripts.Add("/js/index.js");
        }

        if (isFAQ) {
            scripts.Add("/js/card.js");
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