using System;
using System.Collections.Generic;
using System.Linq;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Models;

namespace SJOXTREAM.PageHandlers
{
    public class UP76PageHandler : PageHandler
    {
        #region " Overrides... "
        public override void OnRejectOffer()
        {
            var UP7active = Form["Up7Active"] ?? string.Empty;
            var UP6active = Form["Up6Active"] ?? string.Empty;
            var UP7quantity = Form["Up7hiddenQty"] ?? "0";
            var UP6quantity = Form["Up6hiddenQty"] ?? "0";
            bool isUp7Active;
            bool isUp6Active;
            if (Boolean.TryParse(UP7active, out isUp7Active) && isUp7Active)
            {             
                OrderManager.SetProductQuantity("UP7", Int32.Parse(UP7quantity));
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
