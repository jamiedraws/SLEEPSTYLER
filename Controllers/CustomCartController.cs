using Dtm.Framework.ClientSites.Controllers;
using Dtm.Framework.ClientSites.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SJOXTREAM.Controllers
{
    public class CustomCartController : CartController
    {
        [HttpPost]
        public JsonResult CustomEdit(string page)
        {
            if(!string.IsNullOrWhiteSpace(page) && page != "none")
            {
                var newPage = DtmContext.CampaignPages
                     .FirstOrDefault(p => p.PageCode.Equals(page, StringComparison.InvariantCultureIgnoreCase)
                         || (!string.IsNullOrWhiteSpace(p.PageAlias) && p.PageAlias.Equals(page, StringComparison.InvariantCultureIgnoreCase)));

                if (newPage != null)
                {
                    DtmContext.Page = newPage;
                    DtmContext.PageCode = newPage.PageCode;
                }
                else 
                {
                    DtmContext.PageCode = page;
                }
            }
            
            Edit();
            

            return
                Json(new
                {
                    Body = RenderPartialViewToString("OrderFormReviewTableRow", Model),
                    Footer = RenderPartialViewToString("OrderFormReviewTableFooter", Model)
                }); 
        }
    }
}