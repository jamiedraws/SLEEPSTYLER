<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var id = ViewData["id"] as string ?? "deal";
    var type = ViewData["type"] as string ?? string.Empty;
    var productCode = ViewData["productCode"] as string ?? string.Empty;

    var isDiscount = productCode.EndsWith("10");
    var typeIsDiscount = type == "discount";
    var typeIsCountdown = type == "countdown";
    var isMostPopular = type == "popular";
    var isBestValue = type == "value";

    var bannerText = "Limited Time Offer!";
    var bannerClasses = "banner banner--offer";

    if (isDiscount)
    {
        bannerText = "ONLINE ONLY 10% OFF TODAY!";
        bannerClasses = String.Format("{0} deal__discount", bannerClasses);
    }

    if (isMostPopular)
    {
        bannerText = "MOST POPULAR!";
        bannerClasses = String.Format("{0} deal__value", bannerClasses);
    }

    if (isBestValue)
    {
        bannerText = "BEST VALUE!";
        bannerClasses = String.Format("{0} deal__value", bannerClasses);
    }

    var isTakingOrders = SettingsManager.ContextSettings["Order.EnableOrderform", true];
%>

<% if (typeIsDiscount || isBestValue || isMostPopular) { %>
    <a href="#order" id="<%= id %>-order" class="<%= bannerClasses %>">
      <span><%= bannerText %></span>
    </a>
<% } %>

<% if (typeIsCountdown) { %>
    <%
        // set timezone to eastern standard time (EST)
        var est = TimeZoneInfo.FindSystemTimeZoneById("Eastern Standard Time");

        var currentDate = DateTime.Now;
        currentDate = TimeZoneInfo.ConvertTime(currentDate, est);

        // cut off date is set to 12/25/2020 at midnight. orders will stop after this
        var cutoffDate = new DateTime(2020, 12, 25);
        var countdownDate = cutoffDate - currentDate;

        var days = countdownDate.Days;
        var hours = countdownDate.Hours;
        var minutes = countdownDate.Minutes;
        var seconds = countdownDate.Seconds;

        var dayText = string.Empty;
        if (days > 0)
        {
            dayText = String.Format(@"<span data-days=""{0}"">{0}</span> {1},", days, days > 1 ? "days" : "day");
        }

        var hourText = string.Empty;
        if (hours > 0 || days > 0)
        {
            hourText = String.Format(@"<span data-hours=""{0}"">{0}</span> {1},", hours, hours > 1 ? "hours" : "hour");
        }

        var minuteText = string.Empty;
        if (minutes > 0 || hours > 0 || days > 0)
        {
            minuteText = String.Format(@"<span data-minutes=""{0}"">{0}</span> {1},", minutes, minutes > 1 ? "minutes" : "minute");
        }

        var secondText = string.Empty;
        if (seconds > 0 || minutes > 0 || hours > 0 || days > 0)
        {
            secondText = String.Format(@"<span data-seconds=""{0}"">{0}</span> {1}", seconds, "seconds");
        }


        // once time is out, remove the banner as navigation will go to v5 (offer no longer available)
        var isExpired = days <= 0 && hours <= 0 && minutes <= 0 && seconds <= 0;
        var countdownClass = "banner--countdown-red";
    %>
    <% if (!isExpired && isTakingOrders) { 
            var stylesheetVersion = DtmContext.Version == 3 ? "3.0000" : "1.0000";
    %>
    <link rel="stylesheet" href="/css/<%= stylesheetVersion %>/countdown.css" />
    <script defer src="/js/countdown.js"></script>
    <div class="banner banner--countdown <%= countdownClass %> countdown" data-time="<%= countdownDate %>">
        <%
            var description = String.Format("{0} {1} {2} {3}.", dayText, hourText, minuteText, secondText);
        %>
        <span><span class="own-line">HOLIDAY COUNTDOWN</span> <span class="spacer">|</span> <span class="own-line">FREE PRIORITY SAME DAY SHIPPING!</span></span> <small><%= description %></small></div>
    <% } %>
<% } %>