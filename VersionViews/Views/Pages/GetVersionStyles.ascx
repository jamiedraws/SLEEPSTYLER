<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>

<%
    Html.RenderPartial("GetVersionResources", new ViewDataDictionary { { "preload", true } });
    Html.RenderPartial("GetVersionResources");
    Html.RenderPartial("GetVersionResources", new ViewDataDictionary { { "defer", true } });
%>