<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
  .underline {
    text-decoration: underline;
  }
</style>

<main aria-labelledby="main-title" class="view">
    <div id="main" class="view__anchor"></div>
    <div class="view__in">
        <div class="copy copy--article">
          <h2 id="main-title" class="reveal-offscreen">Terms of Use</h2>

          <p>
            Effective Date: June 1, 2020
          </p>

          <p>
            By using this Site, you represent and warrant that: (1) all information you submit to us is truthful and accurate; (2) you are at least 18 years of age; and (3) your use of the Site does not and will not violate any applicable law or regulation. When you use this Site, you acknowledge your acceptance of these terms of use (&ldquo;Terms&rdquo;). If you do not agree with these Terms, please do not use the Site. This Terms is subject to change without notice. Your use of the Site may be terminated without warning if we believe you are in violation of any of these conditions.
          </p>

          <p>
            <span class="underline">Mobile Alerts Terms & Conditions.</span> For all alerts, 1 msg/query, Message & Data rates may apply. Available on participating carriers only. View Snow Joe + Sun Joe Mobile Alerts Terms and Conditions by clicking here. To stop receiving alerts, text STOP to 29691 any time. For questions call <a href="tel:<%= SettingsManager.ContextSettings["CustomerService.PhoneNumber", "1-866-766-9563"] %>"><%= SettingsManager.ContextSettings["CustomerService.PhoneNumber", "1-866-766-9563"] %></a>. You expressly understand and agree that your use of the mobile alerts service provided by Snow Joe + Sun Joe is solely at your own risk. The service is provided "as is" and "as available." Snow Joe + Sun Joe accepts no responsibility and shall not be liable for any consequences that are alleged to have occurred through your use, or misuse, of the service. Snow Joe + Sun Joe is not liable for any damage to your computer system or mobile phone that results from the use of the service.
          </p>

          <p>
            <span class="underline">Products, Content and Specifications.</span> All features, content, specifications, products and prices of products and services described or depicted on the Site, are subject to change at any time without notice. We make all reasonable efforts to accurately display the attributes of our products, including the applicable sizes, designs and colors; however, the actual color you see will depend on your computer system, and we cannot guarantee that your computer will accurately display such colors. The inclusion of any products or services on the Site and the pricing for such items at a particular time does not imply or warrant that these products or services will be available at any time and at the posted price. It is your responsibility to ascertain and obey all applicable local, state, federal and international laws (including minimum age requirements) in regard to the possession, use and sale of any item purchased from the Site. By placing an order, you represent that the products ordered will be used only in a lawful manner.
          </p>

          <p>
            <span class="underline">Orders and Price.</span> The information on this site does not constitute a binding offer to sell products described on the Site. We reserve the right at any time after receipt of your order to accept or decline your order or any portion thereof, in our sole discretion, even after your receipt of an order confirmation or after your credit card has been charged. The prices displayed on the Site are quoted in US dollars and are intended to be valid and effective only in the United States. In the event a product is listed at an incorrect price, we have the right to refuse or cancel orders placed for the product listed at the incorrect price, regardless of whether the order has been confirmed or your credit card charged. If your credit card has already been charged for the purchase and your order is cancelled, we will issue a credit to your credit card account.
          </p>

          <p>
            <span class="underline">Shipping Limitations.</span> When an order is placed, it will be shipped to an address designated by the purchaser as long as that shipping address is compliant with the shipping restrictions contained on the Site. All purchases from the Site are made pursuant to a shipment contract. As a result, risk of loss and title for items purchased from the Site pass to you upon delivery of the items to the carrier. You are responsible for filing any claims with carriers for damaged and/or lost shipments.
          </p>

          <p>
            <span class="underline">Promotions and Availability.</span> All promotions offered by Snow Joe + Sun Joe apply to purchases shipped within the United States unless otherwise noted. Snow Joe + Sun Joe offers services and products in various parts of the world. Snow Joe + Sun Joe may refer to certain services or products which are not available worldwide without specifically limiting the offers as such. Such reference does not imply that Snow Joe + Sun Joe intends to offer such service or products in all countries.
          </p>

          <p>
            <span class="underline">Limited Warranty Policy Statement.</span> When you register your powered or non-powered Product with Snow Joe + Sun Joe at <a href="https://www.snowjoe.com/register" target="_blank">https://www.snowjoe.com/register</a>, you will receive an additional 90 days of warranty coverage. In addition, you will have the option of purchasing extended warranty coverage beyond the standard 2-year manufacturer's warranty. You may choose from +1 year, +2 years or +3 years of extended coverage by selecting the bronze, silver or gold protection shields (where applicable) for up to 3 years, 4 years and 5 years of total Product protection. Additional charges apply.
          </p>

          <p>
            This Warranty does not apply if the Product has been used commercially or for non-household or rental applications. This Warranty also does not apply if the Product was purchased from an unauthorized seller. This Warranty also does not cover cosmetic changes that do not affect performance. Wearing parts like belts, augers, chains and tines are not covered under this Warranty, and can be purchased at snowjoe.com or by calling <a href="tel:<%= SettingsManager.ContextSettings["CustomerService.PhoneNumber", "888-444-9073"] %>"><%= SettingsManager.ContextSettings["CustomerService.PhoneNumber", "888-444-9073"] %></a>.
          </p>

          <p>
            <span class="underline">Accuracy of Information.</span> We attempt to ensure that information on the Site is complete, accurate and current. Despite our efforts, information on the Site may occasionally be inaccurate, incomplete or out of date. We make no representation that any information on the Site is accurate, complete and current. For example, products (or particular sizes, colors or styles of products) included on the Site may be unavailable, may have different attributes than those listed, or may actually carry a different price than that stated on the Site. In addition, we may make changes in information about price and availability without notice. While it is our practice to confirm orders by email, the receipt of an email order confirmation does not constitute our acceptance of an order or our confirmation of an offer to sell a product or service. We reserve the right, without prior notice, to limit the order quantity on any product or service and/or to refuse service to any customer. We also may require verification of information prior to the acceptance and/or shipment of any order.
          </p>

          <p>
            <span class="underline">Use of the Site.</span> The design of the Site and all text, graphics, information, content, and other material displayed on or that can be downloaded from the Site are owned or licensed by Snow Joe + Sun Joe, protected by copyright, trademark and other laws and may not be used except as permitted in these Terms and Conditions or with prior written permission of the owner of such material. We own or license all content on this Site. You may not modify the information or materials displayed on or that can be downloaded from the Site in any way or reproduce or publicly display, perform, or distribute or otherwise use any such information or materials for any public or commercial purpose. Any unauthorized use of any such information or materials may violate copyright laws, trademark laws, laws of privacy and publicity, and other laws and regulations.
          </p>

          <p>
            <span class="underline">Trademarks.</span> Certain trademarks, trade names, service marks and logos used or displayed on the Site are registered and unregistered trademarks, trade names and service marks of Snow Joe + Sun Joe. and its affiliates and subsidiaries. Other trademarks, trade names and service marks used or displayed on the Site are the registered and unregistered trademarks, trade names and service marks of their respective owners. Nothing contained on the Site grants or should be construed as granting, by implication, estoppel, or otherwise, any license or right to use any trademarks, trade names, service marks or logos displayed on the Site without the written permission of Snow Joe + Sun Joe or such other owner.
          </p>

          <p>
            <span class="underline">Linking to the Site.</span> Creating or maintaining any link from another Site to any page on the Site without our prior written permission is prohibited. Running or displaying the Site or any information or material displayed on the Site in frames or through similar means on another Site without our prior written permission is prohibited. Any permitted links to the Site must comply will all applicable laws, rule and regulations.
          </p>

          <p>
            <span class="underline">Third Party Links.</span> From time to time, the Site may contain links to Sites that are not owned, operated or controlled by Snow Joe + Sun Joe or its affiliates and/or subsidiaries. All such links are provided solely as a convenience to you. If you use these links, you will leave the Site. Neither we nor any of our respective affiliates or subsidiaries are responsible for any content, materials or other information located on or accessible from any other Site. Neither we nor any of our respective affiliates or subsidiaries endorse, guarantee, or make any representations or warranties regarding any other Sites, or any content, materials or other information located or accessible from any other Sites, or the results that you may obtain from using any other Sites. If you decide to access any other Sites linked to or from the Site, you do so entirely at your own risk.
          </p>

          <p>
            <span class="underline">Inappropriate Material.</span> You are prohibited from posting or transmitting any unlawful, threatening, defamatory, libelous, obscene, pornographic or profane material or any material that could constitute or encourage conduct that would be considered a criminal offense or give rise to civil liability, or otherwise violate any law. In addition to any remedies that we may have at law or in equity, if we determine, in our sole discretion, that you have violated or are likely to violate the foregoing prohibitions, we may take any action we deem necessary to cure or prevent the violation, including without limitation, the immediate removal of the related materials from the Site. We will fully cooperate with any law enforcement authorities or court order or subpoena requesting or directing us to disclose the identity of anyone posting such materials.
          </p>

          <p>
            <span class="underline">User Information.</span> Any material, information, suggestions, ideas, concepts, know-how, techniques, questions, comments or other communication you transmit or post to the Site in any manner ("User Communications") is and will be considered non-confidential and non-proprietary. We and our respective affiliates and subsidiaries and our or their designees may use any or all User Communications for any purpose whatsoever, including, without limitation, reproduction, transmission, disclosure, publication, broadcast, development, manufacturing and/or marketing in any manner whatsoever for any or all commercial or non-commercial purposes. We may, but are not obligated to, monitor or review any User Communications. We will have no obligation to use, return, review, or respond to any User Communications. We will have no liability related to the content of any such User Communications, whether or not arising under the laws of copyright, libel, privacy, obscenity, or otherwise. We retain the right to remove any or all User Communications that includes any material we deem inappropriate or unacceptable.
          </p>

          <p>
            <span class="underline">Unsolicited Product Ideas.</span> Snow Joe + Sun Joe does not solicit (and our product teams will not review) ideas for new products from third parties for our business (including product and advertising ideas) and will not incur any liability as a result of any between an unsolicited product idea and a Snow Joe + Sun Joe product or advertisement. By submitting a product idea, you waive any right to compensation of any type for the idea. Also, please know that you are responsible for the material that you submit, and that you, not Snow Joe + Sun Joe, have full responsibility for the message including its reliability, originality and copyright. By submitting a product idea, you agree to waive any and all rights to materials and ideas submitted to us, and your submission will become the exclusive property of Snow Joe + Sun Joe. This provision does not apply to the content of a consumer review with respect to Snow Joe + Sun Joe's intellectual property rights in such consumer review.
          </p>

          <p>
            DISCLAIMERS. YOUR USE OF THE SITE IS AT YOUR RISK. THE INFORMATION, MATERIALS AND SERVICES PROVIDED ON OR THROUGH THE SITE ARE PROVIDED "AS IS" WITHOUT ANY WARRANTIES OF ANY KIND INCLUDING WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT OF INTELLECTUAL PROPERTY. NEITHER SNOW JOE NOR ANY OF ITS RESPECTIVE AFFILIATES OR SUBSIDIARIES WARRANT THE ACCURACY OR COMPLETENESS OF THE INFORMATION, MATERIALS OR SERVICES PROVIDED ON OR THROUGH THE SITE. THE INFORMATION, MATERIALS AND SERVICES PROVIDED ON OR THROUGH THIS SITE MAY BE OUT OF DATE, AND SNOW JOE NOR ANY OF THEIR RESPECTIVE AFFILIATES OR SUBSIDIARIES MAKES ANY COMMITMENT OR ASSUMES ANY DUTY TO UPDATE SUCH INFORMATION, MATERIALS OR SERVICES. THE FOREGOING EXCLUSIONS OF IMPLIED WARRANTIES DO NOT APPLY TO THE EXTENT PROHIBITED BY LAW. PLEASE REFER TO YOUR LOCAL LAWS FOR ANY SUCH PROHIBITIONS.
          </p>

          <p>
            EXCEPT AS STATED IN OUR CUSTOMER PROMISE, ALL PRODUCTS AND SERVICES PURCHASED ON OR THROUGH THE SITE ARE SUBJECT ONLY TO ANY APPLICABLE WARRANTIES OF THEIR RESPECTIVE MANUFACTURERS, DISTRIBUTORS AND SUPPLIERS, IF ANY. TO THE FULLEST EXTENT PERMISSIBLE BY APPLICABLE LAW, SNOW JOE HEREBY DISCLAIMS ALL WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, ANY IMPLIED WARRANTIES WITH RESPECT TO THE PRODUCTS AND SERVICES LISTED OR PURCHASED ON OR THROUGH THE SITE. WITHOUT LIMITING THE GENERALITY OF THE FOREGOING, WE HEREBY EXPRESSLY DISCLAIM ALL LIABILITY FOR PRODUCT DEFECT OR FAILURE, CLAIMS THAT ARE DUE TO NORMAL WEAR, PRODUCT MISUSE, ABUSE, PRODUCT MODIFICATION, IMPROPER PRODUCT SELECTION, NON-COMPLIANCE WITH ANY CODES, OR MISAPPROPRIATION. WE MAKE NO WARRANTIES TO THOSE DEFINED AS "CONSUMERS" IN THE MAGNUSON-MOSS WARRANTY-FEDERAL TRADE COMMISSION IMPROVEMENTS ACT. THE FOREGOING EXCLUSIONS OF IMPLIED WARRANTIES DO NOT APPLY TO THE EXTENT PROHIBITED BY LAW. PLEASE REFER TO YOUR LOCAL LAWS FOR ANY SUCH PROHIBITIONS.
          </p>

          <p>
            LIMITATIONS OF LIABILITY. Snow Joe + Sun Joe assumes no responsibility, and will not be liable for, any damages to, or viruses that may infect, your computer, telecommunication equipment, or other property caused by or arising from your access to, use of, or browsing the Site, or your downloading of any information or materials from the Site. IN NO EVENT WILL SNOW JOE OR ANY OF ITS OFFICERS, DIRECTORS, EMPLOYEES, SHAREHOLDERS, AFFILIATES, SUBSIDIARIES, AGENTS, SUCCESSORS OR ASSIGNS, NOR ANY PARTY INVOLVED IN THE CREATION, PRODUCTION, TRANSMISSION OF THE SITE INCLUDING, BUT NOT LIMITED TO INFORMATION COLLECTED THROUGH OPERATION OF THE SITE, BE LIABLE TO YOU OR ANYONE ELSE FOR ANY INDIRECT, SPECIAL, PUNITIVE, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, WITHOUT LIMITATION, THOSE RESULTING FROM LOST PROFITS, LOST DATA OR BUSINESS INTERRUPTION) ARISING OUT OF THE USE, INABILITY TO USE, OR THE RESULTS OF USE OF THE SITE, ANY SITES LINKED TO THE SITE, OR THE MATERIALS, INFORMATION OR SERVICES CONTAINED ON ANY OR ALL SUCH SITES, WHETHER BASED ON WARRANTY, CONTRACT, TORT OR ANY OTHER LEGAL THEORY AND WHETHER OR NOT ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. THE FOREGOING LIMITATIONS OF LIABILITY DO NOT APPLY TO THE EXTENT PROHIBITED BY LAW. PLEASE REFER TO YOUR LOCAL LAWS FOR ANY SUCH PROHIBITIONS.
          </p>

          <p>
            IN THE EVENT OF ANY PROBLEM WITH THE SITE OR ANY CONTENT, YOU AGREE THAT YOUR SOLE REMEDY IS TO CEASE USING THE SITE. IN THE EVENT OF ANY PROBLEM WITH THE PRODUCTS OR SERVICES THAT YOU HAVE PURCHASED ON OR THROUGH THE SITE, EXCEPT AS STATED IN OUR CUSTOMER PROMISE YOU AGREE THAT YOUR SOLE REMEDY, IF ANY, IS FROM THE MANUFACTURER OF SUCH PRODUCTS OR SUPPLIER OF SUCH SERVICES, IN ACCORDANCE WITH SUCH MANUFACTURER'S OR SUPPLIER'S WARRANTY, OR TO SEEK A RETURN AND REFUND FOR SUCH PRODUCT OR SERVICES IN ACCORDANCE WITH THE RETURNS POLICY POSTED ON THE SITE.
          </p>

          <p>
            <span class="underline">Revisions to these Terms and Conditions.</span> These Terms and Conditions may be revised at any time and from time to time by updating this posting. You should visit this page from time to time to review the then current Terms and Conditions because they are binding on you. Certain provisions of these Terms and Conditions may be superseded by legal notices or terms located on particular pages of the Site.
          </p>

          <p>
            <span class="underline">Choice of Law.</span> These Terms and Conditions supersede any other agreement between you and Snow Joe + Sun Joe to the extent necessary to resolve any inconsistency or ambiguity between them. These Terms and Conditions will be governed by and construed in accordance with the laws of the state of New Jersey, without giving effect to any principles of conflicts of laws.
          </p>

          <p>
            <span class="underline">Arbitration and Class Action Waiver.</span> PLEASE READ THIS SECTION CAREFULLY - IT AFFECTS YOUR LEGAL RIGHTS AND GOVERNS HOW YOU AND SNOW JOE + SUN JOE CAN BRING CLAIMS AGAINST EACH OTHER.  THIS SECTION WILL, WITH LIMITED EXCEPTION, REQUIRE YOU AND SNOW JOE + SUN JOE TO SUBMIT CLAIMS AGAINST EACH OTHER TO BINDING AND FINAL ARBITRATION ON AN INDIVIDUAL BASIS.  THIS MEANS THAT YOU WILL NOT BE ABLE TO BRING A CLASS, COLLECTIVE, OR REPRESENTATIVE LAWSUIT IN A COURT OF LAW BEFORE A JUDGE OR JURY CONCERNING ANY DISPUTE THAT MAY ARISE WHICH IS COVERED BY THE ARBITRATION AGREEMENT AND ARE INSTEAD AGREEING TO SUBMIT ANY SUCH DISPUTE SOLELY ON YOUR OWN BEHALF TO AN IMPARTIAL ARBITRATOR.
          </p>

					<p><span class="underline">Agreement to Arbitrate.</span> You and Snow Joe + Sun Joe mutually agree to forego the delay and expense of using a court of law and choose instead to benefit from the speedy, economical, and impartial dispute resolution procedure of using binding arbitration for any &ldquo;Covered Claims&rdquo; (as defined below) that arise between You and Snow Joe + Sun Joe, its related and affiliated companies, and/or any current or former employee, officer, or director of Snow Joe + Sun Joe or any related or affiliated company.  You and Snow Joe + Sun Joe agree that this Section 4 Arbitration and Class Action Waiver is governed by the Federal Arbitration Act, 9 U.S.C. § 1 et seq., and will survive even after these Terms and Conditions and any services terminate.  Any revision to or termination of the Terms and Conditions that modify or terminate this Arbitration and Class Action Waiver shall not apply to a pending arbitration, to any claim that accrued prior to the modification or termination, or to any claim that the asserting party knew about prior to the modification or termination, except as may be required by applicable law.
					</p>

					<p><span class="underline">Claims Subject to Arbitration.</span> The &ldquo;Covered Claims&rdquo; include any and all controversies, disputes, disagreements,  and claims arising out of, or relating to, these Terms and Conditions (including its enforcement, breach, performance, interpretation, validity, or termination), or Your access to and/or use of the Site, or the provision of content, services, and/or technology on or through the Site to the fullest extent allowed by law.
					</p>

					<p><span class="underline">Class Action Waiver.</span> Except as otherwise required under applicable law, You and Snow Joe + Sun Joe agree to arbitrate any Covered Claims only on an individual basis and hereby waive any right to bring, participate in, or receive money or any other relief from any representative, class, or collective proceeding  (&ldquo;Class Action Waiver&rdquo;).   No party may bring a claim on behalf of other individuals, and no arbitrator hearing any claim under these Terms of Use may: (a) without the consent of all parties, combine more than one individual's claim or claims into a single case; (b) order, require, participate in, or facilitate production of class-wide contact information or notification of others of potential claims; or (c) arbitrate any form of a class, collective, or representative proceeding.
					</p>

					<p><span class="underline">Arbitrability Determinations.</span> If a party violates the agreement to arbitrate by commencing an action asserting a Covered Claim in a court of law, then the court (and not an arbitrator) shall have the authority to resolve any disputes about the interpretation, formation, existence, enforceability, validity, and scope of the this Arbitration and Class Action Waiver.  If a party complies with the agreement to arbitrate and files for arbitration without filing a complaint in a court of law, then the arbitrator shall have the authority to resolve any disputes about the interpretation of this Arbitration and Class Action Waiver for purposes of discovery or the merits of the underlying claim, but shall have no authority to resolve any disputes about the formation, existence, enforceability, or validity of this Arbitration and Class Action Waiver, including the Class Action Waiver.
					</p>

					<p><span class="underline">Arbitration Rules, Procedures, and Costs.</span> To initiate arbitration, the party desiring to pursue a legal dispute must prepare a written demand setting forth the claim(s) and deliver the written demand within the applicable statute of limitations period by hand or first class mail to the representatives of the other party (who are set forth below as the appropriate recipients of any notices). You and Snow Joe + Sun Joe agree that the arbitration shall be administered by the Judicial Arbitration and Mediation Services (&ldquo;JAMS&rdquo;) before a single arbitrator mutually agreed upon by the parties, and if the parties cannot agree within thirty (30) days after names of potential arbitrators have been proposed, then by a single arbitrator who is chosen by JAMS.  Except to the extent that they are modified by the rules below, the JAMS Streamlined Arbitration Rules & Procedures that are in effect at the time of the filing of the demand (and that are available at <a href="https://www.jamsadr.com/rules-streamlined-arbitration/" target="_blank">https://www.jamsadr.com/rules-streamlined-arbitration/</a>) will apply.
					</p>

					<p>The parties agree that the applicable JAMS rules are modified as follows:</p>

					<p>(a) Any arbitrator must be neutral as to all parties.  Standards for the recusal of an arbitrator shall be the same standards under which trial judges are recused under New Jersey law.</p>

					<p>(b) No party is entitled to its attorneys' fees, except as may be awarded in a matter authorized by and consistent with applicable law.</p>

					<p>(c) All discovery shall be subject to any and all objections available under FRCP 26(b).  Each party shall avoid broad or widespread collection, search, and production of documents, including electronically stored information (&ldquo;ESI&rdquo;).  If a compelling need is demonstrated by the requesting party, the production shall: (i) be narrowly tailored in scope; (ii) only come from sources that are reasonably accessible without undue burden or cost; and (iii) be produced in a searchable format, if possible without undue burden or cost, and which is usable by the receiving party and convenient and economical for the producing party.  Where the costs and burdens of the requested discovery outweigh its likely benefit, considering the needs of the case, the amount in controversy, and the importance of the discovery in resolving the issues, the arbitrator shall deny such requests or order production on condition that the requesting party advance to the producing party the reasonable costs involved in making the production, subject to the allocation of costs in the final award.</p>

					<p>(d) The arbitrator shall have the authority to award the same damages and other relief that would have been available in court pursuant to the law governing the Covered Claim(s).</p>

					<p>(e) Either party shall have the right to file motions to dismiss and motions for summary judgment/adjudication. </p>

					<p>(f) The arbitrator shall have the authority to issue an award or partial award without conducting a hearing on the grounds that there is no claim on which relief can be granted or that there is no genuine issue of material fact to resolve at a hearing.</p>

					<p>(g) The Federal Rules of Evidence shall apply to all arbitration proceedings.</p>

					<p>(h) For discovery purposes only, an arbitrator may consolidate claims filed by multiple individuals, each on their own behalf, in a single arbitration proceeding, or may conduct a joint hearing for efficiency purposes, so long as the arbitrator does not (a) certify (conditionally or otherwise) a collective, class, or representative action that includes individuals who have not themselves already submitted their own individual claims, or (b) authorize the issuance of notice of the arbitration to individuals on the grounds that the arbitrator or any party believes there are other individuals who are similarly situated to or share commonality with a party to the arbitration.</p>

					<p>(i) The arbitrator must issue a decision in writing, setting forth in summary form the reasons for the arbitrator's determination and the legal basis therefore.</p>

					<p>(j) The arbitrator's authority shall be limited to deciding the case submitted by the parties to the arbitration. Therefore, no decision by any arbitrator shall serve as precedent in other arbitrations except to preclude the same claim from being re-arbitrated between the same parties.</p>

					<p>(k) The parties may settle any dispute on a mutual basis without involvement of the arbitrator.</p>

					<p>(l) You will pay the first $250, and Snow Joe + Sun Joe will pay all other filing, administrative, or hearing fees.  If Snow Joe + Sun Joe initiates arbitration, Snow Joe + Sun Joe will pay all filing, administrative, and hearing fees.  Regardless of which party initiates arbitration, You will remain responsible for Your attorneys' fees and costs unless the law governing the Covered Claim provides for an award of attorneys' fees and costs and the arbitrator determines as part of the arbitration award that You may recover a certain amount of attorneys' fees and costs.</p>

					<p>If a Covered Claim is brought seeking public injunctive relief and a court determines that the restrictions in this Arbitration and Class Action Waiver or elsewhere prohibiting the arbitrator from awarding relief on behalf of third parties are unenforceable with respect to a Covered Claim (and that determination becomes final after all appeals have been exhausted), the claim for public injunctive relief will be determined in court and any individual claims seeking monetary relief will be arbitrated. In such a case the parties will request that the court stay the claim for public injunctive relief until the arbitration award pertaining to individual relief has been entered in court. In no event will a claim for public injunctive relief be arbitrated.</p>

					<p>If any term or condition in this Arbitration and Class Action Waiver is determined to be unenforceable or in conflict with a mandatory provision of applicable law, it shall be construed to incorporate any mandatory provision, or the unenforceable or conflicting term or condition shall be automatically severed and the remainder of this Arbitration and Class Action Waiver shall not be affected.  Provided, however, that if the Class Action Waiver is found to be unenforceable, then any claim brought on a class, collective, or representative action basis shall be adjudicated exclusively in the state and federal courts located in the City of Carlstadt and Bergen County, New Jersey, which shall be the exclusive forum for such claims.  You waive any and all objections to the exercise of jurisdiction over You by such courts and to venue in such courts.</p>

					<p><span class="underline">Termination.</span> You or we may suspend or terminate your account or your use of the Site at any time, for any reason or for no reason. You are personally liable for any orders placed or charges incurred through your account prior to termination. We reserve the right to change, suspend, or discontinue all or any aspect of the Site at any time without notice.</p>
          <p>
            <span class="underline">Additional Assistance.</span> If you do not understand any of the foregoing Terms and Conditions or if you have any questions or comments, we invite you to complete our Customer Support Form at <a href="https://www.snowjoe.com/pages/contact" target="_blank">https://www.snowjoe.com/pages/contact</a> or contact us by phone at <a href="tel:1-866-766-9563">1866.SNOW.JOE</a>.
          </p>

        </div>
    </div>
</main>

</asp:Content>