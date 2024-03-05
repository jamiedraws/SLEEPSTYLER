(function (global) {
    if ("app" in global) {
        app.require(["defer"], function () {
            const view = app.createContext(app.defer);
            const product = app.createContext(app.defer);
            const carousel = app.createContext(app.defer);
            const media = app.createContext(app.defer);
            const fancybox = app.createContext(app);

            fancybox.addProperties({
                links: document.querySelectorAll(".link-on-fancybox"),
                hasFancybox: function () {
                    return "jQuery" in global && "fancybox" in global.jQuery;
                },
                enableLinks: function (callback) {
                    if (this.hasFancybox()) {
                        const links = this.toArray(this.links);
                        links.forEach(function (link) {
                            link.classList.add("link-on-fancybox--is-ready");
                        });
                        if (this.isFunction(callback)) {
                            callback();
                        }
                    }
                },
                renderFancybox: (function () {
                    let i = 0;
                    return function (event) {
                        let element = event.target;
                        if (this.elementExists(element)) {
                            event.preventDefault();
                            i += 1;
                            if (i === 1) {
                                element.classList.add("link-on-fancybox--is-active");
                                $.fancybox.open(element, {
                                    afterClose: function () {
                                        i = 0;
                                        element.classList.remove("link-on-fancybox--is-active");
                                    }
                                });
                            }
                        }
                    }
                })()
            });

            addEventListener("load", function () {
                fancybox.enableLinks(function () {
                    fancybox.listen(fancybox.links, fancybox.renderFancybox.bind(fancybox));
                });
            });

            view.hasObserve(function () {
                Observe({
                    selector: ".view--observe",
                    inRange: function (entry) {
                        entry.classList.add("view--in-view");
                    }
                });
            });

            media.addProperties({
                hasSource: function (id) {
                    return this.isString(this.getSource(element));
                },
                getSource: function (element) {
                    return element.dataset.srcIframe;
                },
                updateSource: function (element, id) {
                    const source = this.getSource(element);
                    return source.replace(/(\d{9})/, id);
                },
                getId: function (element) {
                    return element.dataset.videoId;
                },
                getIframe: function (element) {
                    return element.querySelector("iframe");
                },
                hasVimeo: function () {
                    return "Vimeo" in global;
                },
                setVimeo: function (iframe, callback) {
                    let result = false;
                    if (this.hasVimeo() && this.elementExists(iframe)) {
                        result = new Vimeo.Player(iframe);
                        if (this.isFunction(callback)) {
                            callback(result);
                        }
                    }
                    return result;
                },
                getCurrentButton: function (element, button) {
                    const lastSelectedButton = element.querySelector(".button--has-current-media");
                    if (this.elementExists(lastSelectedButton)) {
                        lastSelectedButton.classList.remove("button--has-current-media");
                    }
                    button.classList.add("button--has-current-media");
                }
            });

            media.hasObserve(function () {
                Observe({
                    selector: ".media",
                    inRange: function (element) {
                        const buttons = element.querySelectorAll("[data-video-id]"),
                            video = element.querySelector("[data-src-iframe]");
                        let iframe = media.getIframe(video), 
                            vimeo = false;

                        media.listen(buttons, function () {
                            media.getCurrentButton(element, this);
                            const id = media.getId(this),
                                source = media.updateSource(video, id);

                            if (!media.elementExists(iframe)) {
                                iframe = media.getIframe(video);
                                vimeo = media.setVimeo(iframe);
                            }

                            if (media.elementExists(iframe)) {
                                if (vimeo) {
                                    vimeo.loadVideo(id);
                                } else {
                                    iframe.src = source;
                                }
                            }
                        });
                    }
                });
            });

            const circularReveal = function (element, inner) {
                if (app.elementExists(element) && app.elementExists(inner)) {
                    const easing = 0.1;
                    const outScale = 0.01;
                    const inScale = 1;
                    let targetScale = outScale;
                    let elementScale = targetScale;
                    let innerScale = 1 / elementScale;

                    const update = function () {
                        elementScale += (targetScale - elementScale) * easing;
                        innerScale = 1 / elementScale;

                        element.style.transform = "scale(" + elementScale + ")";
                        inner.style.transform = "scale(" + innerScale + ")";

                        requestAnimationFrame(update);
                    };

                    update();

                    return {
                        show: function () {
                            targetScale = inScale;
                        },
                        hide: function () {
                            targetScale = outScale;
                        }
                    };
                }
            };

            product.addProperties({
                figure: document.querySelector(".product--figure"),
                list: document.querySelector(".product--list"),
                buttons: document.querySelectorAll(".product--figure button"),
                features: document.querySelectorAll(".product--list li"),
                prime: "product--is-primed",
                state: "product__is-selected",
                pictures: document.querySelectorAll(".product__reveal picture"),
                productReveal: circularReveal(
                        document.querySelector(".product__reveal"),
                        document.querySelector(".product__reveal__image")
                ),
                setPrime: function () {
                    product.list.classList.add("product--is-primed");
                    product.selectFeature.call(document.activeElement);
                },
                unsetPrime: function () {
                    product.list.classList.remove("product--is-primed");
                    product.toggleFeatures();
                    if (product.isObject(product.productReveal)) {
                        product.productReveal.hide();
                    }
                },
                toggleFeatures: function (element) {
                    product.toArray(product.features)
                    .forEach(function (feature) {
                        if (feature === element) {
                            feature.classList.add(product.state);
                        } else {
                            feature.classList.remove(product.state);
                        }
                    });
                },
                selectFeature: function () {
                    const label = this.getAttribute("aria-labelledby");
                    if (product.isString(label)) {
                        const element = document.getElementById(label);
                        if (product.elementExists(element)) {
                            product.toggleFeatures(element);
                        }
                        product.togglePictures(label);
                    }
                },
                toggleButtons: function (id) {
                    product.toArray(product.buttons).forEach(function (button) {
                        const label = button.getAttribute("aria-labelledby");
                        if (label === id) {
                            button.classList.add(product.state);
                        } else {
                            button.classList.remove(product.state);
                        }
                    });
                },
                togglePictures: function (id) {
                    if (product.isObject(product.productReveal)) {
                        product.toArray(product.pictures).forEach(function (picture) {
                           const label = picture.getAttribute("aria-labelledby");
                           if (label === id) {
                             picture.classList.add(product.state);
                             product.productReveal.show();
                             setItemByPlaceholder(picture);
                           } else {
                             picture.classList.remove(product.state);
                           }
                        });
                    }
                }
            });

            product.hasObserve(function () {
                Observe({
                    selector: ".view--product",
                    inRange: function () {
                        product.listen(
                            product.figure, 
                            product.setPrime,
                            "mouseenter"
                        );

                        product.listen(
                            product.list,
                            product.setPrime,
                            "mouseenter"
                        );
                
                        product.listen(
                            product.figure,
                            product.unsetPrime,
                            "mouseleave"
                        );

                        product.listen(
                            product.list,
                            function () {
                                product.unsetPrime();
                                product.toggleButtons();
                                product.togglePictures();
                            },
                            "mouseleave"
                        );
                
                        product.listen(
                            product.buttons, 
                            product.selectFeature
                        );
                
                        product.listen(
                            product.buttons, 
                            product.selectFeature,
                            "mouseover"
                        );

                        product.listen(
                            product.buttons,
                            function () {
                                product.productReveal.hide();
                                product.toggleFeatures();
                            },
                            "mouseleave"
                        );
                
                        product.listen(
                            product.buttons, 
                            product.selectFeature, 
                            "focus"
                        );

                        product.listen(
                            product.features,
                            function () {
                                product.toggleFeatures(this);
                                product.toggleButtons(this.id);
                                product.togglePictures(this.id);
                            },
                            "mouseenter"
                        );
                    }
                })
            });

            carousel.toArray(
                document.querySelectorAll(".copy__group--carousel .carousel")
            ).forEach(function (carouselItem) {
                const id = "#" + carouselItem.id;
                const thumbnailsContainer = document.querySelector(id + "-thumbnails");
                const thumbnails = thumbnailsContainer.querySelectorAll(".slide__thumbnail");

                Slide.into(
                    carouselItem, {
                        thumbnails: thumbnailsContainer
                    },
                    function () {
                        const self = this;

                        const updateSlide = function (event) {
                            const thumbnail = event.target;
                            const index = parseInt(thumbnail.dataset.slideIndex);
                            self.goto(index);
                        };

                        carousel.listen(thumbnails, updateSlide, "mouseenter");
                        carousel.listen(thumbnails, updateSlide, "click");

                        // add observer for each slide rotation
                        self.watch(function(index) {
                            // display the selected thumbnail button using CSS
                            self.selectThumbnail(index);

                            // allow screen reader to annouce current slide
                            self.updateSlideVisibility(index);
                            self.observeLiveRegion();
                        });
                    }
                ); 
            });

            carousel.toArray(
                document.querySelectorAll(".slide")
            ).forEach(function (slide) {
                carousel.hasObserve(function () {
                    const into = slide.querySelector(".slide__into"),
                        id = "#" + into.id;

                    Observe({
                        selector: id,
                        inRange: function () {

                            Slide.into(
                                into,
                                {
                                    container: slide,
                                    prevButton: slide.querySelector(".slide__prev"),
                                    nextButton: slide.querySelector(".slide__next"),
                                },
                                function() {
                                    const self = this;
                                    
                                    self.container.classList.add("slide--is-ready");
                
                                    self.prevButton.addEventListener("click", function() {
                                        self.prev();
                                    });
                            
                                    self.nextButton.addEventListener("click", function() {
                                        self.next();
                                    });
                                }
                            );
                        }
                    });
                });
            });
        });
    }
} (window));