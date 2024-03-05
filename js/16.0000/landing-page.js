(function (global) {
    if ("app" in global) {
        const affirm = app.createContext(app);

        affirm.addProperties({
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
            observeContainer:  function (container, callback) {
                if (this.elementExists(container)) {
                    const observer = this.createObserver(callback);
                    if (this.isObject(observer)) {
                        observer.observe(container, {
                            attributes: true
                        });
                    }
                }
            },
            processTask: function () {
                app.require(["observer"], function () {
                    let progress = false;

                    app.observer.watch({
                        selector: ".affirm",
                        inRange: function (record, observer) {
                            if (!progress) {
                                progress = true;

                                if (!affirm.hasAffirm()) {
                                    const link = record.querySelector(".affirm__link");

                                    affirm.observeContainer(link, function (record, observer) {
                                        const ui = affirm.ui();
                                        const amount = record.target.dataset.amount;
                                        ui.openModal({
                                            amount: amount
                                        });
                                    });

                                    affirm.listen(link, affirm.requestAffirm);
                                }
                            }
                        },
                    });
                });
            }
        });

        affirm.processTask();

        addEventListener("DOMContentLoaded", function () {
            app.require(["defer"], function () {
                app.defer.revealContainers();
            });
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
} (window));