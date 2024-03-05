<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="SJOXTREAM.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    

<style>
.review__item--stacked {
    margin: 0;
    border-bottom: 0.15em solid #cccccc;
    padding: 1.5em 0;
}
.dtm .dtm__in .review__stars {
    max-width: 9em;
    margin: 0 0 0.5em;
}
.review__item--stacked:last-of-type {
    border-bottom: none;
}
</style>

<main aria-labelledby="main-title" class="view">
    <div id="main" class="view__anchor reveal-offscreen"></div>
    <div class="view__in">
        <div class="copy copy--article">
            <h2 id="main-title">Customer Reviews</h2>
            <div id="bvReviews"></div>
            <blockquote class="review__item review__item--stacked">
                <img src="/images/stars.svg" class="review__stars">
                <h3>No Dirt, No Grease, No Grime</h3>
                <p>&ldquo;I don't think I've seen my patio this clean. There's no dirt, there's no grease, there's no grime. There's no algae or moss. It removed all. Look at the difference, with just a quick minute of water. The Sun Joe works!&rdquo;<p>
                <footer><strong>Shawn S.</strong></footer>
            </blockquote>

            <blockquote class="review__item review__item--stacked">
                <img src="/images/stars.svg" class="review__stars">
                <h3>Gets every corner and crevice</h3>
                <p>&ldquo;Spray on the soap so easy. You don't have to use a bucket. You don't have to get yourself wet. It's so great in getting out all the mud in the corners and crevices and spray it all off with the power washer.<p>
                <footer><strong>Suzanne B.</strong></footer>
            </blockquote>

            <blockquote class="review__item review__item--stacked">
                <img src="/images/stars.svg" class="review__stars">
                <h3>It just works</h3>
                <p>&ldquo;With the SPX3000 literally, it took a few minutes and it's finished. The power that is behind this water is something I didn't expect. Getting rid of the mildew and the dirt off the roof tile, that was insane! This is not something that takes skill. It just works. The Sun Joe blew me away. It really did.<p>
                <footer><strong>Todd F.</strong></footer>
            </blockquote>

            <blockquote class="review__item review__item--stacked">
                <img src="/images/stars.svg" class="review__stars">
                <h3>Absolutely Incredible</h3>
                <p>&ldquo;It's so great! Look at the difference! You don't need to be strong. It's not heavy. It's ergonomic. It's absolutely incredible. I love it!<p>
                <footer><strong>Michelle P.</strong></footer>
            </blockquote>
            
            <blockquote class="review__item review__item--stacked">
                <h3>The difference is amazing</h3>
                <img src="/images/stars.svg" class="review__stars">
                <p>&ldquo;Wow! The difference after just a couple minutes of spraying this deck is amazing!<p>
                <footer><strong>Jenna C.</strong></footer>
            </blockquote>

            <blockquote class="review__item review__item--stacked">
                <img src="/images/stars.svg" class="review__stars">
                <h3>A great deal</h3>
                <p>&ldquo;Oftentimes when you get things that are really a great deal, you think it's not going to be well made. But this is very well made. Stainless steel on this, I know it'll last me a very long time.<p>
                <footer><strong>Brent S.</strong></footer>
            </blockquote>

            <blockquote class="review__item review__item--stacked">
                <img src="/images/stars.svg" class="review__stars">
                <h3>Amazed by the power</h3>
                <p>&ldquo;I mean look at the difference between what's been sitting here for years unattended to, and now we go over here in a matter of seconds and it brings it right off. I'm amazed by the power and time saving efficiency that this tool can have.<p>
                <footer><strong>Bruce B.</strong></footer>
            </blockquote>
            
            <blockquote class="review__item review__item--stacked">
                <img src="/images/stars.svg" class="review__stars">
                <h3>Quality parts</h3>
                <p>&ldquo;When I looked at the Sun Joe, I looked at the parts to make sure that they were quality, and I see stainless steel, I see brass, I mean even the hose looks like a high-pressure hose I've seen that they use for hydraulics.<p>
                <footer><strong>Jeffrey M.</strong></footer>
            </blockquote>
            
            <blockquote class="review__item review__item--stacked">
                <img src="/images/stars.svg" class="review__stars">
                <h3>Does just what it needs to do</h3>
                <p>&ldquo;The foam cannon is a plus. For me, it really is just about getting the soap on the car, providing the lubrication, and it does just what it needs to do.  The interchangeability of this lance for your brushes and the wheel brush, it's really quick and it's decibels, decibels, decibels less than a commercial-grade gas unit.  It feels good in the hand. The trigger is not too hard to pull. You have a variety of tips to choose from, the quick connects are nice and sturdy, and do what they're intended to do, and overall, no leaks, no problems. It's a great piece of equipment.<p>
                <footer><strong>John X.</strong> | Professional Auto Detailer</footer>
            </blockquote>

            <blockquote class="review__item review__item--stacked">
                <img src="/images/stars.svg" class="review__stars">
                <h3>Love the quality</h3>
                <p>&ldquo;It lacks nothing that a gas power has, that's actually the nice thing that it is dead silent right now...Really love the quality of the product, brass fittings, tips go in, go on, that's perfect! It's got all the power you need, after that it is a matter of convenience. It is the most convenient power washer I've used. This thing is really nice. I like it.<p>
                <footer><strong>Hans W.</strong> | Professional Painter</footer>
            </blockquote>

        </div>
    </div>
</main>

</asp:Content>