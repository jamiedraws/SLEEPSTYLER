using Dtm.Framework.ClientSites.Web;
using System.Linq;

namespace SJOXTREAM.PageHandlers
{
    public class ProcessPaymentPageHandler : CommonPageHandler
    {
        #region " Overrides... "

        public override void PostProcessPageActions()
        {

            var paymentType = Form["OrderType"] ?? string.Empty;

            var isAffirm = string.Equals(paymentType, "Affirm", System.StringComparison.InvariantCultureIgnoreCase);
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
        }

        #endregion
    }
}
