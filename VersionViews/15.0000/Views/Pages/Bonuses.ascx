<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<%
    var id = ViewData["id"] as string ?? "product1";
    var include = ViewData["include"] as string[] ?? new string[]{ };

    var pictureTemplate = @"
    <span class=""bonuses__img"">
        <picture 
            class=""contain {0}"" 
            role=""presentation""
            aria-hidden=""true""
            data-src-img=""/images/{1}"" 
            data-attr='{{ ""alt"" : ""{2}"" }}'>
        </picture>
    </span>
    <span class=""bonuses__caption"">{2}</span>";

    var labelTemplate = string.Format(@"
        <label for=""{0}"" class=""bonuses__item"">{1}</label>",
    id, pictureTemplate);

    var linkTemplate = string.Format(@"
        <button 
            type=""button"" 
            id=""{0}-{2}"" 
            class=""bonuses__item bonuses__button link-on-fancybox"" 
            data-fancybox 
            data-type=""ajax"" 
            data-src=""/BonusInfo?code={2}"">
            {1}
            <span class=""bonuses__link"">Learn More</span>
        </button>",
    id, pictureTemplate, "{3}");

    var listTemplate = string.Empty;

    listTemplate += string.Format(
        labelTemplate, 
        "contain--brush-badge", 
        "badge-wheel-rim-brush.jpg", 
        "Wheel &amp; Rim Brush");

    listTemplate += string.Format(
        labelTemplate, 
        "contain--brush-badge", 
        "badge-bristle-brush.jpg", 
        "Utility Brush");

    listTemplate += string.Format(
        labelTemplate, 
        "contain--shipping", 
        "free-shipping.png", 
        "Free Shipping");

    listTemplate += string.Format(
        labelTemplate, 
        "contain--warranty", 
        "badge-warranty.jpg", 
        "3-Year Warranty");

    if (include.Contains("most-popular"))
    {
        listTemplate += string.Format(
            linkTemplate, 
            "contain--square", 
            "auto-snow-foam-trio.jpg", 
            "3 Pack of 1 Quart Auto Snow Foam (Pineapple, Coconut, Orange Vanilla)",
            "TRIO");

        listTemplate += string.Format(
            linkTemplate, 
            "contain--square", 
            "turbo-nozzle-replacement.jpg", 
            "Turbo Spray Nozzle",
            "NOZZLE");
    }

    if (include.Contains("best-value"))
    {
        listTemplate += string.Format(
            linkTemplate, 
            "contain--square", 
            "gutter-lance.jpg", 
            "9-Foot Sky Reach Lance With Gutter Cleaning Attachment",
            "LANCE");
    }

    var outputHTML = string.Format(@"<span class=""bonuses"">{0}</span>", listTemplate);
%>
<%= outputHTML %>