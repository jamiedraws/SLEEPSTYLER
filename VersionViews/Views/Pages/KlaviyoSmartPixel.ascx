<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="Dtm.Framework.Models.Ecommerce.Repositories" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%
    var publicKey = ViewData["PublicApiKey"] as string;
    var controlId = ViewData["ControlId"] as string;

    if (!string.IsNullOrWhiteSpace(publicKey) && DtmContext.Page != null)
    {

        bool useCampaignNameForBrand = bool.TryParse(ViewData["UseCampaignNameForBrand"] as string ?? "false", out useCampaignNameForBrand) && useCampaignNameForBrand;
        bool useOfferNameForCategory = bool.TryParse(ViewData["UseOfferNameForCategory"] as string ?? "false", out useOfferNameForCategory) && useOfferNameForCategory;

        var pageCode = DtmContext.PageCode ?? string.Empty;
        var completeStatuses = new[] { 2, 3, 11, 12 };
        var conversionPages = (ViewData["ConversionPages"] ?? string.Empty).ToString().ToLower();
        bool refireAllowedSale = bool.TryParse(ViewData["refireAllowed"] as string ?? "false", out refireAllowedSale) && refireAllowedSale;
        bool fireOnUpsell = bool.TryParse(ViewData["fireOnUpsell"] as string ?? "true", out fireOnUpsell) && fireOnUpsell;
        bool? perfomPixelFire = ViewData["PerformPixelFire"] as bool?;

        bool hasConversionPages = !string.IsNullOrWhiteSpace(conversionPages);
        bool isOnConfirmationPage = (pageCode.ToLower().Contains("confirmation") || pageCode.ToLower().Contains("ordersummary") || DtmContext.Page.PageTypeId == 23);  //PageTypeId 23: Review

        if (hasConversionPages && !isOnConfirmationPage)
        {
            var pagesArray = conversionPages.Split(',');
            for (int i = 0; i < pagesArray.Count(); i++)
            {
                isOnConfirmationPage = pageCode.Equals(pagesArray[i].Trim(), StringComparison.InvariantCultureIgnoreCase);
                if (isOnConfirmationPage)
                {
                    break;
                }
            }
        }

        bool firePixelSale = false;
        if (perfomPixelFire.HasValue
            && perfomPixelFire.Value
            && (completeStatuses.Contains(DtmContext.Order.OrderStatusId) || string.Equals(DtmContext.Order.CardType, "PAYPALEC", StringComparison.InvariantCultureIgnoreCase))
            && (hasConversionPages && isOnConfirmationPage || !hasConversionPages && (isOnConfirmationPage || (fireOnUpsell && !DtmContext.Page.IsStartPageType)))
            )
        {
            string conversionLabel = "KlaviyoCheckout" + publicKey;
            const string coversionExpectedValue = "1";
            var vsRepo = new VisitorSessionRepository();
            var conversionValue = vsRepo.GetVisitorSessionData(DtmContext.VisitorSessionId, conversionLabel);
            var hasAlreadyConverted = conversionValue == coversionExpectedValue;

            if (!hasAlreadyConverted)
            {
                firePixelSale = true;
                vsRepo.SaveVisitorSessionData(DtmContext.VisitorSessionId, conversionLabel, coversionExpectedValue);
            }
        }
%>
<script async type="text/javascript" src="//static.klaviyo.com/onsite/js/klaviyo.js?company_id=<%=publicKey %>"></script>


<script>
    var _learnq = _learnq || [];
<%
    if (DtmContext.Page.IsStartPageType)
    {
%>
    document.addEventListener("DOMContentLoaded", function () {
        let email = document.getElementById("Email");
        if (!email) {
            email = document.getElementsByName("Email")[0];
        }

        if (document.cookie.indexOf("__kla_id") >= 0) {
            klaviyo.Identify(null);
        } else if (email && email.value !== '') {
            klaviyo.Identify(email.value);
            if (klaviyo.HasExistingItems) {
                klaviyo.AddExistingItems();
            }
        }

        if (email) {
            email.addEventListener("change", function () {
                klaviyo.Identify(this.value);
                if (klaviyo.HasExistingItems) {
                    klaviyo.AddExistingItems();
                }
            });
        }
    });

    addEventListener("CartChange", function (event) {

        let items = document.querySelector("#ActionCode0").value;
        let itemInfo = klaviyo.ProductInfo[items];
        let cart = {
            total: document.querySelector(".summary-total").innerHTML.replace("$",""),
            itemNames: [itemInfo.ProductName],
            items: [{
                sku: itemInfo.ProductSku,
                price: itemInfo.ProductPrice,
                name: itemInfo.ProductName,
                qty: document.querySelector("#ActionQuantity0").value,
                code: items
            }]
        };


        klaviyo.AddToCart(cart);
    });
<%
    }
    else if (DtmContext.Page.PageType.Equals("Upsell", StringComparison.InvariantCultureIgnoreCase)) //Upsell Pages
    {
        var json =  JsonConvert.SerializeObject(DtmContext.Order.OrderItems, Formatting.Indented, new JsonSerializerSettings
            {
                NullValueHandling = NullValueHandling.Ignore
            });
        %>

    document.addEventListener("DOMContentLoaded", function () {
        let cart = {
            total: "<%=DtmContext.Order.OrderTotal.ToString()%>",
                itemNames: [],
                items: []
            };
            let upsellItems = <%=json%>;
            for (let i = 0; i < upsellItems.length; i++) {
                let item = upsellItems[i],
                    cartItem = {
                        sku: item.ProductSku,
                        price: item.Price,
                        name: item.Description,
                        qty: item.Quantity,
                        code: item.CampaignProduct.ProductCode
                    };

                cart.items.push(cartItem);
                cart.itemNames.push(cartItem.name);
            }
            klaviyo.AddToCart(cart);
        });
    
    <%}

%>

    document.addEventListener("DOMContentLoaded", function () {
        if (klaviyo.FireCheckout) {
            klaviyo.StartedCheckout();
        }

        setTimeout(klaviyo.ViewProduct.bind(klaviyo), 15000);

    });

    const Klaviyo = function () {
        var items = [], identified = false, self = this;
        this.Identify = function (email) {
            if (email) {
                _learnq.push(['identify', {
                    '$email': email
                }]);
            }

            identified = true;
        };

        var isIdentified = function () {
            if (identified || document.cookie.indexOf("__kla_id") >= 0) {
                return true;
            }
            return false;
        };

        this.ImageUrls = {};
        this.ProductUrls = {};
        this.Ids = {};
        this.ProductInfo = {};

		<%


    var imageProperties = DtmContext.CampaignProducts.Where(c => c.PropertyIndexer.Has("KlaviyoImageUrl"))
        .Select(c => new { c.ProductSku, Image = c.PropertyIndexer["KlaviyoImageUrl"] })
        .ToList();
    if (imageProperties != null && imageProperties.Any())
    {
        foreach (var imageProperty in imageProperties)
        {
            if (!String.IsNullOrWhiteSpace(imageProperty.Image) && imageProperty.Image.Contains("?appV="))
            {
                var imagePropertyImageWithVersion = imageProperty.Image + DtmContext.ApplicationVersion;
%>
        this.ImageUrls["<%=imageProperty.ProductSku%>"] = "<%=DtmContext.Domain.FullDomain%><%=imagePropertyImageWithVersion%>";
<%
    }
    else
    {
%>
        this.ImageUrls["<%=imageProperty.ProductSku%>"] = "<%=DtmContext.Domain.FullDomain%><%=imageProperty.Image%>";

<%
            }
        }
    }
    var productUrlProperties = DtmContext.CampaignProducts.Where(c => c.PropertyIndexer.Has("KlaviyoProductURL"))
        .Select(c => new { c.ProductSku, ProductURL = c.PropertyIndexer["KlaviyoProductURL"] })
        .ToList();
    if (productUrlProperties != null && productUrlProperties.Any())
    {
        foreach (var productUrlProperty in productUrlProperties)
        {

%>
        this.ProductUrls["<%=productUrlProperty.ProductSku%>"] = "<%=DtmContext.Domain.FullDomain%><%=productUrlProperty.ProductURL%>";

<%
        }
    }

    var products = DtmContext.CampaignProducts
        .Where(c=> c.ProductType != "Promo" && c.ProductType != "Shipping" && c.ProductType != "None")
        .Select(c => new { c.ProductCode, Sku = c.ProductSku, Price  = c.Price.ToString("#.00"), Name = c.ProductName }).ToList();
    if (products != null && products.Any())
    {
        foreach (var product in products)
        {
%>
        this.ProductInfo["<%=product.ProductCode%>"] = {
            "ProductName": "<%= product.Name%>",
            "ProductSku": "<%= product.Sku%>",
            "ProductPrice": <%= product.Price%>
        }
<%
        }
    }

        var productIds = DtmContext.CampaignProducts
        .Where(c=> c.ProductType != "Promo" && c.ProductType != "Shipping" && c.ProductType != "None")
        .Select(c => new { c.ProductCode, ProductId = c.CampaignProductId.ToString() }).ToList();
    if (productIds != null && productIds.Any())
    {
        foreach (var id in productIds)
        {
%>
        this.Ids["<%=id.ProductCode%>"] = "<%=id.ProductId%>";
<%
        }
    }
		%>

        var isNullOrWhitespace = function (value) {
            let nullOrWhitespace = false;
            if (value == null || value == undefined) {
                nullOrWhitespace = true;
            } else {
                try {
                    if (value == '' || value.trim() == '' || value == 'undefined') {
                        nullOrWhitespace = true;
                    }
                } catch (e) {
                    nullOrWhitespace = false;
                }
            }

            return nullOrWhitespace;
        };

        this.ViewProduct = function () {
            let firstProduct;
            const items = document.getElementsByName("ActionCode0");

            if (items.length > 0) {

                firstProduct = items[0].value;
                const productInfo = this.ProductInfo[firstProduct];
                if (productInfo) {
                    let viewProductEvent = {
                        "ProductName": productInfo.ProductName,
                        "ProductID": this.Ids[firstProduct],
                        "SKU": productInfo.ProductSku,
                        "ImageURL": this.ImageUrls[productInfo.ProductSku],
                        "URL": isNullOrWhitespace(this.ProductUrls[productInfo.ProductSku]) ? "<%=DtmContext.Domain.FullDomain%>" : this.ProductUrls[productInfo.ProductSku],
                        "Price": productInfo.ProductPrice
                    };

                    _learnq.push(["track", "Viewed Product", viewProductEvent]);
                    console.log(viewProductEvent);
                }
            }
        };

        this.AddToCart = function (cartData) {
            if (isIdentified() && cartData && cartData.items && cartData.items.length > 0) {

                let kItems = [],
                    firstItem;
                for (let i = 0; i < cartData.items.length; i++) {
                    let item = cartData.items[i];
                    let kItem = {
                        "SKU": item.sku,
                        "ProductName": item.name,
                        "Quantity": item.qty,
                        "ItemPrice": item.price,
                        "ImageURL": this.ImageUrls[item.sku],
                        "ProductId": this.Ids[item.code],
                        "ProductURL": isNullOrWhitespace(this.ProductUrls[item.sku]) ? "<%=DtmContext.Domain.FullDomain%>" : this.ProductUrls[item.sku]
                    };

                    if (self.Brand) {
                        kItem["Brand"] = self.Brand;
                    }

                    if (self.Category) {
                        kItem["Categories"] = [self.Category];
                    }

                    kItems.push(kItem);

                    if (items.indexOf(item.name) < 0) {
                        items.push(item.name);
                        if (!firstItem) {
                            firstItem = item;
                        }
                    }
                }

                if (!firstItem) {
                    firstItem = cartData.items[0];
                };

                let addToCartEvent = {
                    "$value": cartData.total,
                    "AddedItemProductName": firstItem.name,
                    "ProductName": firstItem.name,
                    "AddedItemSKU": firstItem.sku,
                    "SKU": firstItem.sku,
                    "AddedItemPrice": firstItem.price,
                    "ItemPrice": firstItem.Price,
                    "ProductId": this.Ids[firstItem.code],
                    "AddedItemQuantity": firstItem.qty,
                    "Quantity": firstItem.qty,
                    "AddedItemImageURL": this.ImageUrls[firstItem.sku],
                    "ImageUrl": this.ImageUrls[firstItem.sku],
                    "ProductUrl": isNullOrWhitespace(this.ProductUrls[firstItem.sku]) ? "<%=DtmContext.Domain.FullDomain%>" : this.ProductUrls[firstItem.sku],
                    "ItemNames": cartData.itemNames,
                    "CheckoutURL": "<%=DtmContext.Domain.FullDomain%>",
                    "Campaign": self.Campaign,
                    "Offer": self.Offer,
                    "Items": kItems
                };

                if (self.Brand) {
                    addToCartEvent["Brands"] = [self.Brand];
                }

                if (self.Category) {
                    addToCartEvent["Categories"] = [self.Category];
                }

                _learnq.push(["track", "Added to Cart", addToCartEvent]);
            }
        };


    };

<% 
    if (firePixelSale)
    {
%>
    Klaviyo.prototype.FireCheckout = true;
    Klaviyo.prototype.StartedCheckout = function () {
        let itemNames = [],
            items = [],
            self = this;
	<%

    var orderItems = DtmContext.Order.OrderItems.Where(o => o.ProductSku != "SH" && o.ProductSku != "ADDSHIP" && o.CampaignProduct.ProductTypeId != 6);

    foreach (var item in orderItems)
    {
        var nameProperty = DtmContext.CampaignProducts.Where(c => c.PropertyIndexer.Has("Name") && c.ProductSku == item.ProductSku)
        .Select(c => c.PropertyIndexer["Name"])
        .ToArray();
        var name = nameProperty.FirstOrDefault() ?? item.Description;

        var productUrlProperty = DtmContext.CampaignProducts.Where(c => c.PropertyIndexer.Has("KlaviyoProductURL") && c.ProductSku == item.ProductSku)
            .Select(c => new { ProductUrl = DtmContext.Domain.FullDomain + c.PropertyIndexer["KlaviyoProductURL"] })
            .FirstOrDefault();

        var productUrl = DtmContext.Domain.FullDomain;
        if (productUrlProperty != null)
        {
            productUrl = productUrlProperty.ProductUrl;
        }
		%>
        itemNames.push("<%=name%>");
        items.push({
            "SKU": "<%=item.ProductSku%>",
            "ProductName": "<%=name%>",
            "Quantity": <%=item.Quantity%>,
            "ItemPrice": <%=item.Price %>,
            "ImageURL": this.ImageUrls["<%=item.ProductSku%>"],
            "ProductURL": "<%=productUrl %>",
            "ProductId": "<%=item.CampaignProductId.ToString()%>"
        });
		<%
    }

    var eventDate = DateTime.UtcNow;
    var unixTime = (int)eventDate.Subtract(new DateTime(1970, 1, 1)).TotalSeconds;
	%>
        let checkoutEvent = {
            "$event_id": "<%=DtmContext.OrderId.ToString() + unixTime.ToString()%>",
            "$value": <%=DtmContext.Order.OrderItems.Sum(oi=> oi.Quantity * (oi.Price + oi.Shipping))%>,
            "ItemNames": itemNames,
            "CheckoutURL": "<%=DtmContext.Domain.FullDomain%>",
            "Campaign": self.Campaign,
            "Offer": self.Offer,
            "Items": items
        };

        if (self.Category) {

            checkoutEvent["Categories"] = [self.Category];
        }

        if (self.Brand) {
            checkoutEvent["Brands"] = [self.Brand];
        }

        _learnq.push(["track", "Started Checkout", checkoutEvent]);
    };
<%
    }

    if (DtmContext.Page.IsStartPageType && DtmContext.ShoppingCart.Count > 0)
    {

	%>
    Klaviyo.prototype.HasExistingItems = true;
    Klaviyo.prototype.AddExistingItems = function () {

        let cart = {
            total: <%=DtmContext.ShoppingCart.Total%>,
            itemNames: [],
            items: []
        };

	<%
    foreach (var item in DtmContext.ShoppingCart)
    {
        var cleanName = item.ProductName.Replace(Environment.NewLine, string.Empty).Replace("'", string.Empty);
	%>
        cart.items.push({ sku: '<%=item.ProductSku%>', price: <%=item.Price%>, name: '<%=cleanName%>', qty: <%=item.Quantity%>});
        cart.itemNames.push('<%=cleanName%>');
	<%
    }
	%>

        this.AddToCart(cart);
    }

	<%

    }

    if (useCampaignNameForBrand)
    {
		%>
    Klaviyo.prototype.Brand = '<%= DtmContext.Campaign != null ? DtmContext.Campaign.CampaignName : string.Empty %>';
	<%
    }

    if (useOfferNameForCategory)
    {
		%>
    Klaviyo.prototype.Category = '<%=DtmContext.OfferVersion != null ? DtmContext.OfferVersion.OfferName : string.Empty%>';
	<%
    }
%>



    Klaviyo.prototype.Campaign = '<%=DtmContext.CampaignCode%>';
    Klaviyo.prototype.Offer = '<%=DtmContext.OfferCode%>';

    const klaviyo = new Klaviyo();
</script>
<% 
    }
    else
    {
        Response.Write("<!-- " + controlId + " No Public Key -->");
    }
%>