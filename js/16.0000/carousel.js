(function (global) {
    if ("app" in global) {
        app.require(["defer"], function () {
            const carousel = app.createContext(app.defer);

            carousel.addProperties({
                hasSlide: function () {
                    return "Slide" in global;
                },
                createSlide: function (select, nav) {
                    let response = false;

                    if (carousel.elementExists(select)) {
                        const into = select.querySelector(".slide__into");

                        if (carousel.elementExists(into)) {
                            response = Slide.into(
                                into,
                                {
                                    thumbnails: select.querySelectorAll(nav),
                                    currentState: "slide__item--current",
                                    currentThumbnail: "slide",
                                    container: select
                                },
                                function () {
                                    return this;
                                }
                            );
                        }
                    }

                    return response;
                },
                processor: function () {
                    const fades = this.toArray(
                        document.querySelectorAll(".slide--fade")
                    );

                    fades.forEach(function (fade) {
                        const slide = carousel.createSlide(fade, ".slide__btn");

                        const handleEvent = function (event) {
                            const target = slide.updateOnEvent(event);
                            slide.updateCurrentThumbnail(
                                "btn--is-active",
                                target
                            );
                        };

                        if (carousel.isObject(slide)) {
                            slide.setDefaultSlide();
                            carousel.listen(slide.thumbnails, handleEvent);
                        }
                    });
                }
            });

            if (carousel.hasSlide()) {
                Slide.proto({
                    setDefaultSlide: function () {
                        const currentState = this.currentState;

                        const defaultSlide = carousel
                            .toArray(this.children)
                            .filter(function (child) {
                                return child.classList.contains(currentState);
                            })[0];

                        const defaultIndex = carousel
                            .toArray(this.children)
                            .indexOf(defaultSlide);

                        if (defaultIndex >= 0) {
                            this.updateCurrentSlide(defaultIndex);
                        }
                    },
                    updateCurrentSlide: function (index) {
                        const previousSlide =
                            this.parent.getElementsByClassName(
                                this.currentState
                            )[0];
                        const currentSlide = this.children.item(index);

                        previousSlide.classList.remove(this.currentState);
                        currentSlide.classList.add(this.currentState);

                        this.updateSlideVisibility(index);
                    },
                    updateCurrentThumbnail: function (select, target) {
                        const previousThumbnail =
                            this.container.getElementsByClassName(select)[0];
                        const currentThumbnail = target.thumbnail;

                        if (previousThumbnail) {
                            previousThumbnail.classList.remove(select);
                        }
                        currentThumbnail.classList.add(select);
                    },
                    updateOnEvent: function (event) {
                        const self = this;
                        event.preventDefault();
                        const thumbnail = event.target;
                        const index = parseInt(thumbnail.dataset.slideIndex);
                        self.updateCurrentSlide(index);

                        return { index: index, thumbnail: thumbnail };
                    },
                    getCurrentIndex: function () {
                        return parseInt(this.dataset.slideIndex);
                    },
                    playOnscreen: function () {
                        const self = this;
                        const id = self.parent.id;

                        if (carousel.isString(id)) {
                            let observer;

                            app.require(["observer"], function () {
                                app.observer.watch({
                                    selector: "#" + id,
                                    inRange: function () {
                                        observer = setTimeout(
                                            self.play.bind(self),
                                            self.getDelay()
                                        );
                                    },
                                    outRange: function () {
                                        clearTimeout(observer);
                                        self.pause();
                                    },
                                    unObserve: hasIntersectionObserver(),
                                    options: {
                                        threshold: 0.5
                                    }
                                });
                            });
                        }
                    },
                    extendConfig: function () {
                        const config = this.parent.dataset.slideConfig;
                        if (config) {
                            const configJSON = JSON.parse(config);
                            if (carousel.isObject(configJSON)) {
                                if (configJSON.delay) {
                                    this.setDelay(configJSON.delay);
                                }

                                if (configJSON.auto) {
                                    this.playOnscreen();
                                }
                            }
                        }
                    }
                });
            }

            const hasIntersectionObserver = function () {
                return "IntersectionObserver" in window ? false : true;
            };

            carousel
                .toArray(
                    document.querySelectorAll(".slide--auto > .slide__into")
                )
                .forEach(function (carouselItem) {
                    Slide.into(
                        carouselItem,
                        {
                            currentState: "slide__item--current"
                        },
                        function () {
                            const self = this;

                            self.handleRotation(false);
                            self.setShim(true);

                            self.watch(function (currentIndex, prevIndex) {
                                if (self.isAuto()) {
                                    const prevSlide =
                                            this.children.item(prevIndex),
                                        currentSlide =
                                            this.children.item(currentIndex);

                                    prevSlide.classList.remove(
                                        self.currentState
                                    );
                                    currentSlide.classList.add(
                                        self.currentState
                                    );

                                    self.updateSlideVisibility(currentIndex);
                                }
                            });

                            const slideItem =
                                carouselItem.closest(".slide__item");

                            const observer = new MutationObserver(function (
                                records
                            ) {
                                const captureAriaHidden = records.filter(
                                    function (record) {
                                        return (
                                            record.attributeName ===
                                            "aria-hidden"
                                        );
                                    }
                                )[0];

                                if (captureAriaHidden) {
                                    const isVisible =
                                        slideItem.getAttribute(
                                            "aria-hidden"
                                        ) === "false";

                                    if (isVisible) {
                                        setTimeout(function () {
                                            self.play();
                                        }, self.getDelay());
                                    } else {
                                        self.pause();
                                    }
                                }
                            });

                            if (carousel.elementExists(slideItem)) {
                                observer.observe(slideItem, {
                                    attributes: true
                                });
                            }

                            this.playOnscreen();
                        }
                    );
                });

            carousel
                .toArray(document.querySelectorAll(".slide"))
                .forEach(function (slide) {
                    app.require(["observer"], function () {
                        const into = slide.querySelector(".slide__into"),
                            id = "#" + into.id;

                        app.observer.watch({
                            selector: id,
                            inRange: function () {
                                Slide.into(
                                    into,
                                    {
                                        container: slide,
                                        prevButton:
                                            slide.querySelector(".slide__prev"),
                                        nextButton:
                                            slide.querySelector(".slide__next"),
                                        thumbnails:
                                            slide.querySelector(
                                                ".slide__thumbnails"
                                            )
                                    },
                                    function () {
                                        const self = this;
                                        this.extendConfig();

                                        self.container.classList.add(
                                            "slide--is-ready"
                                        );

                                        if (self.prevButton) {
                                            self.prevButton.addEventListener(
                                                "click",
                                                function () {
                                                    self.prev();
                                                }
                                            );
                                        }

                                        if (self.nextButton) {
                                            self.nextButton.addEventListener(
                                                "click",
                                                function () {
                                                    self.next();
                                                }
                                            );
                                        }

                                        if (self.thumbnails) {
                                            const thumbnailList =
                                                self.thumbnails.querySelectorAll(
                                                    ".slide__thumbnail"
                                                );

                                            carousel.listen(
                                                thumbnailList,
                                                function (event) {
                                                    event.preventDefault();
                                                    const index =
                                                        self.getCurrentIndex.call(
                                                            this
                                                        );
                                                    self.goto(index);
                                                }
                                            );
                                        }

                                        self.watch(function (index) {
                                            self.selectThumbnail(index);

                                            const slide =
                                                self.children.item(index);
                                            if (slide) {
                                                app.require(
                                                    ["lazy"],
                                                    function () {
                                                        carousel.lazy(slide);
                                                    }
                                                );
                                            }

                                            self.observeLiveRegion();
                                        });
                                    }
                                );
                            }
                        });
                    });
                });

            carousel.processor();
        });
    }
})(window);
