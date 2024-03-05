using System;
using System.Collections.Generic;
using System.Linq;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Models;

namespace SJOXTREAM.PageHandlers
{
    public class UP56PageHandler : PageHandler
    {
        #region " Overrides... "
        public override void OnRejectOffer()
        {
            var UP5active = Form["Up5Active"] ?? string.Empty;
            var UP6active = Form["Up6Active"] ?? string.Empty;
            var UP5quantity = Form["Up5hiddenQty"] ?? "0";
            var UP6quantity = Form["Up6hiddenQty"] ?? "0";
            bool isUp5Active;
            bool isUp6Active;

            if (Boolean.TryParse(UP5active, out isUp5Active) && isUp5Active)
            {
                OrderManager.SetProductQuantity("UP5", Int32.Parse(UP5quantity));
            }
            if (Boolean.TryParse(UP6active, out isUp6Active) && isUp6Active)
            {
                OrderManager.SetProductQuantity("UP6", Int32.Parse(UP6quantity));
            }

        }
        public override void PostProcessPageActions()
        {
            var itemId = Request.Params["itemId"] ?? string.Empty;
            var quantityValue = Request.Params["quantity"] ?? "0";
            int quantity;
            if(!string.IsNullOrWhiteSpace(itemId) && int.TryParse(quantityValue, out quantity))
            {
                OrderManager.SetProductQuantity(itemId, quantity);
            }
        }

        #endregion
    }
}
