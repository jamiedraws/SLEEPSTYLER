<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>

<%
    Html.RenderPartial("ResourceManager", new ViewDataDictionary { { "preconnect", true }, { "preload", true } });
    Html.RenderPartial("ResourceManager");
    Html.RenderPartial("ResourceManager", new ViewDataDictionary { { "defer", true } });
%>

<noscript>
    <style>
        .defer::after {
            display: none;
        }

        .defer__progress {
            visibility: visible;
            opacity: 1;
        }
    </style>
</noscript>