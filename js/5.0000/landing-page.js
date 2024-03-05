(function (global) {
    if ("app" in global) {
        const affirm = app.createContext(app);

        affirm.addProperties({
            links: document.querySelectorAll(".affirm__link"),
            ui: function () {
                return global.affirm.ui;
            },
            hasAffirm: function () {
                return "affirm" in global;
            },
            hasInitAffirmJs: function () {
                return this.isFunction(initAffirmJs);
            },
            requestAffirm: function () {
                if (!affirm.hasAffirm() && affirm.hasInitAffirmJs()) {
                    initAffirmJs();
                }
            },
            createObserver: function (callback) {
                let result = false;

                if ("MutationObserver" in global) {
                    result = new MutationObserver(function (records, observer) {
                        if (app.isFunction(callback)) {
                            records.forEach(function (record) {
                                callback(record, observer);
                            });
                        }
                    });
                }

                return result;
            },
            observeContainer: function (container, callback) {
                if (this.elementExists(container)) {
                    const observer = this.createObserver(callback);
                    if (this.isObject(observer)) {
                        observer.observe(container, {
                            attributes: true
                        });
                    }
                }
            },
            requestAffirmByParameter: function () {
                const parameters = new URLSearchParams(location.search);
                const hasParameter = parameters.get("aff_fm") !== null;

                if (hasParameter) {
                    affirm.requestAffirm();
                }
            },
            processTask: function () {
                affirm.requestAffirmByParameter();

                affirm.listen(affirm.links, function () {
                    if (!affirm.hasAffirm()) {
                        affirm.observeContainer(
                            this,
                            function (record, observer) {
                                const ui = affirm.ui();
                                const amount = record.target.dataset.amount;

                                ui.openModal({
                                    amount: amount
                                });

                                observer.disconnect();
                            }
                        );
                        affirm.requestAffirm();
                    }
                });
            }
        });

        affirm.processTask();

        addEventListener("DOMContentLoaded", function () {
            app.require(["defer"], function () {
                app.defer.revealContainers();
            });
        });

        const livePerson = app.createContext(app);

        livePerson.addProperties({
            hasLivePerson: function () {
                return "lpTag" in global;
            },
            hasLivePersonInit: function () {
                return this.isFunction(livePersonInit);
            },
            hasLivePersonWidgit: function () {
                return this.isFunction(livePersonWidgetInit);
            },
            requestLivePerson: function () {
                if (!this.hasLivePerson() && this.hasLivePersonInit()) {
                    livePersonInit();
                    if (this.hasLivePersonWidgit()) {
                        livePersonWidgetInit();
                    }
                }
            },
            processTask: function () {
                app.require(["observer"], function () {
                    let progress = false;

                    app.observer.watch({
                        selector: "#main",
                        outRange: function () {
                            if (!progress) {
                                progress = true;

                                if (!livePerson.hasLivePerson()) {
                                    livePerson.requestLivePerson();
                                }
                            }
                        },
                        unObserve: false
                    });
                });
            }
        });

        livePerson.processTask();

        const offers = app.createContext(app.observer);

        offers.addProperties({
            state: "package--is-selected",
            addState: function (node) {
                if (offers.elementExists(node)) {
                    node.classList.add(offers.state);
                }
            },
            removeState: function (node) {
                if (offers.elementExists(node)) {
                    node.classList.remove(offers.state);
                }
            },
            removeAllStates: function (nodes) {
                nodes.forEach(function (node) {
                    offers.removeState(node);
                });
            },
            updateState: function (nodes, node) {
                offers.removeAllStates(nodes);
                offers.addState(node);
            },
            updateStateByDefault: function (element, nodes) {
                const node = element.closest(".package");
                offers.updateState(nodes, node);
            },
            processEvent: function () {
                const nodes = offers.toArray(
                    document.querySelectorAll(".package")
                );
                const controls = document.querySelectorAll(
                    ".package input[type=radio]"
                );
                const checkedControl = document.querySelector(
                    ".package input[type=radio][checked]"
                );

                offers.listen(controls, function () {
                    offers.updateStateByDefault(this, nodes);
                });

                if (offers.elementExists(checkedControl)) {
                    offers.updateStateByDefault(checkedControl, nodes);
                } else {
                    offers.toArray(controls).forEach(function (control) {
                        if (control.checked) {
                            offers.updateStateByDefault(control, nodes);
                        }
                    });
                }
            }
        });

        offers.watch({
            selector: "#form",
            inRange: offers.processEvent
        });

        const fancybox = app.createContext(app);

        fancybox.addProperties({
            hasjQuery: function () {
                return "jQuery" in global;
            },
            hasFancybox: function () {
                return fancybox.hasjQuery() && "fancybox" in global.jQuery;
            },
            requestFancybox: function (callback) {
                const js = fancybox.requestResource(
                    "/shared/js/fancybox/3.5.7/jquery.fancybox.min.js",
                    "script"
                );
                const css = fancybox.requestResource(
                    "/shared/js/fancybox/3.5.7/jquery.fancybox.min.css",
                    "link"
                );

                if (fancybox.isFunction(callback)) {
                    js.onload = callback;
                }
            },
            processTask: function () {
                const links = fancybox.toArray(
                    document.querySelectorAll(".link-on-fancybox")
                );

                fancybox.listen(links, function (event) {
                    if (!fancybox.hasFancybox()) {
                        const link = this;

                        event.preventDefault();
                        fancybox.requestFancybox(function () {
                            link.click();
                        });
                    }
                });
            }
        });

        fancybox.processTask();
    }
})(window);
