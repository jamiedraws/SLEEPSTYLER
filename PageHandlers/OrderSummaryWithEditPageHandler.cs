using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Models;

namespace SJOXTREAM.PageHandlers
{
    public class OrderSummaryWithEditPageHandler : CommonPageHandler
    {
        #region " Overrides... "

        public override void PostValidate(ModelStateDictionary modelState)
        {
            var mainItemQty = ActionItems.Where(x => x.Key == MainCode || x.Key == AffirmPrefix + MainCode).Sum(y => y.Value);
            var war2Qty = ActionItems.Where(x => x.Key == "WAREXT2").FirstOrDefault().Value;

            if(mainItemQty < war2Qty)
            {
                AddModelStateError("Error", "Warning: Please check the number of Extended Warranties you are purchasing. " +
                    "The quantity in your cart currently exceeds the quantity of Sun Joe SPX3000 XTREAM Pressure Washers you have in your cart. ");
            }
        }

        public override void PostProcessPageActions()
        {
            var mainQty = Order.Items[MainCode].Quantity + Order.Items[AffirmPrefix + MainCode].Quantity;
            if (DtmContext.Version <= 5 || DtmContext.Version == 7)
            {
                OrderManager.SetProductQuantity("WAREXT1", mainQty);
            }
            if (Order.Items["WAREXT2"].Quantity > mainQty)
            {
                OrderManager.SetProductQuantity("WAREXT2", mainQty);
            }

        }

        #endregion
    }
}
