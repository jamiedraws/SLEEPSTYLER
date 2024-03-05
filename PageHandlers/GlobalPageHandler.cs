using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Models;
using Dtm.Framework.Models.Ecommerce;


namespace SJOXTREAM.PageHandlers
{
    public class GlobalPageHandler : CommonPageHandler
    {

        #region " Overrides... "
        public override void BeginRequest(HttpRequestBase request, HttpResponseBase response, ref string pageCode)
        {
			if (DtmContext.Page.IsStartPageType)
            {
                var mainOrderItems = DtmContext.Order.OrderItems
               .Where(oi => oi.CachedProductInfo.ProductTypeId == 1)
               .Select(oi => oi.CachedProductInfo.ProductCode)
               .ToList();


                foreach (var item in mainOrderItems)
                {
                    if (item.StartsWith(AffirmPrefix))
                    {
                        // OrderManager.UpgradeProduct(item, item.Replace(AffirmPrefix, string.Empty));
                    }
                }

            }

            base.BeginRequest(request, response, ref pageCode);
        }
        public override void PostValidate(ModelStateDictionary modelState)
        {
            if (DtmContext.Page.IsStartPageType && string.IsNullOrEmpty(Order.CardType) && Order.CardType.Contains("PayPal"))
            {
                var phone = Form["PromotionalPhone"] ?? string.Empty;
                var numbersOnly = Regex.Replace(phone, "[^0-9]", string.Empty);
                if (string.IsNullOrWhiteSpace(numbersOnly) || numbersOnly.Length != 10)
                {
                    modelState.AddModelError("Form", "Please enter a valid phone number to recieve the extra 5% off");
                }
            }
            if (DtmContext.Page.IsStartPageType)
            {
                var cardType = Form["CardType"] ?? string.Empty;
                var orderType = Form["OrderType"] ?? string.Empty;

                if (orderType == "" && cardType != null)
                {
                    ViewData["CardPaymentSelection"] = "true";
                }


                //Fix for Card Type when customers take Affirm then go back LP and choose CC . 
                if (DtmContext.ShoppingCart[MainCode].Quantity > 0)
                {
                    var hasPaymentTypeOC = Order.OrderCodes.Any(x => x.Label == "PaymentType");

                    if (hasPaymentTypeOC)
                    {
                        OrderManager.AddOrderCode(Order.CardType, "PaymentType");
                    }
                }

                if (DtmContext.Version == 4)
                {
                    var hasItems = FormCart.Any(x => MainProductCodes.Contains(x.ProductCode));

                    if (!hasItems)
                    {
                        AddModelStateError("error", "Please select an offer.");
                    }
                }

                if (DtmContext.Version >= 5)
                {
                    var itemTotal = FormCart.Where(c => c.CampaignProduct.ProductTypeId == 1).Sum(c => c.Quantity);
                    if (itemTotal == 0)
                    {
                        modelState.AddModelError("Form", "Please ensure a main offer is selected");
                    }

                    var oosItems = FormCart.Where(c => c.ProductCode == "MAINMP" || c.ProductCode == "MAINBV" || c.ProductCode == "MAINMPDIS" || c.ProductCode == "MAINBVDIS").Sum(c => c.Quantity);

                    if (oosItems > 0)
                    {
                        modelState.AddModelError("Form", "One or more of your items are out of stock");
                    }

                }
            }


        }
        public override void PostProcessPageActions()
        {
            //Checking for the pages code based on the main order pages array on line ten.
            if (DtmContext.Page.IsStartPageType)
            {

                if (DtmContext.Version == 10)
                {
                    var itemsFromOtherVersions = new List<string>() { "MAINMP3", "MAINTV", "MAINBV3" };

                    foreach (var item in itemsFromOtherVersions)
                    {
                        OrderManager.SetProductQuantity(item, 0);
                    }
                }

                if (DtmContext.Version < 5)
                {
                    if (DtmContext.Version == 3)
                    {
                        OrderManager.SetProductQuantity("MAINC", 0);
                        OrderManager.SetProductQuantity("AFFMAINC", 0);
                    }
                    else if (DtmContext.Version == 4)
                    {
                        OrderManager.SetProductQuantity("MAINC10", 0);
                        OrderManager.SetProductQuantity("AFFMAINC10", 0);
                    }


                    Trace.WriteLine("Processing post page actions...");
                    var mainProductCodes = DtmContext.CampaignProducts
                        .Where(cp => cp.ProductTypeId == 1)
                        .Select(cp => new { cp.ProductCode, cp.AdditionalProductCode })
                        .ToDictionary(cp => cp.ProductCode, cp => cp.AdditionalProductCode);

                    foreach (var item in mainProductCodes)
                    {
                        if (Order.Items[item.Key].Quantity > 0)
                        {
                            Order.AddOrderCode(item.Value, "OrderTags");
                        }
                    }

                    var customerTag = string.Empty;
                    if (SetBoolOrderCode("PromotionalEmails"))
                    {
                        customerTag += "Accepts Email Marketing,";
                    }

                    if (SetBoolOrderCode("PromotionalTexts"))
                    {
                        customerTag += "Accepts SMS Marketing,";
                    }

                    if (!string.IsNullOrWhiteSpace(customerTag))
                    {
                        Order.AddOrderCode(customerTag.Substring(0, customerTag.LastIndexOf(",")), "CustomerTags");
                    }

                    if (Form["acceptOffer"] != null && (Order.Items["AFFMAINC"].Quantity > 0 || Order.Items["AFFMAINC10"].Quantity > 0))
                    {
                        OrderManager.SetProductQuantity("MAINC", 0);
                        OrderManager.SetProductQuantity("MAINC10", 0);
                    }



                    OrderManager.SetProductQuantity("WAREXT1", Order.Items[MainCode].Quantity + Order.Items[AffirmPrefix + MainCode].Quantity);



                    if (Order.Items[AffirmPrefix + MainCode].Quantity > 0)
                    {
                        DtmContext.Order.SiteExtraInfo3 = "true";
                    }
                    else
                    {
                        DtmContext.Order.SiteExtraInfo3 = "false";
                    }



                }
                else
                {
                    if (MainCode.Contains(','))
                    {
                        var mainCodes = MainCode.Split(',').ToList();

                        if (DtmContext.Version < 8)
                        {
                            foreach (var code in mainCodes)
                            {
                                if (Order.Items[code].Quantity + Order.Items[AffirmPrefix + code].Quantity > 0)
                                {
                                    OrderManager.SetProductQuantity("WAREXT1", Order.Items[code].Quantity + Order.Items[AffirmPrefix + code].Quantity);
                                    break;
                                }
                            }
                        }
                        var hasAffirmItem = false;

                        foreach (var code in mainCodes)
                        {
                            if (Order.Items[AffirmPrefix + code].Quantity > 0)
                            {
                                hasAffirmItem = true;
                            }
                        }

                        DtmContext.Order.SiteExtraInfo3 = hasAffirmItem.ToString().ToLower();

                    }
                    if (DtmContext.Version == 8)
                    {
                        var iterationString = Form["iteration"];

                        if (iterationString != null)
                        {
                            var iteration = 0;
                            int.TryParse(iterationString, out iteration);
                            OrderManager.SetProductQuantity("COUNTDOWN", iteration);
                        }
                    }
                }

                if (DtmContext.Version == 16) 
                {
                    var landingPageCodes = new List<string>() { "DOWN1", "MAINTVLOW", "MAINMP3LOW" };
                    var cartCodes = DtmContext.ShoppingCart.Select(sc => sc.ProductCode).ToList();
                    var lastAddedCode = cartCodes.LastOrDefault();

                    if (lastAddedCode != null && landingPageCodes.Contains(lastAddedCode)) 
                    {
                        foreach (var code in landingPageCodes)
                        {
                            if (DtmContext.ShoppingCart[code].Quantity > 0 && code != lastAddedCode)
                            {
                                OrderManager.SetProductQuantity(code, 0);
                            }
                        } 
                    }
                }

            }
            else if (DtmContext.Page.PageTypeId == 2)
            {
                SetSkipToCheckout();
            }
        }
        public override void OnRejectOffer()
        {
            base.OnRejectOffer();

            if (DtmContext.Page.PageTypeId == 2)
            {
                SetSkipToCheckout();
            }
        }
        private void SetSkipToCheckout()
        {
            var skipToCheckoutValue = Form["SKIP"] ?? string.Empty;
            bool skipToCheckout;

            if (bool.TryParse(skipToCheckoutValue, out skipToCheckout))
            {
                if (skipToCheckout)
                {
                    Order.SiteExtraInfo1 = "SKIPPED";
                }
                else
                {
                    Order.SiteExtraInfo1 = string.Empty;
                }
            }
        }
        private bool SetBoolOrderCode(string label)
        {
            var formValue = Form[label] ?? string.Empty;
            bool value;

            if (bool.TryParse(formValue, out value))
            {
                Order.AddOrderCode(value.ToString(), label);
                return value;
            }
            else
            {
                Order.AddOrderCode("False", label);
                return false;
            }
        }

        public override void PostSetOrderStatus()
        {
            base.PostSetOrderStatus();
            if (DtmContext.Page.IsStartPageType && !DtmContext.PageCode.Equals("PaymentForm", System.StringComparison.InvariantCultureIgnoreCase))
            {
                Order.OrderStatusId = 1;
            }
        }
        #endregion
    }
}
