<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Models.Ecommerce.Repositories" %>
<%@ Import Namespace="Dtm.Framework.Base.TokenEngines" %>

<article class="section__in copy article">
<% 
    var pageCode = ViewData["PageCode"] as string ?? string.Empty;

    if (!String.IsNullOrEmpty(pageCode))
    {
        var pageRepo = new PageRepository();
        var upsellRepo = new UpsellRepository();

        var pages = pageRepo.GetCampaignPages(DtmContext.CampaignCode);
        var upsell = pages.Where(p => p.PageCode.Equals(pageCode, StringComparison.InvariantCultureIgnoreCase));

        if (upsell.Any())
        {
            var toke = new TokenEngine();
            var page = upsellRepo.GetByPageId(upsell.FirstOrDefault().PageId);

            var title = page.Title ?? string.Empty;
            var text = page.Text ?? string.Empty;

            var hasTitle = !String.IsNullOrEmpty(title);
            var hasText = !String.IsNullOrEmpty(text);

            

            if (hasTitle)
            {
                %>
                <h2><%= toke.Process(title, baseClientViewData: Model).Content %></h2>
                <%
            } else
            {
                Html.RenderSnippet("SUBPAGE-TITLE-" + pageCode);
            }

            if (hasText)
            {
                %>
                <%= toke.Process(text, baseClientViewData: Model).Content  %>
                <%
            } else
            {
                Html.RenderSubPageContent(pageCode);
            }
        }
    }
%>
</article>