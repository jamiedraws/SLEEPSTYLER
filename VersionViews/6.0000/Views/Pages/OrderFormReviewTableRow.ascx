<%@ Control Language="C#" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var i = 0;
    var enableZeroQuantity = SettingsManager.ContextSettings["OrderFormReview.AllowZeroQuantityWhenEditable", true];
    foreach (var item in DtmContext.ShoppingCart.Items)
    {
%>
    <tr>
        <td data-eflex--category-label="Item"><%=item.ProductName %></td>
        <td data-cart-code="<%=item.ProductCode %>Quantity" data-eflex--category-label="Quantity">
            <select id="ActionQuantity<%=i %>" name="ActionQuantity<%=i %>" data-index="0" data-item="<%=item.ProductCode %>" onchange="window.UpdateCart(this);">
                    <%
                        var startIndex = enableZeroQuantity ? 0 : 1;
                        for (int t = startIndex; t <= item.CampaignProduct.MaxQuantity; t++)
                        {
                            var selected = item.Quantity == t;
                    %>
                            <option <%= selected ? "selected" : string.Empty %>  value="<%=t %>"><%=t %></option>
                    <%
                        }
                    %>
            </select></td>
        <td data-cart-code="<%=item.ProductCode %>Price" data-eflex--category-label="Price"><%=(item.Price.HasValue ? item.Price.Value * item.Quantity : 0M).ToString("C") %></td>
        <td data-cart-code="<%=item.ProductCode %>Shipping" data-eflex--category-label="S&amp;H"><%=(item.Shipping.HasValue ? item.Shipping.Value * item.Quantity : 0M).ToString("C") %></td>
    </tr>
    <input type="hidden" name="ActionCode<%=i %>" id="ActionCode<%=i %>" value="<%=item.ProductCode %>" />
<%
        i++;
    }

%>

