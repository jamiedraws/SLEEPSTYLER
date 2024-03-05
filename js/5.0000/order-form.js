const makeToast = (function () {
    let toast;

    if ("app" in window) {
        toast = app.createContext(app);

        toast.addProperties({
            store: [],
            hasToast: function () {
                return app.require(["toast"]);
            },
            registerTemplates: function () {
                const templates = this.toArray(document.querySelectorAll(".toast"));

                templates.forEach(function (template) {
                    toast.store.push({
                        id: template.id,
                        api: app.toast(template.id)
                    });
                });
            },
            getTemplateById: function (id) {
                let result = false;

                this.store.forEach(function (template) {
                    if (template.id === id) {
                        result = template;
                    }
                });
                
                return result;
            },
            show: function (id) {
                const template = this.getTemplateById(id);
                if (template) {
                    template.api.show();
                }
            },
            getTemplateAPI: function (id) {
                const template = this.getTemplateById(id);
                return template.api;
            },
            updateMessage: function (id, message) {
                const template = this.getTemplateById(id);

                if (template) {
                    const element = template.api.element;
                    const title = element.querySelector("#" + template.id + "-title");
                    title.textContent = message;
                }
            },
            processTask: function () {
                if (this.hasToast()) {
                    this.registerTemplates();
                }
            }
        });

        toast.processTask();
    }

    return function (id, message) {
        let response = false;

        if (toast && toast.hasToast()) {
            toast.updateMessage(id, message);
            toast.show(id);
            response = toast.getTemplateAPI(id);
        }

        return response;
    };
})();