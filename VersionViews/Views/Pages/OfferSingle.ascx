<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<% 
    var id = ViewData["id"] as string ?? string.Empty;
    var productCode = ViewData["productCode"] as string ?? string.Empty;
    var excludeDiscountOf = ViewData["excludeDiscountOf"] as bool? ?? true;
    var standfirst = ViewData["standfirst"] as string ?? "1 payment of";

    var product = DtmContext.CampaignProducts.Where(
        cp => cp.ProductTypeId == 1
        && cp.ProductCode == productCode
    ).FirstOrDefault();
    var hasProduct = product != null;

    if (hasProduct)
    {
        var price = product.Price;
        var priceLabel = String.Format("1 payment of {0}", price.ToString("C2"));

        var dollars = Math.Truncate(price);
        var dollarsLabel = dollars.ToString();

        var cents = price - Math.Truncate(price);
        cents = cents * 100;
        cents = (int)cents;
        var centsLabel = cents.ToString();

        var offer = new ViewDataDictionary
        {
            { "label", priceLabel },
            { "standfirst", standfirst },
            { "dollar", dollarsLabel },
            { "cent", centsLabel },
            { "cssClasses", "offer--single-pay" }
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
                    var discountOfPrice = discountOfProduct.Price;
                    var discountOfDollars = Math.Truncate(discountOfPrice);
                    var discountOfDollarsLabel = discountOfDollars.ToString();

                    var discountOfCents = discountOfPrice - Math.Truncate(discountOfPrice);
                    discountOfCents = discountOfCents * 100;
                    discountOfCents = (int)discountOfCents;
                    var discountOfCentsLabel = discountOfCents.ToString();

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