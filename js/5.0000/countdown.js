(function (global) {
    if ("app" in global) {
        const countdown = app.createContext(app);
        countdown.addProperties({
            hasMoment: function () {
                return "moment" in global;
            },
            watchTime: function (time, props) {
                props.timer = setTimeout(
                    countdown.processTime.bind(countdown, time, props),
                    1000
                );
            },
            processTime: function (time, props) {
                const duration = moment.duration(time - 1000, "milliseconds");

                if (duration.asSeconds() > -1) {
                    countdown.processDurationByNodes(duration, props.nodes);
                    countdown.watchTime(duration, props);
                    countdown.setCallbackResponse(props, "progress", duration);
                } else {
                    countdown.setCallbackResponse(props, "complete");
                }
            },
            startTime: function (props) {
                let cookiedDuration = null;
                let iteration = countdown.getCountdownIteration();

                if (document.cookie.indexOf("_cend") > -1) {
                    cookiedDuration = countdown.getTimeDifference();

                    if (cookiedDuration._milliseconds <= 0 && iteration === 1) {
                        countdown.saveTimeCookie();
                        countdown.updateBannerText(2);
                        countdown.saveIterationCookie(2);
                        //countdown.postIteration(2);
                    }
                    else if (iteration === 2 && cookiedDuration._milliseconds > 0) {
                        countdown.updateBannerText(2);
                    }
                    else if (iteration === 2 && cookiedDuration._milliseconds <= 0) {
                        countdown.saveIterationCookie(3);
                        //countdown.postIteration(3);
                    }
                }
                else {
                    countdown.saveTimeCookie();
                }
                let stopCountdown = (iteration === 3);
                let useCookiedDuration = (cookiedDuration !== null && cookiedDuration._milliseconds > 0 && !stopCountdown);
                const time = (useCookiedDuration) ? moment.duration(cookiedDuration) : moment.duration(props.element.dataset.time);

                if (stopCountdown) {
                    countdown.watchTime(0, props);
                    let bannerTextElements = document.getElementsByClassName("bannerTime");

                    for (let i = 0; i < bannerTextElements.length; i++) {
                        bannerTextElements[i].innerHTML = "";
                    }
                } else {
                    countdown.processTime(time, props);
                }
            },
            getCountdownIteration: function () {
                let iteration = 1;
                let siteCookies = document.cookie.split(";");
                let cookieCount = siteCookies.length;

                for (let i = 0; i < cookieCount; i++) {
                    if (siteCookies[i].indexOf("_iteration") > -1) {
                        iteration = parseInt(siteCookies[i].split("=")[1]);
                    }
                }

                return iteration;
            },
            stopTime: function (props) {
                clearTimeout(props.timer);
            },
            setCallbackResponse: function (props, name, data) {
                if (countdown.isFunction(props[name])) {
                    props[name](data);
                }
            },
            processDurationByNodes: function (duration, nodes) {
                Object.keys(nodes).forEach(function (node) {
                    if (
                        countdown.isFunction(duration[node]) &&
                        countdown.elementExists(nodes[node])
                    ) {
                        countdown.updateTime(duration[node](), nodes[node]);
                    }
                });
            },
            updateTime: function (time, node) {
                node.setAttribute("data-time-live", time);
            },
            saveTimeCookie: function () {
                    let currentTime = moment().format("HH:mm:ss");
                    let timeStampArray = currentTime.split(":");
                    let hour = parseInt(timeStampArray[0]);
                    let minutes = parseInt(timeStampArray[1]) + 30;
                    let seconds = parseInt(timeStampArray[2]) + 59;

                    if (seconds > 59) {
                        minutes++;
                        seconds = seconds - 60;
                    }
                    if (minutes > 59) {
                        hour++;
                        minutes = minutes - 60;
                    }
                    let endTime = hour + ":" + minutes + ":" + seconds;
                    let expires = (new Date(Date.now() + 86400 * 1000)).toUTCString();
                    document.cookie = "_cend=" + endTime + "; expires=" + expires + "; path=/";
            },
            saveIterationCookie: function (iteration) {
                let expires = (new Date(Date.now() + 86400 * 1000)).toUTCString();
                document.cookie = "_iteration=" + iteration + "; expires=" + expires + "; path=/";
                
            },
            updateBannerText: function (iteration) {
                if (iteration === 2) {
                    document.getElementById("bannerText").innerText = "Need More Time? Last Chance For Additional 10% Off!";
                }
            },
            getTimeDifference: function () {
                let siteCookies = document.cookie.split(";");
                let cookieCount = siteCookies.length;

                for (let i = 0; i < cookieCount; i++) {
                    if (siteCookies[i].indexOf("_cend") > -1) {
                        let endTime = siteCookies[i].split("=")[1];
                        let currentTime = moment().format("HH:mm:ss");
                        let momentCurrentTime = moment(currentTime, "HH:mm:ss");
                        let momentEndTime = moment(endTime, "HH:mm:ss");

                        return moment.duration(momentEndTime.diff(momentCurrentTime));
                    }
                }
            },
            //postIteration: function (iteration) {
            //    let postItem = "iteration=" + iteration;
            //    let req = new XMLHttpRequest();
            //    let pageCode = window["PageCode"];
            //    req.open("POST", "/Items/Edit/" + pageCode);
            //    req.setRequestHeader(
            //        "Content-Type",
            //        "application/x-www-form-urlencoded"
            //    );
            //    req.send(postItem);
            //},
            setConfiguration: function (element, options) {
                const config = {
                    element: element,
                    nodes: {},
                    timer: undefined
                };

                if (countdown.isObject(options)) {
                    Object.keys(options).forEach(function (option) {
                        config[option] = options[option];
                    });
                }

                return config;
            },
            registerTimeNodes: function (props) {
                if (
                    countdown.elementExists(props.element) &&
                    countdown.isObject(props.time)
                ) {
                    Object.keys(props.time).forEach(function (time) {
                        props.nodes[time] = props.element.querySelector(
                            props.time[time]
                        );
                    });
                }
            },
            processTask: function (element, options) {
                const props = countdown.setConfiguration(element, options);

                countdown.registerTimeNodes(props);
                if (countdown.hasMoment()) {
                    if (document.cookie.indexOf("_cend") === -1) {
                        countdown.saveTimeCookie();
                    }
                    countdown.startTime(props);
                } else {
                    const moment = countdown.requestResource(
                        "/shared/js/moment.min.js",
                        "script"
                    );
                    moment.onload = countdown.startTime.bind(countdown, props);
                }

                return countdown.publicInterface(props);
            },
            publicInterface: function (props) {
                return Object.create(
                    {},
                    {
                        startOver: {
                            value: countdown.startTime.bind(countdown, props)
                        },
                        stop: {
                            value: countdown.stopTime.bind(countdown, props)
                        }
                    }
                );
            }
        });
        app.addProperty("countdown", countdown.processTask);
    }
})(window);
