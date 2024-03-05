<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>


<%
    var accountId = (ViewData["ID"] as string) ?? string.Empty;
    var widgetSDK = (ViewData["USEWIDGETSDK"] as string) ?? "false";
    bool useWidgetSDK;
    var completeStatuses = new[] { 2, 3, 11, 12 };
    var isConversion = !DtmContext.Page.IsStartPageType
        && DtmContext.Order != null
        && completeStatuses.Contains(DtmContext.Order.OrderStatusId);
    var asyncInit =  TempData["asyncInit"] as bool?;

%>

<!-- Begin Impression -->
<style>
    /* allows button and container declarations to inherit from .lp scope */
    .lp-window-root [class*="button"],
    .lp-window-root [class*="container"] {
        padding: 0;
        border: none;
        box-shadow: none;
        background: inherit;
        text-transform: inherit;
        font-weight: inherit;
        text-decoration: inherit;
    }

    /* allows button contaiment to inherit from .lp scope */
    .lp-window-root [class*="button"] {
        display: inherit;
    }

        /* allows background to inherit from .lp scope */
        .lp-window-root [class*="button"]:hover,
        .lp-window-root [class*="button"]:focus {
            background: inherit;
        }

    /* fixes icon alignment and prevents icons from rendering invisible */
    .dtm .lp-window-root * {
        max-width: none;
    }

    @media print {
        .LPMcontainer {
            display: none !important;
        }
    }
</style>
<script type="text/javascript"> 
    const livePersonInit = function () {
        window.lpTag = window.lpTag || {}, 'undefined' == typeof window.lpTag._tagCount ? (window.lpTag = {
            wl: lpTag.wl || null,
            scp: lpTag.scp || null,
            site: '<%=accountId%>' || '',
            section: lpTag.section || '',
            tagletSection: lpTag.tagletSection || null,
            autoStart: lpTag.autoStart !== !1,
            ovr: lpTag.ovr || {},
            _v: '1.10.0',
            _tagCount: 1,
            protocol: 'https:',
            events: {
                bind: function (t, e, i) {
                    lpTag.defer(function () {
                        lpTag.events.bind(t, e, i)
                    }, 0)
                },
                trigger: function (t, e, i) {
                    lpTag.defer(function () {
                        lpTag.events.trigger(t, e, i)
                    }, 1)
                }
            },
            defer: function (t, e) {
                0 === e ? (this._defB = this._defB || [], this._defB.push(t)) : 1 === e ? (this._defT = this._defT || [], this._defT.push(t)) : (this._defL = this._defL || [], this._defL.push(t))
            },
            load: function (t, e, i) {
                var n = this;
                setTimeout(function () {
                    n._load(t, e, i)
                }, 0)
            },
            _load: function (t, e, i) {
                var n = t;
                t || (n = this.protocol + '//' + (this.ovr && this.ovr.domain ? this.ovr.domain : 'lptag.liveperson.net') + '/tag/tag.js?site=' + this.site);
                var o = document.createElement('script');
                o.setAttribute('charset', e ? e : 'UTF-8'), i && o.setAttribute('id', i), o.setAttribute('src', n), document.getElementsByTagName('head').item(0).appendChild(o)
            },
            init: function () {
                this._timing = this._timing || {}, this._timing.start = (new Date).getTime();
                var t = this;
                window.attachEvent ? window.attachEvent('onload', function () {
                    t._domReady('domReady')
                }) : (window.addEventListener('DOMContentLoaded', function () {
                    t._domReady('contReady')
                }, !1), window.addEventListener('load', function () {
                    t._domReady('domReady')
                }, !1)), 'undefined' === typeof window._lptStop && this.load()
            },
            start: function () {
                this.autoStart = !0
            },
            _domReady: function (t) {
                this.isDom || (this.isDom = !0, this.events.trigger('LPT', 'DOM_READY', {
                    t: t
                })), this._timing[t] = (new Date).getTime()
            },
            vars: lpTag.vars || [],
            dbs: lpTag.dbs || [],
            ctn: lpTag.ctn || [],
            sdes: lpTag.sdes || [],
            hooks: lpTag.hooks || [],
            identities: lpTag.identities || [],
            ev: lpTag.ev || []
        }, lpTag.init()) : window.lpTag._tagCount += 1;
    };

