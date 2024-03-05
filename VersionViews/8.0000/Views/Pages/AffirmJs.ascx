<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var isSandbox = Dtm.Framework.ClientSites.SettingsManager.ContextSettings["Affirm.IsSandbox", false];
    var affirmApiKey = isSandbox ?  SettingsManager.ContextSettings["Affirm.SandboxPublicKey", string.Empty] : SettingsManager.ContextSettings["Affirm.PublicKey", string.Empty];
    var affirmScript = String.Format("https://cdn1{0}.affirm.com/js/v2/affirm.js", isSandbox ? "-sandbox" : string.Empty);
    var videoTutorial = ViewData["videoTutorial"] as string ?? SettingsManager.ContextSettings["Affirm.UI.VideoTutorial--UI--", string.Empty];
    var usingVideoTutorial = !String.IsNullOrEmpty(videoTutorial);
    var asyncInit = ViewData["asyncInit"] as bool? ?? false;

%>

<% if (!String.IsNullOrEmpty(affirmApiKey)) { %> 
<!-- Affirm -->
<script>
 _affirm_config = {
   public_api_key:  "<%= affirmApiKey %>",
   script:          "<%= affirmScript %>"
    };
    const initAffirmJs = function () {
        return (function (l, g, m, e, a, f, b) { var d, c = l[m] || {}, h = document.createElement(f), n = document.getElementsByTagName(f)[0], k = function (a, b, c) { return function () { a[b]._.push([c, arguments]) } }; c[e] = k(c, e, "set"); d = c[e]; c[a] = {}; c[a]._ = []; d._ = []; c[a][b] = k(c, a, b); a = 0; for (b = "set add save post open empty reset on off trigger ready setProduct".split(" "); a < b.length; a++)d[b[a]] = k(c, e, b[a]); a = 0; for (b = ["get", "token", "url", "items"]; a < b.length; a++)d[b[a]] = function () { }; h.defer = !0; h.id = "affirmJs"; h.src = g[f]; n.parentNode.insertBefore(h, n); delete g[f]; d(g); l[m] = c })(window,_affirm_config,"affirm","checkout","ui","script","ready");
        // Use your live public API Key and https://cdn1.affirm.com/js/v2/affirm.js script to point to Affirm production environment.
    };

    <% if (!asyncInit) { %>
    initAffirmJs();
    <% } %>

registerEvent("SummaryCartUpdated", function () {
    if ("affirm" in window) {
        affirm.ui.refresh();
    }
});

<% if (usingVideoTutorial) { %>
    (function (global) {
        const hasFancybox = function () {
            return "jQuery" in global && "fancybox" in jQuery;
        };

        const nodeListToArray = function (nodelist) {
            return "from" in Array ? Array.from(nodelist) : Array.prototype.slice.call(nodelist);
        };

        const displayAffirmTutorialLinks = function () {
            if (hasFancybox()) {
                const links = nodeListToArray(document.querySelectorAll(".affirm__video"));
                links.forEach(function (link) {
                    link.classList.add("affirm__video--is-ready");
                    link.removeAttribute("style");
                });
            }
        };

        addEventListener("load", displayAffirmTutorialLinks);
    })(window);
<% } %>
</script>
<!-- End Affirm -->
<style>
    .affirm__logo-inline {
        margin: 0 0.2em;
        }

    .affirm .affirm__logo-inline,
    .affirm .affirm__logo-inline > img {
        display: inline-block;
        max-width: 3.25em;
        }

    .affirm__link {
            text-decoration: underline;
        } 

    .affirm-checkout--is-hidden {
        opacity: 0;
            pointer-events: none;
            max-height: 0;
        }

    .affirm-checkout {
        background: none;
            -webkit-appearance: none;
        border: none;
        display: inline-block;
        padding: 0;
        position: relative;
        }

    .affirm-checkout > img {
        display: block;
        }

    .affirm-checkout > img:first-child {
        position: relative;
            z-index: 1;
        transition: opacity 250ms ease-in-out;
        }

    .affirm-checkout:hover > img:first-child,
    .affirm-checkout:focus > img:first-child {
        opacity: 0;
        }

    .affirm-checkout > img:not(:first-child) {
        position: absolute;
        top: 0;
        }

    <% if (usingVideoTutorial) {  %>
        .affirm__video {
            opacity: 0;
            pointer-events: none;
        }  
                       
        .affirm__video--is-ready {
            transition: opacity .3s ease-in-out;
            opacity: 1;
            pointer-events: all;
        }
    <% } %>
</style>
<% } %>