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
            Question = string.Format("What is the {0}?", productName),
            Answer = string.Format(@"<p>The {0} is a superior electric pressure washer that combines power, performance and versatility.  It packs a powerful punch generating up to 2200 PSI and 1.65 GPM to tackle a variety of cleaning tasks including homes, RV's, cars, trucks, boats, decks, driveways, patios, lawn equipment, and more.  You'll blast away dirt and grime with ease when you Go With Joe&reg;!</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 2,
            Question = string.Format("What are the unique features of the {0} pressure washer?", productName),
            Answer = string.Format(@"
            <p>Only the new {0} features Triple Action Power including Xtream Foaming Power that aerates detergent and shoots it out of the foam cannon up to 15 feet for maximum coverage; Xtream Cleaning Power from four quick-connect nozzles with spray patterns that range from pin-point jet to fan-spray to tackle any cleaning challenge; and Xtream Rinsing Power with up to 2200 PSI and 1.65 gallons per minute to rinse all the dirt away! </p>
			<p>With the {0} you'll get over 30 times the cleaning power of a standard garden hose, while actually saving on water! It also features Total Stop System (TSS) technology, which gives you power when you need it, and only when you need it, to extend motor life and save on electricity. This easy-to-use, home pressure washer is built with professional grade quality including a stainless-steel lance with solid brass fittings and a heavy-duty, steel-reinforced 20-foot hose - the same construction you'd find in commercial gas-powered pressure washers.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 3,
            Question = "How does the SPX3000 XTREAM differ from the original SPX3000 model that is sold at retail?",
            Answer = @"<p>The original Sun Joe SPX3000 Pressure Washer has been a popular product for years but does not have the same upgraded features that come with the newly designed Sun Joe Xtream model.  The SPX3000 Xtream delivers more power (2200 PSI Max), a superior build for enhanced durability including full-size brass fittings, all-metal connections, and a stainless steel lance plus a built-in foamer soap cannon for enhanced cleaning. This exclusive SPX3000 Xtream TV offer also comes packed with our best-selling accessories, including a wheel & rim brush, feather bristle utility brush, and an extended warranty for a total coverage of 3 years.</p>"
        },
        new FAQ
        {
            DisplayRank = 4,
            Question = string.Format("What comes with the {0} TV offer?", productName),
            Answer = string.Format(@"<p>The {0} comes with an onboard detergent foam cannon, 4 Quick-Connect spray tips, a 20-foot steel-reinforced high-pressure hose, a 35-foot power cord with GFCI protection; a stainless-steel lance with solid brass fittings and Sun Joe's 2-year warranty.  With today's special TV offer, you'll also get a wheel & rim brush and a handy utility bristle brush FREE plus an additional 1-year warranty to give you a full 3-years of total product protection. We're even including FREE shipping!</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 5,
            Question = "How does the Money Back Guarantee work?",
            Answer = string.Format(@"
                <p>We want you to be completely satisfied with your purchase. If you're not satisfied for any reason, our return policy allows you to send back your Sun Joe SPX3000 XTREAM within 30 days of the date you received the package for a refund of the purchase price minus a Return Label fee (the Return Label Fee is calculated by UPS). If an item needs to be exchanged or replaced due to a product defect, no Return Label fee will be deducted. Once we receive your return, Snow Joe, LLC (&ldquo;Snow Joe&rdquo;) will credit your original method of payment.</p>
				<p>If you have additional questions or would like further instructions on how to return your product, please contact Customer Service at {0} {1} or email us at {2}.</p>", csPhoneNumberLink, hoursOfService, csEmailLink)
        },
        new FAQ
        {
            DisplayRank = 6,
            Question = "Can I find this same offer at retail?",
            Answer = @"<p>No, this Sun Joe SPX3000 Xtream offer cannot be found at retail as it is exclusive to TV and only available directly from Sun Joe.</p>"
        },
        new FAQ
        {
            DisplayRank = 7,
            Question = "What detergents should I use with my pressure washer?",
            Answer = @"<p>Sun Joe offers a variety of detergents depending on your specific needs.  For general household cleaning, we recommend our House and Deck Wash All-Purpose Cleaner.  For a deeper clean, you'll love our Heavy Duty All-Purpose Cleaner & Degreaser. We also offer a Car Wash Soap and Cleaner to help keep your vehicles clean. All of these detergents are available in a 3-quart ultra-concentrate starter pack to add to your order today.</p>"
        },
        new FAQ
        {
            DisplayRank = 8,
            Question = "Can I use disinfectants as detergent with my pressure washer?",
            Answer = string.Format(@"<p>Provided your pressure washer has a stand-alone, detachable foam cannon, as is the case with the {0}, you can pour disinfectant, virucide, or other cleaning/sanitizing solutions into this foam cannon and use it to sanitize surfaces prior to rinsing them with your pressure washer.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 9,
            Question = "What type of extension cord should I use with my SPX3000 Xtream pressure washer?",
            Answer = @"<p>Any outdoor-rated 14 AWG (or larger gauge) extension cord up to 25-feet in length is able to be used in combination with the onboard power cable for maximum portability.</p>"
        },
        new FAQ
        {
            DisplayRank = 10,
            Question = "What is PSI and GPM and how do they relate to a pressure washer's performance?",
            Answer = @"<p>A pressure washer's cleaning efficiency is a combined measure of the PSI (pounds per square inch) and the GPM (gallons per minute). PSI refers to the amount of cleaning pressure that the pressure washer can generate, the &ldquo;dirt-scouring&rdquo; action, and the GPM refers to the amount of water that is flowing from the unit, the &ldquo;rinsing&rdquo; action. The SPX3000 Xtream is an ideal pressure washing system that achieves top-rated marks on both of these performance indicators to effectively scour away deep-seated dirt with 2200 PSI max and effectively rinse it away with up to 1.65 GPM of water flow.</p>"
        },
        new FAQ
        {
            DisplayRank = 11,
            Question = string.Format("How many washes can my {0} handle?", productName),
            Answer = string.Format("<p>The {0} will deliver over 300 hours of continuous runtime. With an average usage time of 15 minutes, this equates to over 400 washes!</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 12,
            Question = "What kind of pump and motor does the unit have?",
            Answer = string.Format(@"
                <p>Your {0} uses a 13-amp universal motor with a wobble-plate piston pump.</p>
				<p>New technology in universal motor construction means unparalleled performance and efficiency - your pressure washer will last longer, run quieter, and work cooler than those with traditional motors.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 13,
            Question = "What size thread/length is the pressure hose?",
            Answer = string.Format("<p>Your {0} is equipped with a 1/4-Inch x 20-Foot high pressure hose with M22 female quick-screw fittings on both sides.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 14,
            Question = string.Format("How much does the {0} weigh / Is it easy to maneuver?", productName),
            Answer = string.Format("<p>The {0} weighs less than 30 pounds when fully assembled with accessories on-board and features heavy-duty wheels to easily move from place to place.</p>", productName)
        },
        new FAQ
        {
            DisplayRank = 15,
            Question = string.Format("What does the {0} warranty cover / How long is the warranty?", productName),
            Answer = @"
			    <p>Sun Joe warrants new, genuine, powered and non-powered Products to be free from defects in material or workmanship when used for ordinary household use for a period of two years from the date of purchase by the original, end-user purchaser when purchased from Sun Joe or from one of Sun Joe's authorized sellers with proof of purchase.  With this exclusive TV offer, Sun Joe has extended the warranty by one year so your coverage period is now a full three (3) years.</p>
			    <p>If your Product does not work or there's an issue with a specific part that is covered by the terms of this Warranty, Snow Joe will elect to (1) send you a free replacement part, (2) replace the Product with a new or comparable product at no charge, or (3) repair the Product. How cool is that!</p>
			    <p>When you Go With Joe&reg;, you're not just buying a warranty; you're buying total peace of mind to know that you can rely on our top-notch tools, top-tier customer support, complete product coverage + no hassle return policy.</p>"
        },
        new FAQ
        {
            DisplayRank = 16,
            Question = "How can I contact your customer service?",
            Answer = string.Format(@"
				<p>You can reach our customer support team by calling {0} {1}. You can also email us at {2}.</p> {3}", csPhoneNumberLink, hoursOfService, csEmailLink, callToOrderLink)
        },
        new FAQ
        {
            DisplayRank = 17,
            Question = "How do I checkout with Affirm?",
            Answer = string.Format(@"<div class=""contain contain--video"" data-src-iframe=""{0}"" data-attr='{{ ""id"" : ""{1}"", ""frameborder"" : ""0"", ""webkitallowfullscreen"" : ""true"", ""mozallowfullscreen"" : ""true"", ""allowfullscreen"" : ""true"", ""width"" : ""1028"", ""height"" : ""576"" }}'>
                    <noscript>
                        <iframe id=""{1}"" src=""{0}"" frameborder=""0"" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
					</noscript>
			</div>", affirmVideoTutorial, "affirmVideoTutorial")
        },
        new FAQ
        {
            DisplayRank = 18,
            Question = string.Format("How do I assemble my {0}?", productName),
            Answer = string.Format(@"
            <div class=""contain contain--video"" data-src-iframe=""{0}"" data-attr='{{ ""id"" : ""{1}"", ""frameborder"" : ""0"", ""webkitallowfullscreen"" : ""true"", ""mozallowfullscreen"" : ""true"", ""allowfullscreen"" : ""true"", ""width"" : ""1028"", ""height"" : ""576"" }}'>
                    <noscript>
                        <iframe id=""{1}"" src=""{0}"" frameborder=""0"" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
					</noscript>
			</div>", "https://player.vimeo.com/video/426245921?autoplay=0&title=0&byline=0&portrait=0", "assembleVideoTutorial")
        },
        new FAQ
        {
            DisplayRank = 19,
            Question = "What is the model number included in this offer?",
            Answer = "<p>The model number is SPX3000-XT1.</p>"
        },
        new FAQ
        {
            DisplayRank = 20,
            Question = "Where is Sun Joe based?",
            Answer = "<p>Sun Joe is based in the USA with corporate headquarters, fulfillment/distribution centers and customer support centers in North Jersey.</p>"
        },
        new FAQ
        {
            DisplayRank = 21,
            Question = "How and from where will the Sun Joe Xtream ship?",
            Answer = "<p>Your Sun Joe Xtream (Model: SPX3000-XT1) will ship out from one of our distribution centers in New Jersey via UPS, FedEx, or USPS, depending on your location. Your package should arrive within 7 business days. You will receive shipping and order confirmations via email to easily track your package.</p>"
        },
        new FAQ
        {
            DisplayRank = 22,
            Question = "Is there a parent company, or is Sun Joe affiliated with any other brands?",
            Answer = "<p>The parent company is Snow Joe, LLC, which includes Snow Joe, Sun Joe and Aqua Joe brands. The Snow Joe company was founded in 2004 and is headquartered in Carlstadt, NJ.</p>"
        },
        new FAQ
        {
            DisplayRank = 23,
            Question = "Can I make payments over the phone for $19?",
            Answer = @"<p>No, unfortunately we can only accept a single payment over the phone, which would be $199.99 plus Free Shipping. If you’d like payments as low as $19/month, you would need to go online at <a href=""Index{{Ext}}"">getsunjoe.com</a>.</p>"
        },
        new FAQ
        {
            DisplayRank = 24,
            Question = string.Format("How can I best utilize the 4 Quick-Connect nozzles that come with the {0}?", productName),
            Answer = @"
                <picture data-src-img=""/images/nozzles.jpg"" class=""contain contain--square"">
				    <noscript>
						<img src=""/images/nozzles.jpg"" alt=""4 quick-connect spray tips included"">
					</noscript>
				</picture>"
        },
        new FAQ
        {
            DisplayRank = 25,
            Question = "How come this item is cheaper on Amazon?",
            Answer = @"<p>The model featured on Amazon is our original model, the SPX3000.  The SPX3000 Xtream (model: SPX3000-XT1) that includes 2 free gifts and a 3 year extended warranty is only available direct from Sun Joe via this exclusive TV offer.</p>
            <p>The SPX3000-XT1 Sun Joe Xtream, which is featured on the show, includes several upgrades to the original base model, including:</p>
            <ul class=""copy"">
                <li>More power (Xtream generates 2200 PSI max versus 2030 PSI max on the base model)</li>
                <li>Enhanced durability (stainless steel lance with solid brass fittings, all metal connections, 20 ft steel-reinforced high pressure hose)</li>
                <li>Quick-connect, detachable foam cannon on the Xtream provides more cleaning versatility (allows you to use any sort of soap including disinfectant since it doesn’t cycle through the machine; plus, it aerates the detergent and shoots it up to 15 feet for maximum coverage, unlike the SPX3000 which has built-in detergent canisters that do not foam the detergent and you must be careful not to use disinfectant since it does cycle through machine)</li>
                <li>Special Savings (a combined value of over $220): 2 free brushes, premium 3 year warranty, free shipping, plus an additional $100 off the retail price of $299.99</li>
            </ul>
            "
        },
        new FAQ
        {
            DisplayRank = 26,
            Question = "How Large is the head on the Deck and Patio Cleaning attachment?",
            Answer = @"<p>The Sun Joe Surface, Deck and Patio cleaning attachment is equipped with a 10-inch head for faster cleaning.</p>"
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