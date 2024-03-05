(function (global) {
    if ("app" in global) {
        app.require(["defer"], function () {
            const nav = app.createContext(app.defer);
            const reveal = app.createContext(app.defer);

            nav.addProperties({
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
                }
            });

            nav.viewElement({
                selector: ".header", 
                state: "nav--is-fixed", 
                neighbor: ".nav",
                ready: "nav--is-primed"
            }, function (config) {
                this.classList.remove(config.state);
            }, function (config) {
                this.classList.add(config.state);

                if (!this.classList.contains(config.ready)) {
                    this.classList.add(config.ready);
                }
            });

            reveal.addProperties({
                fetchOffscreen: function (config, element) {
                    element.classList.add(config.state);
                },
                fetchOnscreen: function (config, element) {
                    element.classList.remove(config.state);
                },
                getRekt: function (entry) {
                    let rect = false;
                    if (reveal.isObject(entry)) {
                        rect = entry.boundingClientRect;
                        if (!reveal.isObject(rect)) {
                            rect = entry.target.getBoundingClientRect();
                        }
                    }
                    return rect;
                },
                toggleOffscreen: function () {
                    let ypos = 0;

                    reveal.viewElement({
                        selector: ".reveal-offscreen",
                        state: "reveal--is-visible",
                        neighbor: ".reveal"
                    }, function (config, element, entry) {
                        const pos = reveal.getRekt(entry);
                        if (reveal.isObject(pos)) {
                            if (pos.y > ypos) {
                                reveal.fetchOnscreen(config, this);
                            }
                            ypos = pos.y;
                        }
                    }, function (config, element, entry) {
                        const pos = reveal.getRekt(entry);
                        if (reveal.isObject(pos)) {
                            if (pos.y < ypos) {
                                reveal.fetchOffscreen(config, this);
                            }
                            ypos = pos.y;
                        }
                    });
                },
                toggleOnscreen: function () {
                    let ypos = 0;

                    reveal.viewElement({
                        selector: ".reveal-onscreen",
                        state: "reveal--is-visible",
                        neighbor: ".reveal"
                    }, function (config, element, entry) {
                        const pos = reveal.getRekt(entry);
                        if (reveal.isObject(pos)) {
                            if (pos.y > ypos) {
                                reveal.fetchOffscreen(config, this);
                            }
                            ypos = pos.y;
                        }
                    }, function (config, element, entry) {
                        const pos = reveal.getRekt(entry);
                        if (reveal.isObject(pos)) {
                            if (pos.y < ypos) {
                                reveal.fetchOnscreen(config, this);
                            }
                            ypos = pos.y;
                        }
                    });
                }
            });

            reveal.toggleOffscreen();
            reveal.toggleOnscreen();

            const slide = nav.slidePanel(document.querySelector("#nav__toggle"));
            if (slide) {
                slide(document.querySelectorAll(".nav a[href^='#']"));
                slide(document.querySelectorAll(".nav__underlay"));
            }
        });
    }
}(window));