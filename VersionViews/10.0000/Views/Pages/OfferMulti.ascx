<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<% 
    var id = ViewData["id"] as string ?? string.Empty;
    var productCode = ViewData["productCode"] as string ?? string.Empty;
    var excludeDiscountOf = ViewData["excludeDiscountOf"] as bool? ?? true;

    var product = DtmContext.CampaignProducts.Where(
        cp => cp.ProductTypeId == 1
        && cp.ProductCode == productCode
    ).FirstOrDefault();
    var affirmPrice = product.PropertyIndexer["AffirmEstimatePaymentAmount"] ?? SettingsManager.ContextSettings["Affirm.AffirmEstimatePaymentAmount"];
    var hasProduct = product != null;

    if (hasProduct)
    {
        var price = Convert.ToDecimal(affirmPrice);
        var dollars = Math.Truncate(price);
        var dollarsLabel = dollars.ToString();

        var cents = price - Math.Truncate(price);
        cents = cents * 100;
        cents = (int)cents;
        var hasCents = cents != 0;
        var centsLabel = hasCents ? cents.ToString() : @"<span class=""offer__slash"">/</span>mo";

        var standfirst = "For as low as";
        var label = String.Format("Payments as low as {0} per month with Affirm for 12 months", price.ToString("C2"));
        var disclaimer = hasCents ? "a month for 12 months" : "for 12 months";

        if (id.StartsWith("nav"))
        {
            disclaimer = hasCents ? "/mo" : string.Empty;
        }

        var offer = new ViewDataDictionary
        {
            { "label", label },
            { "standfirst", standfirst },
            { "dollar", dollarsLabel },
            { "cent", centsLabel },
            { "cssClasses", "offer--multi-pay" },
            { "disclaimer", disclaimer }
        };

        if (!excludeDiscountOf)
        {
            var discountOf = product.PropertyIndexer["DiscountOf"] ?? string.Empty;
            if (!String.IsNullOrEmpty(discountOf))
            {
                var discountOfProduct = DtmContext.CampaignProducts.Where(
                    cp => cp.ProductTypeId == 1
                    && cp.ProductCode == discountOf
                ).FirstOrDefault();

                var hasDiscountOfProduct = discountOf != null;

                if (hasDiscountOfProduct)
                {
                    var discountOfPrice = Convert.ToDecimal(discountOfProduct.PropertyIndexer["AffirmEstimatePaymentAmount"]);
                    var discountOfDollars = Math.Truncate(discountOfPrice);
                    var discountOfDollarsLabel = discountOfDollars.ToString();

                    var discountOfCents = discountOfPrice - Math.Truncate(discountOfPrice);
                    discountOfCents = discountOfCents * 100;
                    discountOfCents = (int)discountOfCents;
                    var hasDiscountOfCents = discountOfCents != 0;
                    var discountOfCentsLabel = hasDiscountOfCents ? discountOfCents.ToString() : "/mo";

                    offer.Add("discountOf", new ViewDataDictionary
                    {
                        { "dollar", discountOfDollarsLabel },
                        { "cent", discountOfCentsLabel }
                    });
                }
            }
        }

        Html.RenderPartial("Offer", offer);
    }
%>