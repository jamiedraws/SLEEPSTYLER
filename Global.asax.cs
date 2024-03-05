using Dtm.Framework.ClientSites.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace SJOXTREAM
{
    public class MvcApplication : ClientSiteApplication
    {
        protected override void ConfigureAdditionalRoutes(RouteCollection routes)
        {

            routes.MapRoute("CustomCart", "Items/Edit/{page}", new { controller = "CustomCart", action = "CustomEdit", page = "none" });

            routes.MapRoute(
                "RenderSubPageInfo",
                "SubPageInfo",
                new
                {
                    controller = "SubPageInfo",
                    action = "RenderSubPageInfo",
                    pageCode = "none"
                }
            );

             routes.MapRoute(
                "RenderBonusInfo",
                "BonusInfo",
                new
                {
                    controller = "BonusInfo",
                    action = "RenderBonusInfo"
                }
            );

            base.ConfigureAdditionalRoutes(routes);
        }
    }
}