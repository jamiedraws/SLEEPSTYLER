(function (global) {
    if ("app" in global) {
        const dependencyManager = app.createContext(app);

        dependencyManager.addProperties({
            hasjQuery: function () {
                return "jQuery" in global;
            },
            hasFancybox: function () {
                return this.hasjQuery() && "fancybox" in global.jQuery;
            }
        });

        if (dependencyManager.hasFancybox()) {
            $("[data-fancybox]").fancybox({
                touch: false
            });
        }

        addEventListener("load", function () {
            app.require(["defer"], function () {
                app.defer.revealContainers();
            });
        });
    }
} (window));