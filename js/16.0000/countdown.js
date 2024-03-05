(function (global) {
    if ("app" in global) {
        const countdown = app.createContext(app);

        countdown.addProperties({
            hasMoment: function () {
                return "moment" in global;
            },
            processTime: function (time, nodes) {
                setTimeout(function () {
                    const duration = moment.duration(time - 1000, "milliseconds");

                    if (duration.asSeconds() > 0) {
                        Object.keys(nodes).forEach(function (node) {
                            if (countdown.isFunction(duration[node]) && 
                            countdown.elementExists(nodes[node])) {
                                countdown.updateTime(duration[node](), nodes[node]);
                            }
                        });
                        countdown.processTime(duration, nodes);
                    }
                }, 1000);
            },
            updateTime: function (time, node) {
                node.textContent = time;
            },
            getTime: function (element, nodes) {
                const time = moment.duration(element.dataset.time);
                this.processTime(time, nodes);
            },
            processTask: function (element) {
                if (this.elementExists(element)) {
                    const nodes = {
                        days: element.querySelector("[data-days]"),
                        hours: element.querySelector("[data-hours]"),
                        minutes: element.querySelector("[data-minutes]"),
                        seconds: element.querySelector("[data-seconds]")
                    };

                    if (this.hasMoment()) {
                        this.getTime(element, nodes);
                    } else {
                        const moment = this.requestResource("/shared/js/moment.min.js", "script");
                        moment.onload = this.getTime.bind(this, element, nodes);
                    }
                }
            }
        });

        countdown.processTask(document.querySelector(".countdown"));
    }
}(window));