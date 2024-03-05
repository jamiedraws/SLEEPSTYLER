using Dtm.Framework.Base.Controllers;
using Dtm.Framework.ClientSites.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SJOXTREAM.Controllers
{
    public class SubPageInfoController : DtmContextController
    {
        [HttpGet] 
        public ActionResult RenderSubPageInfo(string page)
        {
            SetOfferVersion();
            ViewData["PageCode"] = page;
            return View("SubPageInfo");
        }

        private void SetOfferVersion()
        {
            Guid covid = Guid.TryParse(Request["covid"], out covid) ? covid : Guid.Empty;
            if (covid != Guid.Empty && DtmContext.CampaignOfferVersions.Any(cov => cov.OfferVersionId == covid))
            {
                var offerVersion = DtmContext.CampaignOfferVersions.First(cov => cov.OfferVersionId == covid);
                DtmContext.OfferCode = offerVersion.OfferCode;
                DtmContext.Version = offerVersion.VersionNumber;
            }
        }
    }
}