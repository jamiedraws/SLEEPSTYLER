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
                title = "Sun Joe® Detergent Trio";
                copy = @"
                <p>Contains 1 quart of each of the following:</p>
                <ul class=""list"">
                    <li>ULTRA-CONCENTRATE: All Purpose Cleaner + Degreaser</li>
                    <li>AUTO FOAM: Specially formulated to clean and shine your car’s exterior</li>
                    <li>HOUSE + DECK WASH: Concentrated all-purpose cleaner to revive your deck + the exterior of your home</li>
                </ul>";
                picture = string.Format(
                    pictureTemplate, 
                    "contain--square", 
                    "cleaning-bottle-pack.jpg", 
                    "3 Pack of 1 Quart All Purpose Cleaner, Auto Foam, and Deck Wash");

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
                    "turbo-nozzle-replacement.jpg", 
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