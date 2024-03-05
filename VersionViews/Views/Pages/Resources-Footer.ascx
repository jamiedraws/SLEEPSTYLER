<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>

<%
    var isIndex = DtmContext.PageCode == "Index";
    var isFAQ = DtmContext.PageCode == "FAQ";
    var v = String.Format("?v={0}", 4);
%>
<script src="/shared/js/moment.min.js?v=<%= DtmContext.ApplicationVersion %>" type="text/javascript"></script>
<%--
<% if (isIndex) { %>
    <script defer src="/js/slide/js/slide.js<%= v %>"></script>
    <script defer src="/js/slide/js/components/slide.a11y.js"></script>
    <script defer src="/js/slide/js/components/slide.thumbnails.js"></script>
    <script defer src="/js/index.js<%= v %>"></script> 
<% } %>

<% if (isFAQ) { %>
    <script defer src="/js/card.js"></script>    
<% } %>
--%>