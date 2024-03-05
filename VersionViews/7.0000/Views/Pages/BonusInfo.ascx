<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<article class="section__in copy article article--image-text">
<% 
    var bonusCode = ViewData["bonusCode"] as string ?? string.Empty;
    var pictureTemplate = @"
    <picture 
        class=""contain {0}"">
        <img src=""/images/{1}"" alt=""{2}"">
    </picture>";

    if (!String.IsNullOrEmpty(bonusCode))
    {
        var title = string.Empty;
        var copy = string.Empty;
        var picture = string.Empty;

        switch (bonusCode)
        {
            case "TRIO":
                title = "Sun Joe® Auto Snow Foam Trio";
                copy = @"
                <ul class=""list"">
                    <li>DETERGENT TRIO — Includes a 3-pack of Sun Joe's Snow Foam Auto Wash in scents pineapple, coconut, and orange-vanilla</li>
                    <li>CONCENTRATED FORMULA — 1 quart per bottle of powerful fast-foaming formula</li>
                    <li>BIODEGRADABLE — eco-friendly for use outside of the home, this bleach-free formula won't damage surrounding plant life and vegetation</li>
                    <li>Designed for use with Sun Joe pressure washers + foamer cannon accessories</li>
                </ul>";
                picture = string.Format(
                    pictureTemplate, 
                    "contain--square", 
                    "auto-snow-foam-trio.jpg", 
                    "3 Pack of 1 Quart Auto Snow Foam (Pineapple, Coconut, Orange Vanilla)");

                break;

            case "NOZZLE":
                title = "Sun Joe® Turbo Spray Nozzle";
                copy = @"
                <ul class=""list"">
                    <li>UNIVERSAL: Fits all pressure washers with standard 1/4-inch quick connect spray lances</li>
                    <li>EFFICIENT: Cleans up to 40% faster than a standard nozzle</li>
                    <li>POWERFUL: Powerful rotating spray destroys gunk + grime</li>
                    <li>VERSATILE: Cleans concrete, brick, vinyl surfaces</li>
                </ul>";
                picture = string.Format(
                    pictureTemplate, 
                    "contain--square", 
                    "turbo-nozzle.jpg", 
                    "Turbo Spray Nozzle");

                break;

            case "LANCE":
                title = "Sun Joe® 9-Foot Sky Lance";
                copy = @"
                <ul class=""list"">
                    <li>4-PIECE ACCESSORY KIT: 120° Gutter Adapter, 30° Angled Adapter, Hose Adapter + comfortable shoulder strap</li>
                    <li>VERASTILE: Ideal for cleaning gutters, roofs, siding, soffits and other hard to reach places around the home + RVs</li>
                    <li>LIGHTWEIGHT: Weighs in at just 5.5 lbs</li>
                    <li>ADJUSTABLE: 6-FT or 9FT extension wand </li>
                    <li>UNIVERSAL: For use with most pressure washers rated 1800 PSI – 4000 PSI</li>
                </ul>";
                picture = string.Format(
                    pictureTemplate, 
                    "contain--square", 
                    "gutter-lance.jpg", 
                    "9-Foot Sky Reach Lance With Gutter Cleaning Attachment");

                break;
        }
        %>
        <div class="article__group">
            <%= picture %>

            <div class="article__copy">
                <h2><%= title %></h2>
                <%= copy %>
            </div>
        </div>
        <%
    }
%>
</article>