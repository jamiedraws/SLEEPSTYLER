<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<main aria-label="<%= DtmContext.PageCode %>" class="view section">
    <div id="main" class="view__anchor"></div>
    <article class="view__in section__in copy article">
        <% 
            var title = Model.UpsellTitle ?? string.Empty;
            var text = Model.UpsellText ?? string.Empty;
            var hasTitle = !String.IsNullOrEmpty(title);
            var hasText = !String.IsNullOrEmpty(text);

            if (hasTitle)
            {
                %>
                <h2><%= title %></h2>
                <%
            } else
            {
                %>
                <% Html.RenderSnippet("SUBPAGE-TITLE-" + DtmContext.PageCode); %>
                <%
            }

            if (hasText)
            {
                %>
                <%= text %>
                <%
            } else
            {
                Html.RenderSubPageContent(DtmContext.PageCode);
            }
        %>
    </article>
</main>

</asp:Content>