<%
    if (!asyncInit.HasValue || !asyncInit.Value)
    {
%>
    livePersonInit();
<%
    }

%>

</script>


<%if (Boolean.TryParse(widgetSDK, out useWidgetSDK) && useWidgetSDK)
    {%>

<script type="text/javascript">

    const livePersonWidgetInit = function () {

        let s = document.createElement("script");
        s.src = "https://lpcdn.lpsnmedia.net/unifiedwindow/widgetSDK.min.js";

        document.body.appendChild(s);
        
        let lpWidgetSDK = {};
        let widgetSDKAPI = {};

        (function () {
            let lookupCount = 0;
            const maxLookup = 5;

            const lookForWidgetSDK = function () {
                if (lpTag.hasOwnProperty("LPWidgetSDK")) {
                    _initWidget();
                } else if (lookupCount <= maxLookup) {
                    lookupCount += 1;
                    setTimeout(lookForWidgetSDK, 500);
                }
            };

            lookForWidgetSDK();
        })();

        function _initWidget() {
            widgetSDKAPI = lpTag.LPWidgetSDK.API;
            var bindingEvent = [widgetSDKAPI.events.CONVERSATION_INFO, widgetSDKAPI.events.MESSAGES],
                opts = { bind: {} };

            bindingEvent.forEach(function (eventName) {
                opts.bind[eventName] = { func: _onEvent, context: this };
            });

            lpWidgetSDK = lpTag.LPWidgetSDK.init(opts);
        }

        function _onEvent(eventData) {
            if (eventData && widgetSDKAPI.events.MESSAGES === eventData.type) {
                var content = eventData.data.content;
                console.log("MESSAGES data: ", eventData);
                if (content.indexOf("disposeWidget") > -1) {
                    disposeWidget();
                }
            } else if (eventData && widgetSDKAPI.events.CONVERSATION_INFO === eventData.type) {
                console.log("CONVERSATION_INFO data: ", eventData);
            }
            sendNotification("Event received!");
        }
        function sendNotification(text) {
            if (typeof text === "string") {
                lpWidgetSDK.notify({ content: text }, function (err) {
                    if (err) {
                        console.log("Error on sending notification from widget");
                    }
                });
            }
        }
        function disposeWidget() {
            lpWidgetSDK.dispose(function (data) {
                console.log("bla");
            });
        }
    };
    <%
    if (!asyncInit.HasValue || !asyncInit.Value)
    {
    %>
    livePersonWidgetInit();
    <%
    }

    %>



</script>
<%
    }%>

<!-- End Impression -->

<!-- Begin Conversion -->
<% if (isConversion)
    {
        var finalJson = new JObject();
        finalJson["type"] = "purchase";
        finalJson["total"] = DtmContext.Order.OrderTotal.ToString("#.00");
        finalJson["orderId"] = DtmContext.OrderId;

        var products = DtmContext.Order.ContextOrderItems.ToList();

        var productsArray = new JArray();

        foreach (var item in products)
        {
            var productJson = new JObject();
            var productProperties = new JObject();

            productProperties["name"] = item.Description;
            productProperties["sku"] = item.ProductSku;
            productProperties["price"] = item.Price.ToString("#.00");

            productJson["product"] = productProperties;
            productJson["quantity"] = item.Quantity;
            productsArray.Add(productJson);
        }
        var productObject = new JObject();
        productObject["products"] = productsArray;

        finalJson["cart"] = productObject;

%>
<script type="text/javascript">
    lpTag.sdes = lpTag.sdes || [];
    lpTag.sdes.push(<%=finalJson%>);
</script>

<!-- End Conversion -->
<% }
    else
    { %>
<!-- CODE: <%= ViewData["ControlId"] %> already fired. -->
<%}%>
