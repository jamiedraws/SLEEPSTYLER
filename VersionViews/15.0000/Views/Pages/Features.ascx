<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<%
    // config rendering options
    var classes = ViewData["classes"] as string ?? "features__list";
    var id = ViewData["id"] as string ?? "features-list";
    var applyId = ViewData["applyId"] as bool? ?? true;
    var applyList = ViewData["applyList"] as bool? ?? false;
    var applyButtons = ViewData["applyButtons"] as bool? ?? false;
    var applyPictures = ViewData["applyPictures"] as bool? ?? false;

    var featuresList = new SortedList<int, string>
    {
        {
            1, @"<strong>XTREAM FOAMING:</strong> Detergent foam cannon aerates detergent and shoots it up to 15&rsquo; to give your cleaning blast a boost"
        },
        {
            2, string.Format(@"<strong>XTREAM CLEANING:</strong> 4 Quick-Connect nozzles (0&deg;, 15&deg;, 25&deg;, 40&deg;) in a range of spray patterns from pinpoint jet to fan spray tackle heavy, medium and light duty jobs <a id=""{0}-nozzle"" data-fancybox href=""/images/nozzles.jpg"" class=""link-on-fancybox link-on-fancybox--fade"">(Click here for usage guide)</a>", id)
        },
        {
            3, @"<strong>XTREAM Rinsing:</strong> Powerful 13 amp motor generates 2200 PSI* of maximum pressure and 1.65 GPM* of maximum flow to rinse away dirt and grime for a Sun Joe shine"
        },
        {
            4, @"<strong>TOTAL STOP SYSTEM (TSS) TECHNOLOGY:</strong> Automatically shuts off both pump and power when the trigger is not engaged to save energy, prolong pump life, and ensure quieter operation when not in use"
        },
        {
            5, @"<strong>PROFESSIONAL-GRADE CONSTRUCTION:</strong> 20&rsquo; high-pressure hose features high-tensile, wire-reinforced tubing over a smooth inner core to minimize pressure drop and maximize performance"
        },
        {
            6, @"<strong>LEAK-PROOF PERFORMANCE:</strong> Durable 34&rdquo; spray wand with stainless steel lance, solid brass fittings and all metal connections"
        },
        {
            7, @"<strong>LIGHTWEIGHT + PORTABLE:</strong> Weighs just under 23 lbs and wheels easily from one dirty job to the next"
        },
        {
            8, @"<strong>EASY, ELECTRIC, EMISSION-FREE OPERATION:</strong> Starts instantly and reliably by squeezing the trigger; includes 35&rsquo; power cord with GFCI protection and convenient on/off switch"
        }
    };

    if (featuresList.Any())
    {
        if (applyButtons)
        {
            var buttonTemplate = @"<button id=""feature-button-{0}"" data-title=""{0}"" aria-labelledby=""feature-{0}""></button>";

            foreach (var feature in featuresList)
            {
                var button = string.Format(buttonTemplate, feature.Key);
                %>
                <%= button %>
                <%
            }
        }

        if (applyPictures)
        {
            var pictureTemplate = @"<picture data-src-img=""/images/features/in-use-{0}.jpg"" aria-labelledby=""feature-{0}"" class=""contain contain--feature""></picture>";

            foreach (var feature in featuresList) {
                var picture = string.Format(pictureTemplate, feature.Key);
                %>
                <%= picture %>
                <%
            }
        }

        if (applyList) {
            var listTemplate = string.Empty;
            var itemTemplate = @"<li data-id=""feature-{0}""><span>{1}</span></li>";

            foreach (var feature in featuresList) {
                listTemplate += string.Format(itemTemplate, feature.Key, feature.Value);  
                            
                if (applyId) {
                    listTemplate = listTemplate.Replace("data-id", "id");
                }
            }

            listTemplate = string.Format(@"<ul class=""{0}"">{1}</ul>", classes, listTemplate);

            %>
            <%= listTemplate %>
            <%
        }
    }
%>