<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<noscript>
    <style>
        .media__player {
            display: none;
        }
    </style>
</noscript>
<%
    var videoLabels = SettingsManager.ContextSettings["FrameworkJS/CSS.Eflex.Play.Labels", "Watch The Show | User Reviews | How It Works"];
    var videoIds = SettingsManager.ContextSettings["FrameworkJS/CSS.Eflex.Play.Source", "123456789 | 123456789 | 123456789"];

    var videoLabelList = videoLabels.Split(new []{ "|" }, StringSplitOptions.RemoveEmptyEntries).Select(s => s.Trim()).ToList();
    var videoIdList = videoIds.Split(new[] { "|" }, StringSplitOptions.RemoveEmptyEntries).Select(s => s.Trim()).ToList();
    var videoDictionary = videoIdList.Zip(videoLabelList, (k, v) => new { k, v }).ToDictionary(x => x.k, y => y.v);
    var videos = videoDictionary.Count();

    if (videos > 0)
    {
        %>
        <div class="media__player media__item">
        <%
        var firstVideo = videoDictionary.First();
        %>
        <div class="media__video contain contain--video load-item" title="Watch the video" id="vimeo-hero" data-src-iframe="https://player.vimeo.com/video/<%= firstVideo.Key %>?dnt=1"></div>
        <%

        if (videos > 1)
        {
            var keysList = videoDictionary.Keys.ToList();
            %>
            <nav class="group" aria-label="Video playlist">
            <%
            foreach (var video in videoDictionary)
            {
                var index = keysList.IndexOf(video.Key);
                %>
                <button id="video-button-<%= video.Value %>" data-slide-index="<%= index %>" class="btn btn--media slide__btn media__btn" data-video-id="<%= video.Key %>"><%= video.Value %></button>
                <%
            }
            %>
            </nav>
            <%
        }

        %>
        </div>
        <%
        }
%>