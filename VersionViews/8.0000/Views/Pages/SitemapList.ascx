<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var productName = SettingsManager.ContextSettings["Label.ProductName"];
    var ext = DtmContext.ApplicationExtension;

    var renderFooter = false;
    var renderFooterValue = ViewData["renderFooter"] as string ?? "True";
    Boolean.TryParse(renderFooterValue, out renderFooter);
    var labelCategory = ViewData["labelCategory"] as string ?? "Footer";
    var id = labelCategory.Replace(" ", "-").ToLower();

    var isIndex = DtmContext.PageCode == "Index";
%>

<nav aria-label="<%= String.Format("{0} {1}", labelCategory, "Offer information") %>">
    <ul class="list">
        <li>
            <a id="<%= id %>-home" href="Index<%= ext %>">Home</a>
        </li>
        <li>
            <a id="<%= id %>-faq" href="FAQ<%= ext %>" aria-label="Frequently Asked Questions" title="Frequently Asked Questions">FAQS</a>
        </li>
        <li>
            <a id="<%= id %>-customer-service" href="Customer-Service<%= ext %>">Contact Us</a>
        </li>
        <li>
            <a id="<%= id %>-shipping-policy" href="Shipping-Policy<%= ext %>">Shipping Policy</a>
        </li>
        <li>
            <a id="<%= id %>-return-policy" href="Return-Policy<%= ext %>">Return Policy</a>
        </li>
        <li>
            <a id="<%= id %>-privacy-policy" href="Privacy-Policy<%= ext %>">Privacy Policy</a>
        </li>
        <li>
            <a id="<%= id %>-security-policy" href="Security-Policy<%= ext %>">Security Policy</a>
        </li>
        <% if (renderFooter)
         { %>
        <li>
            <a id="<%= id %>-sitemap" href="Sitemap<%= ext %>" aria-label="View all pages" title="View all pages">Sitemap</a>
        </li>
        <li>
            <a id="<%= id %>-order" href="#order" aria-label="Order the <%= productName %>">Order Now</a>
        </li>
        <% } %>
    </ul>
</nav>