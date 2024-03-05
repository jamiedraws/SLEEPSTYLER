<%@ Page Language="C#" MasterPageFile="~/VersionViews/5.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    var customerServiceNumber = SettingsManager.ContextSettings["CustomerService.PhoneNumber", "1-866-766-9563"];
    var customerServiceEmail = SettingsManager.ContextSettings["CustomerService.EmailAddress"];
    var hoursOfService = SettingsManager.ContextSettings["CustomerService.HoursOfService"];
    var refundDays = SettingsManager.ContextSettings["CustomerService.RefundDays"];
    var productName = SettingsManager.ContextSettings["Label.ProductName"];
    var brandName = SettingsManager.ContextSettings["Label.BrandName"];
    var affirmVideoTutorial = SettingsManager.ContextSettings["Affirm.UI.videoTutorial--UI--", string.Empty];

    var csPhoneNumberLink = string.Format(@"<a href=""tel:{0}"">{0}</a>", customerServiceNumber);
    var csEmailLink = string.Format(@"<a href=""mailto:{0}"">{0}</a>", customerServiceEmail);

    var callToOrderGroup = new Dictionary<string, string>()
    {
        { "www.sunjoextream.com", "800-205-7678" }
    };

    var callToOrderLink = string.Empty;

    foreach (var callToOrder in callToOrderGroup)
    {
        if (String.Equals(callToOrder.Key, DtmContext.Domain.Domain, StringComparison.InvariantCultureIgnoreCase))
        {
            callToOrderLink = String.Format("<p>To place an order by phone, call <a id=\"faq-15-call-to-order\" href=\"tel:{0}\">{0}</a>.</p>", callToOrder.Value);
        }
    }

    var faqList = new List<FAQ>
    {
        new FAQ
        {
            DisplayRank = 1,
            Question = string.Format("Does my {0} pressure washer have a downstream or upstream detergent injector?", productName),
            Answer = string.Format(@"<p>Your {0} has a <strong>downstream</strong> chemical injector, installed on the outlet (discharge) side of the pump, that applies detergent with the dedicated soap nozzle.
                The advantage of the downstream injector is that the chemicals cannot cause damage to the pump system. In upstream injectors, the chemicals run through the pump, causing the pump seals to wear out.
                </p>", productName)
        },
        new FAQ
        {
            DisplayRank = 2,
            Question = string.Format("Why isn't my unit reaching high pressure?", productName),
            Answer = string.Format(@"<p>If the diameter of the garden hose is too small, then you must replace with a 1&rdquo; (25mm) or 5/8&rdquo; (16mm) garden hose. If water supply is restricted, check the garden hose for kinks, leaks, and blockage. If there is not enough inlet water supply, you must open the water source fully. If the spray nozzle is not powerful enough, then select a higher-pressure nozzle. If the pump is sucking air, Check that hoses and fittings are airtight. Turn &ldquo;OFF&rdquo; machine, and purge pump by squeezing trigger gun until a steady flow of water emerges through the nozzle.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 3,
            Question = "Can my unit be connected to a portable water supply?",
            Answer = @"<p>Your pressure washer must be connected to a main water supply with a main pressure system providing a constant inlet pressure up to but not exceeding 0.7MPa (7 bars, also equal to 100 psi). Portable water supplies, tanks, and pumps use regulators that cannot provide a constant pressure to your unit, and this will cause the motor to wear prematurely, or even break entirely.</p>"
        },
        new FAQ
        {
            DisplayRank = 4,
            Question = string.Format("What is the life expectancy of the pump found in my unit?", productName),
            Answer = string.Format(@"<p>Your pressure washer unit uses a wobble-plate piston pump with an average life expectancy of 300 to 500 hours of usage.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 5,
            Question = "What size thread/length is the pressure hose?",
            Answer = string.Format(@"
                <p>Your {0} is equipped with a 1/4-Inch x 20-Foot-high pressure hose with M22 female quick-screw fittings on both sides.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 6,
            Question = "Why is there no detergent coming out?",
            Answer = @"<p>The detergent container may be empty, in that case add more detergent. You may need to check connections if the detergent bottle or suction tube are not properly connected. If the detergent is too thick, you must dilute it with water. If the detergent tube is clogged, then remove the obstruction or run distilled white vinegar though the detergent tank. If the discharge nozzle is obstructed, you must blow out or remove the debris with the needle clean out tool. If you are using a third-party nozzle, use the black soap nozzle found in our Sun Joe Electric Power Washer Quick-Connect Spray Tip Set.</p>"
        },
        new FAQ
        {
            DisplayRank = 7,
            Question = "I just got my pressure washer, and I am missing the needle clean out tool.",
            Answer = @"<p>The needle clean out tool included with your unit is taped to the back of your owner's manual. In the event that it is not, please contact our customer service team at <a href='tel:18667669563'>1-866-SNOW-JOE (1-866-766-9563)</a> (Mon-Fri, 9AM-7PM; Sat and Sun 9AM-4PM EST) to further assist you.
                </p>"
        },
        new FAQ
        {
            DisplayRank = 8,
            Question = "Why does the motor buzz and fail to run?",
            Answer = string.Format(@"<p>If the supply voltage is below minimum, allow only the pressure washer to run on this circuit. If the system has residual pressure, turn the unit &ldquo;OFF,&rdquo; squeeze the trigger on spray wand to release pressure, then turn the unit back &ldquo;ON.&rdquo; If there is voltage loss due to the extension cord, then unplug any extension cords attached and plug the unit directly into the outlet. If you continue to have issues, please reach out to our &ldquo;link did not work&rdquo;</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 9,
            Question = "My pressure washer is leaking from where the garden hose goes into the pressure washer.",
            Answer = @"<p>The original adapter can wear over time, and this causes leakage. Also, the end of the garden hose may become imperfect, and this will compromise the seal. The best solution would be to upgrade to a heavy-duty brass adapter, available on our website &ldquo;link did not work&rdquo;</p>"
        },
        new FAQ
        {
            DisplayRank = 10,
            Question = "How do I winterize my pressure washer?",
            Answer = @"<p>You can protect your pressure washer from winter damage by following these steps:</p>
                <ol>
                    <li>Disconnect all water connections.</li>
                    <li>Turn on the machine for a few seconds, until any remaining water exits the pump. Turn off immediately.</li>
                    <li>Store the machine and accessories in a room that does not reach freezing temperatures. Do not store near a furnace or other sources of intense heat as it may dry out the pump seals.</li>
                </ol>
                "
        },
        new FAQ
        {
            DisplayRank = 11,
            Question = string.Format("Why does the motor not start?", productName),
            Answer = string.Format("<p>If the On/Off switch is in the &ldquo;OFF&rdquo; position, turn it to the &ldquo;ON&rdquo; position. Make sure the power cord is plugged in. If the extension cord is too long, not the proper gauge, or damaged, then use a unit without an extension cord, or replace it with a 25&rsquo; (7.6m) or shorter, 1 4/3 gauge or thicker, outdoor-rated extension cord. If the electrical outlet does not supply the adequate amount of power, try a different outlet. If the pressure washer GFCI circuit breaker is tripped, reset the GFCI and retry the unit.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 12,
            Question = "Why does the pressure vary from high to low?",
            Answer = string.Format(@"
                <p>If there is not enough inlet water supply, turn the water on fully and check the garden hose for kinks, leaks, or blockage. If the pump is sucking air, check that hoses and fittings are airtight, turn off the machine, and purge pump by squeezing the trigger gun until a steady flow of water emerges through the nozzle. If the water inlet filter is clogged, remove the filter, and rinse it in warm water. If the discharge nozzle is obstructed, blow out or remove debris with the needle clean out tool. If the gun, hose or power nozzle become calcified, run distilled white vinegar through the detergent tank, or soak the calcified part with the vinegar.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 13,
            Question = "Why does the garden hose connection adapter leak?",
            Answer = string.Format("<p>If there are loose fittings, tighten the fittings (over-tightening may damage the adapter). If there are missing/worn rubber washers inside the adapter, then insert new washers.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 14,
            Question = string.Format("Can I use an aftermarket spray nozzle with the quick connect wand?", productName),
            Answer = string.Format("<p>Your {0} uses a universal 1/4&rdquo; (F) Quick Connect spray wand that is compatible with most 1/4&rdquo; (M) Quick Connect spray nozzles.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 15,
            Question = string.Format("What kind of pump and motor does my unit have?", productName),
            Answer = string.Format("<p>Your {0} uses a <strong>universal</strong> motor with a <strong>wobble-plate</strong> piston pump.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 16,
            Question = "Are there recommended detergents to use with my pressure washer?",
            Answer = string.Format(@"
				<p>When cleaning with a pressure washer, some cleaning tasks can be solved with water alone, but for most tasks, cleaning with detergent allows for more effective dirt removal.</p><p>Use only detergents specifically designed for pressure washers, such as the Assorted Detergent 3 Pack available in this offer.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 17,
            Question = string.Format(@"What size screws do I need to assemble my {0}?", productName),
            Answer = string.Format(@"<p>Your {0} is equipped with 4 large screws and 2 small screws.</p>
                <ul>
                    <li>4- 4.8*25 for the handle</li>
                    <li>1- 4.8*20 for the hose hook</li>
                    <li>1-4.8*20 for the lower gun holder</li>
                </ul>
                </p>", productName)
        },
        new FAQ
        {
            DisplayRank = 18,
            Question = string.Format("What is the orifice size of the nozzles included with my pressure washer?", productName),
            Answer = string.Format(@"<p>The orifice size for each nozzle is 1.0 mm, suitable for interchangeable use between the SPX9000, SPX4000, and {0} series pressure washers. The detergent nozzle size is from 3.2-3.8 mm.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 19,
            Question = string.Format("How many washes can my {0} handle?", productName),
            Answer = "<p>The total lifetime of the pump is 300-500 hrs. The consecutive hours usage is 100 hrs.Depending on minute use we determine that:</p><ul><li>(6000 min)x(1 wash/30min) = 200 consecutive washes (assuming each wash lasts 30 min),</li><li>(6000 min)x(1 wash/20 min) = 300 consecutive washes (assuming each wash lasts 20 min),</li><li>(6000 min)x(1 wash/15min) = 400 consecutive washes (assuming each wash lasts 15 min)</li></ul>"
        },
        new FAQ
        {
            DisplayRank = 20,
            Question = "Can I use disinfectants as detergent with my pressure washer?",
            Answer = "<p>You can use disinfectants as detergent with your pressure washer so long as the PH of the detergent is neutral. Using a non-PH-neutral detergent with your pressure washer can cause certain parts of your washer to corrode faster.</p>"
        },
        new FAQ
        {
            DisplayRank = 21,
            Question = "How do I checkout with Affirm?",
            Answer = string.Format(@"<div class=""contain contain--video"" data-src-iframe=""{0}"" data-attr='{{ ""id"" : ""{1}"", ""frameborder"" : ""0"", ""webkitallowfullscreen"" : ""true"", ""mozallowfullscreen"" : ""true"", ""allowfullscreen"" : ""true"", ""width"" : ""1028"", ""height"" : ""576"" }}'>
                    <noscript>
                        <iframe id=""{1}"" src=""{0}"" frameborder=""0"" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
					</noscript>
			</div>", affirmVideoTutorial, "affirmVideoTutorial")
        }
    };
%>

<main aria-labelledby="main-title" class="view section">
    <div id="main" class="view__anchor"></div>
    <div class="view__in section__in">
        <h2 id="main-title" class="section__block">Frequenty Asked Questions</h2>

        <ul aria-label="FAQ" class="section__block bg bg--light" itemscope itemtype="https://schema.org/FAQPage">
            <% foreach (var faq in faqList) { %>
            <li class="card expando" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
                <button id="FAQ<%= faq.DisplayRank %>" class="card__item card__tab expando__toggle">
                    <div class="card__title">
                        <span itemprop="name"><%= faq.Question %></span>
                        <span class="card__corner">
                            <span class="card__icon expando__icon"></span>
                        </span>
                    </div>
                </button>
                <div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content expando__content">
                    <div itemprop="text" class="card__copy expando__copy">
                        <%
                            var answer = faq.Answer;

                            answer = answer.Replace("{{Domain}}", DtmContext.Domain.Domain).Replace("{{Ext}}", DtmContext.ApplicationExtension);
                            
                            Response.Write(answer);
                        %>
                    </div>
                </div>
            </li>
            <% } %>
        </ul>
    </div>
</main>

<noscript>
    <style>
        .card__content {
          visibility: visible;
          max-height: none;
        }

        .card__copy {
          opacity: 1;
        }

        .card__icon expando__icon {
          display: none;
        }
    </style>
</noscript>

</asp:Content>