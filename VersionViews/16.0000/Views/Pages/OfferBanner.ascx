<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var id = ViewData["id"] as string ?? "deal";
    var type = ViewData["type"] as string ?? string.Empty;
    var productCode = ViewData["productCode"] as string ?? string.Empty;

    var isDiscount = productCode.EndsWith("DIS");
    var typeIsDiscount = type == "discount";
    var typeIsCountdown = type == "countdown";
    var isMostPopular = type == "popular";
    var isBestValue = type == "value";
    var isLaborDay = type == "labor-day";
    var isFall = type == "fall";
    var isXmasLow = type == "xmas-low";
    var isLow = type == "low";

    var bannerText = "Special Offer!";
    var bannerClasses = "banner banner--offer";

    if (isDiscount)
    {
        bannerText = @"<span>LIMITED TIME OFFER!</span>";
        bannerClasses = string.Format("{0} deal__discount", bannerClasses);
    }

    if (isMostPopular)
    {
        bannerText = "MOST POPULAR!";
        bannerClasses = string.Format("{0} deal__value", bannerClasses);
    }

    if (isBestValue)
    {
        bannerText = "BEST VALUE!";
        bannerClasses = string.Format("{0} deal__value", bannerClasses);
    }

    if (isLaborDay)
    {
        bannerText = "EXTENDED Labor Day Sale! Take An Additional 10% Off!";
        bannerClasses = string.Format("{0} banner--countdown-discount banner--offer", bannerClasses);
    }

    if (isFall)
    {
        bannerText = "Fall Into Savings! Take An Additional 10% Off!";
        bannerClasses = string.Format("{0} banner--countdown-discount banner--fall", bannerClasses);
    }

    if (isXmasLow)
    {
        bannerText = "Hurry, Lowest Price of the Year!";
        bannerClasses = String.Format("{0} banner--countdown-discount banner--xmas-low", bannerClasses);
    }

    if (isLow)
    {
        bannerText = "Hurry, Lowest Price of the Year!";
        bannerClasses = String.Format("{0} banner--countdown-discount banner--low", bannerClasses);
    }

    var isTakingOrders = SettingsManager.ContextSettings["Order.EnableOrderform", true];
%>

<% if (typeIsDiscount || isBestValue || isMostPopular || isLaborDay || isFall || isXmasLow || isLow) { %>
    <a href="#order" id="<%= id %>-order" class="<%= bannerClasses %>">
      <span class="banner__message"><%= bannerText %></span>
    </a>
<% } %>

<% if (typeIsCountdown) { %>
    <%
        var countdownDate = new TimeSpan(0, 30, 59);

        var minutes = countdownDate.Minutes;
        var seconds = countdownDate.Seconds;

        var minuteText = string.Empty;
        if (minutes > 0)
        {
            minuteText = string.Format(@"<span data-minutes data-time-live=""{0}"">{1}</span>", minutes, minutes > 1 ? "minutes" : "minute");
        }

        var secondText = string.Empty;
        if (seconds > 0 || minutes > 0)
        {
            secondText = string.Format(@"<span data-seconds data-time-live=""{0}"">{1}</span>", seconds, "seconds");
        }

        var isExpired = minutes <= 0 && seconds <= 0;
        // var cookie = HttpContext.Current.Request.Cookies.Get("_iteration");
        //var iteration = (cookie != null)
        //    ? cookie.Value : "1";
        //var bannerMessage = (iteration == "1")
        //   ? "Hurry, Additional 10% Off!"
        //   : "Need More Time? Last Chance For Additional 10% Off!";
    %>
    <% if (!isExpired && isTakingOrders) { %>
    <div class="banner banner--countdown-discount countdown" data-time="<%= countdownDate %>">
        <%
            var description = string.Format("{0} {1}", minuteText, secondText);
        %>
        <span class="banner__message countdown__message" id="bannerText">Hurry, Additional 10% Off!</span> 
        <small class="bannerTime"><%= description %></small>
    </div>
    <% } %>
<% } %>