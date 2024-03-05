<%@ Page Language="C#" MasterPageFile="~/VersionViews/5.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<% 
    Html.RenderPartial("Testimonials", Model, new ViewDataDictionary {
        { "display", "list" },
        { "title", "Customer Reviews" }
    });
%>

</asp:Content>