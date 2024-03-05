<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var id = ViewData["id"] as string ?? string.Empty;
    var display = ViewData["display"] as string ?? "carousel";
    var thumbnails = "thumbnails";

    if (!String.IsNullOrEmpty(id))
    {
        if (display == thumbnails)
        {
            %>
            <nav class="copy__thumbnails slide__thumbnails" id="<%= id %>-thumbnails">
            <%
        } else
        {
            %>
            <div id="<%= id %>" class="carousel copy__image slide__into">    
            <%
        }

        for (var i = 0; i < 5; i++)
        {
            if (display == thumbnails)
            {
                var img = String.Format("/images/inuse-gallery/{0}-thumb-{1}.jpg", id, i);
                var thumbId = String.Format("{0}-{1}", id, i);
                %>
                <a href="#<%= thumbId %>" class="slide__thumbnail" data-slide-index="<%= i %>">
                    <% if (!DtmContext.IsMobile)
                        { %>
                    <picture data-src-img="<%= img %>" data-attr='{ "alt" : "Thumbnail" }' style="--arp:100/100;--arp-max:100px">
                        <noscript><img src="<%= img %>" alt="Thumbnail 1"></noscript>
                    </picture>
                    <% } %>
                </a>
                <%
                    } else
                    {
                        var img = String.Format("/images/inuse-gallery/{0}-slide-{1}.jpg", id, i);
                        var slideId = String.Format("{0}-{1}", id, i);
                %>
                <picture id="<%= slideId %>" class="carousel__item slide__item" style="--arp:348/271;--arp-max:348px" data-src-img="<%= img %>">
                    <noscript>
                        <img src="<%= img %>" alt="">
                    </noscript>
                </picture>
                <%
            }
        }

        if (display == thumbnails)
        {
            %>
            </nav>    
            <%
        } else
        {
            %>
            </div>
            <%
        }
    }
%>