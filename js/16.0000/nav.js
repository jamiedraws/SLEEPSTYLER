(function (global) {
    if ("app" in global) {
        app.require(["defer"], function () {
            const nav = app.createContext(app.defer);

            nav.addProperties({
                element: document.querySelector(".nav"),
                orderLink: document.querySelector(".nav__order"),
                show: function () {
                    if (this.elementExists(this.element)) {
                        this.element.classList.remove("nav--is-hidden");
                    }
                },
                hide: function () {
                    if (this.elementExists(this.element)) {
                        this.element.classList.add("nav--is-hidden");
                    }
                },
                slidePanel: function (toggle) {
                    if (typeof toggle === "object") {
                        const setToggleEvent = function (elements) {
                            nav.listen(elements, setToggle);
                        };

                        const setToggle = function () {
                            try {
                                toggle.checked = false;
                            } catch (e) {
                                console.warn(e.message);
                                return false;
                            }
                        };

                        return setToggleEvent;
                    } else {
                        return false;
                    }
                },
                setAriaExpanded: function () {
                    let isExpanded = JSON.parse(this.getAttribute("aria-expanded"));
                    let setState = isExpanded ? false : true;
                    this.setAttribute("aria-expanded", setState);
                },
            });

            app.addProperty("nav", nav);

            nav.viewElement(
                {
                    selector: ".header",
                    state: "nav--is-fixed",
                    neighbor: ".nav",
                    ready: "nav--is-primed"
                },
                function (config) {
                    this.classList.remove(config.state);

                    if (nav.elementExists(nav.orderLink)) {
                        nav.orderLink.classList.add("btn--order-contrast");
                    }
                },
                function (config) {
                    this.classList.add(config.state);

                    if (nav.elementExists(nav.orderLink)) {
                        nav.orderLink.classList.remove("btn--order-contrast");
                    }

                    if (!this.classList.contains(config.ready)) {
                        this.classList.add(config.ready);
                    }
                }
            );

            const slide = nav.slidePanel(document.querySelector("#nav__toggle"));
            if (slide) {
                slide(document.querySelectorAll(".nav a[href^='#']"));
                slide(document.querySelectorAll(".nav__underlay"));
            }

            nav.listen(document.querySelectorAll(".nav [aria-haspopup]"), nav.setAriaExpanded);

            const reveal = app.createContext(app);

            reveal.addProperties({
                hide: function () {
                    if (reveal.elementExists(this)) {
                        this.classList.remove("reveal--flip");
                    }
                },
                show: function () {
                    if (reveal.elementExists(this)) {
                        this.classList.add("reveal--flip");
                    }
                },
                register: function (id) {
                    let element = false;
    
                    if (this.isString(id)) {
                        element = document.getElementById(id);
                    }
    
                    return this.publicInterface(element);
                },
                publicInterface: function (element) {
                    return Object.create({}, {
                        element: {
                            value: element
                        },
                        show: {
                            value: this.show.bind(element)
                        },
                        hide: {
                            value: this.hide.bind(element)
                        }
                    });
                }
            });

            const cartTotal = reveal.register("reveal-nav");
            addEventListener("CartChange", function (e) {
                if (e.detail.totalQty > 0) {
                    cartTotal.show();
                } else {
                    cartTotal.hide();
                }
            });
        });
    }
})(window);
