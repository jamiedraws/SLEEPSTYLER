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
    public class PaymentFormPageHandler : CommonPageHandler
    {

        #region " Overrides... "

        public override void BeginRequest(HttpRequestBase request, HttpResponseBase response, ref string pageCode)
        {
            base.BeginRequest(request, response, ref pageCode);
            if (string.Equals(request.HttpMethod, "GET") && (DtmContext.Order == null || DtmContext.Order.OrderID == 0 || !DtmContext.Order.OrderItems.Any()))
            {
                var url = string.Format("Index{0}", DtmContext.ApplicationExtension);
                if (request.Url != null)
                {
                    var query = request.Url.Query == null ? string.Empty : request.Url.Query.ToString();

                    url = url + query;
                }

                response.Redirect(url);
            }
        }

        public override void PostProcessPageActions()
        {

            var mainProductCodes = DtmContext.CampaignProducts
                .Where(cp => cp.ProductTypeId == 1)
                .Select(cp => new { cp.ProductCode, cp.AdditionalProductCode })
                .ToDictionary(cp => cp.ProductCode, cp => cp.AdditionalProductCode);
            var isAffirm = string.Equals(Order.CardType, "Affirm", System.StringComparison.InvariantCultureIgnoreCase);
            var mainOrderItems = DtmContext.Order.OrderItems
                .Where(oi => oi.CachedProductInfo.ProductTypeId == 1)
                .Select(oi => oi.CachedProductInfo.ProductCode)
                .ToList();

            foreach (var item in mainOrderItems)
            {
                if (isAffirm && !item.StartsWith(AffirmPrefix))
                {
                    OrderManager.UpgradeProduct(item, AffirmPrefix + item);
                }
                else if (!isAffirm && item.StartsWith(AffirmPrefix))
                {
                    OrderManager.UpgradeProduct(item, item.Replace(AffirmPrefix, string.Empty));
                }
            }

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

            if (DtmContext.Version <= 5 || DtmContext.Version == 7)
            {
                if (MainCode.Contains(','))
                {
                    var mainCodes = MainCode.Split(',').ToList();

                    foreach (var code in mainCodes)
                    {
                        if (Order.Items[code].Quantity + Order.Items[AffirmPrefix + code].Quantity > 0)
                        {
                            OrderManager.SetProductQuantity("WAREXT1", Order.Items[code].Quantity + Order.Items[AffirmPrefix + code].Quantity);
                            break;
                        }
                    }
                }
            }
            if (DtmContext.Version == 8)
            {
                OrderManager.SetProductQuantity("COUNTDOWN", 0);
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
        #endregion
    }
}
