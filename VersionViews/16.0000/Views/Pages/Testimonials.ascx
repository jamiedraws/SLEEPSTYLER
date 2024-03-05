<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Dtm.Framework.Base.Models.BaseClientViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.ClientSites.Web.Models" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%

    var ext = DtmContext.ApplicationExtension;
    var displayDefault = "carousel";
    var showMoreLink = ViewData["showMoreLink"] as bool? ?? false;
    var showOrderButton = ViewData["showOrderButton"] as bool? ?? false;
    var display = ViewData["display"] as string ?? displayDefault;
    var isCarousel = display == displayDefault;
    var isList = display == "list";
    var title = ViewData["title"] as string ?? string.Empty;
    var ariaTitle = "";
    if (!String.IsNullOrEmpty(title)) {
        ariaTitle = "aria-labelledby=\"reviews-title\"";
    }

    Func<string, string> TruncateAtLength = (text) =>
    {
        if (text == null || text.Length < 375)
        {
            return text;
        }
        int iNextP = text.LastIndexOf(".", 375, StringComparison.Ordinal);
        return string.Format("{0}…", text.Substring(0, (iNextP > 0) ? iNextP : 375).Trim());
    };

    var useThumbnails = ViewData["useThumbnails"] as bool? ?? true;

    if (Model != null && Model.Testimonials != null && Model.Testimonials.Any())
    {
        var approvedTestimonials = Model.Testimonials.Where(t => t.IsApproved
        && (!t.CampaignOfferVersionId.HasValue
        || (t.CampaignOfferVersionId.HasValue && t.CampaignOfferVersionId.Value == DtmContext.VersionId))
        && (!t.CampaignOfferId.HasValue
        || (t.CampaignOfferId.HasValue && t.CampaignOfferId.Value == DtmContext.OfferId)))
        .OrderBy(t => t.DisplayRank.HasValue ? t.DisplayRank.Value : 0);

        if (approvedTestimonials.Any())
        {
            var approvedCampaignTestimonials = approvedTestimonials.Where(t => !t.CampaignOfferVersionId.HasValue
                && !t.CampaignOfferId.HasValue).ToList()
                ?? new List<TestimonialView>();
            var approvedOfferTestimonials = approvedTestimonials.Where(t => t.CampaignOfferId.HasValue
                && !t.CampaignOfferVersionId.HasValue).ToList()
                ?? new List<TestimonialView>();
            var approvedVersionTestimonials = approvedTestimonials.Where(t => t.CampaignOfferVersionId.HasValue).ToList()
                ?? new List<TestimonialView>();

            var testimonials = approvedCampaignTestimonials;
            if (approvedVersionTestimonials.Count() > 0)
            {
                testimonials = approvedVersionTestimonials;
            }
            else if (approvedOfferTestimonials.Count() > 0)
            {
                testimonials = approvedOfferTestimonials;
            }

            if (isCarousel)
            {
                var carouselTestimonials = testimonials.Where(t => t.OkToShowName).ToList();
                var hasCarouselTestimonials = carouselTestimonials.Count() > 0;

                if (hasCarouselTestimonials)
                {
%>

<section aria-label="Customer Reviews" class="view review review--carousel section bg bg--brand view--remove-nav">
    <div id="reviews" class="view__anchor"></div>
    <div class="view__in section__in">
            <% if (!String.IsNullOrEmpty(title)) { %>
            <div class="section__block title">
                <h2 id="reviews-title" class="review__title title__text title__wrap">
                    <span>OVER <span class="title__underline">45,000</span> REVIEWS:</span>
                    <span>AMERICA'S TOP-RATED PRESSURE WASHER!</span>
                </h2>
            </div>
            <% } %>
            <div class="section__block slide slide--no-scrollbar review__slide">
                <div class="slide__js">
                    <noscript>
                        <style>
                            .slide__js {
                                display: none;
                            }
                        </style>
                    </noscript>
                </div>
                <div id="reviews-slide" class="slide__into review__into" tabindex="0">
                    <%
                        var currentIndex = 0;
                        var batchSize = 1;
                        var slideIndex = 0;
                        var totalTestimonialsAmount = carouselTestimonials.Count;
                        var renderControls = totalTestimonialsAmount > batchSize;

                        while (currentIndex < totalTestimonialsAmount)
                        {
                            var testimonialBatch = carouselTestimonials.Skip(currentIndex).Take(batchSize);
                            currentIndex += batchSize;
                    %>
                    <div id="review-<%= slideIndex %>" class="review__item slide__item">
                        <div class="review__group">
                        <%
                            foreach (var testimonial in testimonialBatch)
                            {
                                var quote = TruncateAtLength(String.Format("{0}", testimonial.Quote));
                                var name = String.Format("{0} {1}", testimonial.FirstName, testimonial.LastName);
                                var avatar = String.Format("/images/testimonials/{0}.jpg", name.Replace(" ", "-").ToLower());
                        %>
                        <blockquote class="review__quote">
                            <picture class="review__stars contain contain--stars" data-src-img="/images/stars.svg"></picture>
                            <h3><%= testimonial.Title %></h3>
                            <div class="copy"><%= quote %></div>
                            <footer>
                                <%= name %>
                                <% if (!String.IsNullOrEmpty(testimonial.Company)) { %>
                                &mdash; <i class="review__product"><%= testimonial.Company %></i>
                                <% } %>
                            </footer>
                        </blockquote>
                        <%
                            }

                        %>
                        </div>
                    </div>
                    <%

                            slideIndex++;
                        }

                    %>
                </div>
                <% if (renderControls) { %>
                <nav aria-label="Reviews previous and next slides" class="review__nav slide__nav">
                    <button
                        id="slide-prev"
                        aria-label="Select the previous slide"
                        class="slide__prev"
                        type="button">
                        <svg class="icon icon-chevron-thin-left"><use href="#icon-chevron-thin-left"></use></svg>
                    </button>
                    <button
                        id="slide-next"
                        aria-label="Select the next slide"
                        class="slide__next"
                        type="button">
                        <svg class="icon icon-chevron-thin-right"><use href="#icon-chevron-thin-right"></use></svg>
                    </button>
                </nav>
                <% if (useThumbnails) { %>
                <nav aria-label="Reviews thumbnail" class="review__thumbnails slide__thumbnails">
                    <%
                        var currentThumbnailIndex = 0;
                        var thumbnailIndex = 0;

                        while (currentThumbnailIndex < totalTestimonialsAmount)
                        {
                            currentThumbnailIndex += batchSize;
                            %>
                            <a href="#review-<%= thumbnailIndex %>" class="slide__thumbnail" data-slide-index="<%= thumbnailIndex%>" aria-label="Navigate to review set <%= thumbnailIndex %>"></a>
                            <%
                            thumbnailIndex++;
                        }
                    %>
                </nav>
                <% } %>
                <% } %>
            </div>
            <% if (showMoreLink && renderControls)
                { %>
            <div class="section__block text-center">
                <a href="Reviews<%= ext %>" id="index-reviews" class="btn btn--order">
                    <span>More Reviews</span>
                </a>
            </div>
            <% } %>
            <% if (showOrderButton)
                {
            %>
            <div class="copy__footer">
            </div>
            <% } %>
    </div>
</section>
<%
        }
    } %>

<% if (isList)
    {
        var listTestimonials = testimonials.Where(t => t.IsApproved).ToList();
        var hasListTestimonials = listTestimonials.Count() > 0;

        if (hasListTestimonials)
        {
%>
<main aria-labelledby="main-title" class="view review review--list section">
    <div id="main" class="view__anchor"></div>
    <article class="view__in section__in copy article">
        <h2 id="main-title"><%= title %></h2>
        <div class="section__block">
        <%
            foreach (var testimonial in listTestimonials)
            {
                var quote = testimonial.Quote;
                var name = String.Format("{0} {1}", testimonial.FirstName, testimonial.LastName);
                var avatar = String.Format("/images/testimonials/{0}.jpg", name.Replace(" ", "-").ToLower());
        %>
        <blockquote class="review__quote">
            <picture class="review__stars contain contain--stars" data-src-img="/images/stars.svg"></picture>
            <h3><%= testimonial.Title %></h3>
            <div class="copy"><%= quote %></div>
            <footer>
                <% if (testimonial.OkToShowName) { %>
                <%= name %>
                <% } %>
                <% if (!String.IsNullOrEmpty(testimonial.Company)) { %>
                &mdash; <i class="review__product"><%= testimonial.Company %></i>
                <% } %>
            </footer>
        </blockquote>
        <%
            }
        %>
        </div>
    </article>
</main>
<%
        }


    } %>
<% }
    } %>