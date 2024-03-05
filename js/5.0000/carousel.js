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
                            carousel.listen(slide.thumbnails, handleEvent);
                        }
                    });
                }
            });

            carousel.processor();

            if (carousel.hasSlide()) {
                Slide.proto({
                    updateCurrentSlide: function (index) {
                        const previousSlide = this.parent.getElementsByClassName(
                            this.currentState
                        )[0];
                        const currentSlide = this.children.item(index);

                        previousSlide.classList.remove(this.currentState);
                        currentSlide.classList.add(this.currentState);
                    },
                    updateCurrentThumbnail: function (select, target) {
                        const previousThumbnail = this.container.getElementsByClassName(
                            select
                        )[0];
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
                    displayAll: function (mediaQuery) {
                        const self = this;
                        const mql = window.matchMedia(mediaQuery);
                        const handler = function (e) {
                            if (e.matches) {
                                self.isCarouselView = false;
                                self.setAllSlidesToVisible();
                            } else {
                                self.isCarouselView = true;
                                self.updateSlideVisibility(self.currentIndex());
                            }
                        };

                        try {
                            mql.addEventListener("change", handler);
                        } catch (e) {
                            mql.addListener(handler);
                        }

                        handler(mql);
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

                                if (configJSON.displayAll) {
                                    this.displayAll(configJSON.displayAll);
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
                    document.querySelectorAll(
                        ".carousel--auto > .carousel__into"
                    )
                )
                .forEach(function (carouselItem) {
                    Slide.into(
                        carouselItem,
                        {
                            currentState: "carousel__item--current"
                        },
                        function () {
                            const self = this;

                            self.handleRotation(false);
                            self.setShim(true);
                            self.watch(function (currentIndex, prevIndex) {
                                if (self.isAuto()) {
                                    const prevSlide = this.children.item(
                                            prevIndex
                                        ),
                                        currentSlide = this.children.item(
                                            currentIndex
                                        );

                                    prevSlide.classList.remove(
                                        self.currentState
                                    );
                                    currentSlide.classList.add(
                                        self.currentState
                                    );
                                }
                            });

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
                                        prevButton: slide.querySelector(
                                            ".slide__prev"
                                        ),
                                        nextButton: slide.querySelector(
                                            ".slide__next"
                                        ),
                                        thumbnails: slide.querySelector(
                                            ".slide__thumbnails"
                                        )
                                    },
                                    function () {
                                        const self = this;
                                        this.isCarouselView = true;
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
                                            const updateSlide = function (
                                                event
                                            ) {
                                                event.preventDefault();
                                                const index = self.getCurrentIndex.call(
                                                    this
                                                );
                                                self.goto(index);
                                            };

                                            const thumbnailList = self.thumbnails.querySelectorAll(
                                                ".slide__thumbnail"
                                            );

                                            carousel.listen(
                                                thumbnailList,
                                                updateSlide
                                            );
                                            carousel.listen(
                                                thumbnailList,
                                                updateSlide,
                                                "mouseenter"
                                            );
                                        }

                                        self.watch(function (index) {
                                            self.selectThumbnail(index);

                                            const slide = self.children.item(
                                                index
                                            );
                                            if (slide) {
                                                app.require(
                                                    ["lazy"],
                                                    function () {
                                                        carousel.lazy(slide);
                                                    }
                                                );
                                            }

                                            if (self.isCarouselView) {
                                                self.updateSlideVisibility(
                                                    index
                                                );
                                                self.observeLiveRegion();
                                            }
                                        });
                                    }
                                );
                            }
                        });
                    });
                });
        });
    }
})(window);
