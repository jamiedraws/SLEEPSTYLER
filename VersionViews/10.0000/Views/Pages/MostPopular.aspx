<%@ Page Language="C#" MasterPageFile="~/VersionViews/5.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<% 
    var landingPageUrl = DtmContext.OfferVersion.IsDefault 
        ? "/" 
        : String.Format("/{0}/{1}/Index{2}", DtmContext.OfferCode, DtmContext.Version, DtmContext.ApplicationExtension);
    Response.Redirect(landingPageUrl);
%>

</asp:Content>