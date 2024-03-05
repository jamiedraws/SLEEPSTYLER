<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<%
    var modifier = ViewData["modifier"] as string ?? "product__list";
    var id = ViewData["id"] as string ?? "features-list";
    bool? applyButtons = ViewData["applyButtons"] as bool? ?? false;
    bool? applyId = ViewData["applyId"] as bool? ?? true;
    bool? applyPictures = ViewData["applyPictures"] as bool? ?? false;

    bool useButtons = applyButtons.HasValue ? applyButtons.Value : false;
    bool useId = applyId.HasValue ? applyId.Value : false;
    bool usePictures = applyPictures.HasValue ? applyPictures.Value : false;

    Tuple<string, string>[] features =
    {
        new Tuple<string, string>(
            String.Format("{0} Foaming", Brand.SHORTNAME),
            "Detergent foam cannon aerates detergent and shoots it up to 15&rsquo; to give your cleaning blast a boost"
        ),
        new Tuple<string, string>(
            String.Format("{0} Cleaning", Brand.SHORTNAME),
            String.Format("4 Quick-Connect nozzles (0&deg;, 15&deg;, 25&deg;, 40&deg;) in a range of spray patterns from pinpoint jet to fan spray tackle heavy, medium and light duty jobs <a id='{0}-nozzle' href='/images/nozzles.jpg' class='link-on-fancybox link-on-fancybox--fade'>(Click here for usage guide)</a>", id)
        ),
        new Tuple<string, string>(
            String.Format("{0} Rinsing", Brand.SHORTNAME),
            "Powerful 13 amp motor generates 2200 PSI* of maximum pressure and 1.65 GPM* of maximum flow to rinse away dirt and grime for a Sun Joe shine"
        ),
        new Tuple<string, string>(
            "TOTAL STOP SYSTEM (TSS) TECHNOLOGY",
            "Automatically shuts off both pump and power when the trigger is not engaged to save energy, prolong pump life, and ensure quieter operation when not in use"
        ),
        new Tuple<string, string>(
            "PROFESSIONAL-GRADE CONSTRUCTION",
            "20&rsquo; high-pressure hose features high-tensile, wire-reinforced tubing over a smooth inner core to minimize pressure drop and maximize performance"
        ),
        new Tuple<string, string>(
            "LEAK-PROOF PERFORMANCE",
            "Durable 34&rdquo; spray wand with stainless steel lance, solid brass fittings and all metal connections"
        ),
        new Tuple<string, string>(
            "LIGHTWEIGHT + PORTABLE",
            "Weighs just under 23 lbs and wheels easily from one dirty job to the next"
        ),
        new Tuple<string, string>(
            "EASY, EMISSION-FREE OPERATION",
            "Instantly and reliably starts by squeezing the trigger; includes 35&rsquo; power cord with GFCI protection and convenient on/off switch "
        ),
    };

    if (features != null && features.Any())
    {

        if (useButtons)
        {
            int buttonId = features.Length;
            for (int i = 1; i <= buttonId; i++)
            { %>
            <button id="feature-button-<%= i %>" data-title="<%= i %>" aria-labelledby="feature-<%= i %>"></button>
            <%
                    }
                }
                else if (usePictures)
                {
                    int pictures = features.Length;
                    for (int i = 1; i <= pictures; i++)
                    {
                        %>
                        <picture data-src-img="/images/product-walkthrough/pw-<%= i %>.jpg" aria-labelledby="feature-<%= i %>" style="--arp:392/388;--arp-max:196px">
                        </picture>
                        <%
                    }
                }
                else
                {
                    int featureId = 1;
            %>
            <ul class="<%= modifier %>">
            <%
                foreach (Tuple<string, string> feature in features)
                {
                    if (useId)
                    {
                    %>
                <li id="feature-<%= featureId %>">
                    <span><strong><%= feature.Item1 %>:</strong> <%= feature.Item2 %></span>
                </li>
                    <%
                    } 
                    else
                    {
                    %>
                <li>
                    <span><strong><%= feature.Item1 %>:</strong> <%= feature.Item2 %></span>
                </li>
                    <%
                    }
                    featureId++;
                } 
                %>
            </ul>
            <%
        }
    }
%>