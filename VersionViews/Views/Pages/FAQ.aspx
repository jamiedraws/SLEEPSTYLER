<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
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
%>

<main aria-labelledby="main-title" class="view">
		<div id="main" class="view__anchor"></div>
		<div class="view__in">
			<div class="copy copy--article">
			<h2 id="main-title" class="reveal-offscreen">Frequenty Asked Questions</h2>

			<ul class="copy__cards" aria-label="FAQ" itemscope itemtype="https://schema.org/FAQPage">

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ1" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">What is the <%= productName %>?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>The <%= productName %> is a superior electric pressure washer that combines power, performance and versatility.  It packs a powerful punch generating up to 2200 PSI and 1.65 GPM to tackle a variety of cleaning tasks including homes, RV's, cars, trucks, boats, decks, driveways, patios, lawn equipment, and more.  You'll blast away dirt and grime with ease when you Go With Joe&reg;!</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ1" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">What are the unique features of the <%= productName %> pressure washer?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>Only the new <%= productName %> features Triple Action Power including Xtream Foaming Power that aerates detergent and shoots it out of the foam cannon up to 15 feet for maximum coverage; Xtream Cleaning Power from four quick-connect nozzles with spray patterns that range from pin-point jet to fan-spray to tackle any cleaning challenge; and Xtream Rinsing Power with up to 2200 PSI and 1.65 gallons per minute to rinse all the dirt away! </p>
							<p>With the <%= productName %> you'll get over 30 times the cleaning power of a standard garden hose, while actually saving on water! It also features Total Stop System (TSS) technology, which gives you power when you need it, and only when you need it, to extend motor life and save on electricity. This easy-to-use, home pressure washer is built with professional grade quality including a stainless-steel lance with solid brass fittings and a heavy-duty, steel-reinforced 20-foot hose - the same construction you'd find in commercial gas-powered pressure washers.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ2" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">How does the SPX3000 XTREAM differ from the original SPX3000 model that is sold at retail?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>The original Sun Joe SPX3000 Pressure Washer has been a popular product for years but does not have the same upgraded features that come with the newly designed Sun Joe Xtream model.  The SPX3000 Xtream delivers more power (2200 PSI Max), a superior build for enhanced durability including full-size brass fittings, all-metal connections, and a stainless steel lance plus a built-in foamer soap cannon for enhanced cleaning. This exclusive SPX3000 Xtream TV offer also comes packed with our best-selling accessories, including a wheel & rim brush, feather bristle utility brush, and an extended warranty for a total coverage of 3 years.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ3" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">What comes with the <%= productName %> TV offer?  </span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>The <%= productName %> comes with an onboard detergent foam cannon, 4 Quick-Connect spray tips, a 20-foot steel-reinforced high-pressure hose, a 35-foot power cord with GFCI protection; a stainless-steel lance with solid brass fittings and Sun Joe's 2-year warranty.  With today's special TV offer, you'll also get a wheel & rim brush and a handy utility bristle brush FREE plus an additional 1-year warranty to give you a full 3-years of total product protection.  We're even including FREE shipping!</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ4" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">How does the Money Back Guarantee work?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>We want you to be completely satisfied with your purchase. If you're not satisfied for any reason, our return policy allows you to send back your Sun Joe SPX3000 XTREAM within 30 days of the date you received the package for a refund of the purchase price minus a Return Label fee (the Return Label Fee is calculated by UPS). If an item needs to be exchanged or replaced due to a product defect, no Return Label fee will be deducted. Once we receive your return, Snow Joe, LLC (&ldquo;Snow Joe&rdquo;) will credit your original method of payment.</p>
							<p>If you have additional questions or would like further instructions on how to return your product, please contact Customer Service at <a id="faq-4-customer-service-email" href="tel:<%= customerServiceNumber %>"><%= customerServiceNumber %></a> <%= hoursOfService %> or email us at <a id="faq-4-customer-service-email" href="mailto:<%= customerServiceEmail %>"><%= customerServiceEmail %></a>.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ5" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">Can I find this same offer at retail?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>No, this Sun Joe SPX3000 Xtream offer cannot be found at retail as it is exclusive to TV and only available directly from Sun Joe.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ6" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">What detergents should I use with my pressure washer?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>Sun Joe offers a variety of detergents depending on your specific needs.  For general household cleaning, we recommend our House and Deck Wash All-Purpose Cleaner.  For a deeper clean, you'll love our Heavy Duty All-Purpose Cleaner & Degreaser. We also offer a Car Wash Soap and Cleaner to help keep your vehicles clean. All of these detergents are available in a 3-quart ultra-concentrate starter pack to add to your order today.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ7" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">Can I use disinfectants as detergent with my pressure washer?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>Provided your pressure washer has a stand-alone, detachable foam cannon, as is the case with the <%= productName %>, you can pour disinfectant, virucide, or other cleaning/sanitizing solutions into this foam cannon and use it to sanitize surfaces prior to rinsing them with your pressure washer. </p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ8" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">What type of extension cord should I use with my SPX3000 Xtream pressure washer?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>Any outdoor-rated 14 AWG (or larger gauge) extension cord up to 25-feet in length is able to be used in combination with the onboard power cable for maximum portability.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ9" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">What is PSI and GPM and how do they relate to a pressure washer's performance?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>A pressure washer's cleaning efficiency is a combined measure of the PSI (pounds per square inch) and the GPM (gallons per minute). PSI refers to the amount of cleaning pressure that the pressure washer can generate, the &ldquo;dirt-scouring&rdquo; action, and the GPM refers to the amount of water that is flowing from the unit, the &ldquo;rinsing&rdquo; action. The SPX3000 Xtream is an ideal pressure washing system that achieves top-rated marks on both of these performance indicators to effectively scour away deep-seated dirt with 2200 PSI max and effectively rinse it away with up to 1.65 GPM of water flow. </p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ10" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">How many washes can my <%= productName %> handle?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>The <%= productName %> will deliver over 300 hours of continuous runtime. With an average usage time of 15 minutes, this equates to over 400 washes!</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ11" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">What kind of pump and motor does the unit have?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>Your <%= productName %> uses a 13-amp universal motor with a wobble-plate piston pump.</p>
							<p>New technology in universal motor construction means unparalleled performance and efficiency - your pressure washer will last longer, run quieter, and work cooler than those with traditional motors.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ12" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">What size thread/length is the pressure hose?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>Your <%= productName %> is equipped with a 1/4-Inch x 20-Foot high pressure hose with M22 female quick-screw fittings on both sides.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ13" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">How much does the <%= productName %> weigh / Is it easy to maneuver?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>The <%= productName %> weighs less than 30 pounds when fully assembled with accessories on-board and features heavy-duty wheels to easily move from place to place.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ14" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">What does the <%= productName %> warranty cover / How long is the warranty?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>Sun Joe warrants new, genuine, powered and non-powered Products to be free from defects in material or workmanship when used for ordinary household use for a period of two years from the date of purchase by the original, end-user purchaser when purchased from Sun Joe or from one of Sun Joe's authorized sellers with proof of purchase.  With this exclusive TV offer, Sun Joe has extended the warranty by one year so your coverage period is now a full three (3) years.</p>
							<p>If your Product does not work or there's an issue with a specific part that is covered by the terms of this Warranty, Snow Joe will elect to (1) send you a free replacement part, (2) replace the Product with a new or comparable product at no charge, or (3) repair the Product. How cool is that!</p>
							<p>When you Go With Joe&reg;, you're not just buying a warranty; you're buying total peace of mind to know that you can rely on our top-notch tools, top-tier customer support, complete product coverage + no hassle return policy.</p>
						</div>
					</div>
				</li>

                <%
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
                %>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ15" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">How can I contact your customer service?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>You can reach our customer support team by calling <a id="faq-15-customer-service-number" href="tel:<%= customerServiceNumber %>"><%= customerServiceNumber %></a> <%= hoursOfService %>. You can also email us at <a id="faq-15-customer-service-email" href="mailto:<%= customerServiceEmail %>"><%= customerServiceEmail %></a>.</p>
						    <%= callToOrderLink %>
                        </div>
					</div>
				</li>

				<% if (!String.IsNullOrEmpty(affirmVideoTutorial))
                    {
                        affirmVideoTutorial = affirmVideoTutorial.Replace("autoplay=1", "autoplay=0");
                    %>
				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">How do I checkout with Affirm?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<div class="center-margin" style="--arp: 474/266;" data-src-iframe="<%= affirmVideoTutorial %>" data-attr='{ "id" : "affirmVideoTutorial", "frameborder" : "0", "webkitallowfullscreen" : "true", "mozallowfullscreen" : "true", "allowfullscreen" : "true", "width" : "1028", "height" : "576" }'>
								<noscript>
									<iframe id="affirmVideoTutorial" class="center-margin" src="<%= affirmVideoTutorial %>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
								</noscript>
							</div>
                        </div>
					</div>
				</li>
				<% } %>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ16" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">How do I assemble my <%= productName %>?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<div class="center-margin" style="--arp: 474/266;" data-src-iframe="https://player.vimeo.com/video/426245921?autoplay=0&title=0&byline=0&portrait=0" data-attr='{ "id" : "faq-16-video", "frameborder" : "0", "webkitallowfullscreen" : "true", "mozallowfullscreen" : "true", "allowfullscreen" : "true", "width" : "1028", "height" : "576" }'>
								<noscript>
									<iframe id="player" class="center-margin" src="https://player.vimeo.com/video/426245921?autoplay=0&title=0&byline=0&portrait=0" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
								</noscript>
							</div>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button id="FAQ17" class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">What is the model number included in this offer?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>The model number is SPX3000-XT1.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">Where is Sun Joe based?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>Sun Joe is based in the USA with corporate headquarters, fulfillment/distribution centers and customer support centers in North Jersey.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">How and from where will the Sun Joe Xtream ship?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>Your Sun Joe Xtream (Model: SPX3000-XT1) will ship out with free priority same-day shipping from one of our distribution centers in New Jersey via UPS, FedEx, or USPS, depending on your location. Your package should arrive within 7 business days. You will receive shipping and order confirmations via email to easily track your package.
							</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">Is there a parent company, or is Sun Joe affiliated with any other brands?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<p>The parent company is Snow Joe, LLC, which includes Snow Joe, Sun Joe and Aqua Joe brands. The Snow Joe company was founded in 2004 and is headquartered in Carlstadt, NJ.</p>
						</div>
					</div>
				</li>

				<li class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
					<button class="card__item card__tab">
						<div class="card__title">
							<span itemprop="name">How can I best utilize the 4 Quick-Connect nozzles that come with the <%= productName %>?</span>
							<span class="card__corner">
								<span class="card__icon"></span>
							</span>
						</div>
					</button>
					<div itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer" class="card__item card__content">
						<div itemprop="text" class="card__copy">
							<picture style="--arp:1/1;--arp-max:1000px" data-src-img="/images/nozzles.jpg">
								<noscript>
									<img src="/images/nozzles.jpg" alt="4 quick-connect spray tips included">
								</noscript>
							</picture>
						</div>
					</div>
				</li>

			</ul>
		</div>
	</div>
</main>

</asp:Content>