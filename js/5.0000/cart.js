(function (global) {
    if ("app" in global) {
        let cart = app.createContext(app);
        const itemKey = "item",
            cartCt = "reviewTableBody",
            cartFt = "reviewTableFoot";
        cart.addProperties({
            addItem: function (item) {
                let code = item.dataset[itemKey];
                if (this.cartItems.indexOf(code) < 0) {
                    let items = "Item0=" + code + "&Qty0=1";

                    let t = 1;
                    for (var i = 0; i < this.cartItems.length; i++) {
                        items +=
                            "&Item" +
                            t +
                            "=" +
                            this.cartItems[i] +
                            "&Qty" +
                            t +
                            "=0";
                        t++;
                    }
                    this.sendItems.call(this, items);
                    this.cartItems = [code];
                }
            },
            updateItem: function (item, qty) {
                let code = item.dataset[itemKey];
                this.sendItems.call(this, "Item0=" + code + "&Qty0=" + qty);
                if (qty === 0) {
                    this.cartItems.pop(code);
                }
            },
            processCart: function (action, item) {
                if (this.running) {
                    return;
                }
                this.lockCart.call(this);
                switch (action) {
                    case "add":
                        this.addItem.call(this, item);
                        break;
                    case "update":
                        let qty = parseInt(item.value);
                        this.updateItem.call(this, item, qty);
                        break;
                }
            },
            lockCart: function () {
                this.running = true;
            },
            unlockCart: function () {
                this.running = false;
            },
            sendItems: function (items) {
                var req = new XMLHttpRequest();
                req.addEventListener("load", this.loadCart.bind(this, req));

                req.open("POST", "/Items/Edit/" + global.PageCode);
                req.setRequestHeader(
                    "Content-Type",
                    "application/x-www-form-urlencoded"
                );
                req.send(items);
            },
            loadCart: function (req) {
                let details = JSON.parse(req.responseText);
                document.getElementsByClassName(cartCt)[0].innerHTML =
                    details.Body;
                document.getElementsByClassName(cartFt)[0].innerHTML =
                    details.Footer;
                this.unlockCart.call(this);
            }
        });

        Object.defineProperties(cart, {
            cartItems: {
                writable: true,
                value: global.CartItems
            },
            running: {
                writable: true,
                value: false
            }
        });

        addEventListener("DOMContentLoaded", function () {
            let inputs = document.getElementsByClassName("cartRadio");
            for (var i = 0; i < inputs.length; i++) {
                inputs[i].addEventListener(
                    "change",
                    cart.processCart.bind(cart, "add", inputs[i])
                );
            }
        });

        addEventListener("SessionLoaded", function () {
            if (
                cart.cartItems.length === 0 &&
                window["CartItems"].length == 0
            ) {
                let pageCode = window["PageCode"];
                let id = pageCode === "BestValue" ? "product3" : "product2";

                let defaultItem = document.getElementById(id);
                cart.processCart.call(cart, "add", defaultItem);
                defaultItem.checked = true;
            }
        });

        addEventListener("CartChange", cart.unlockCart.bind(cart));

        global["UpdateCart"] = function (item) {
            cart.processCart.call(cart, "update", item);
        };
    }
})(window);
