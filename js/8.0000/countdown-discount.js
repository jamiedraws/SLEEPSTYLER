(function (global) {
    if ("app" in global) {
        const discountCountdown = app.createContext(app);

        discountCountdown.addProperties({
            hasCountdown: function () {
                return discountCountdown.require(["countdown"]);
            },
            registerCountdown: function () {
                const elements = discountCountdown.toArray(
                    document.querySelectorAll(".countdown")
                );

                elements.forEach(
                    discountCountdown.handleCountdownEvent.bind(
                        discountCountdown
                    )
                );
            },
            handleCountdownEvent: function (element) {
                let restart = true;
                const message = element.querySelector(".countdown__message");

                const countdown = discountCountdown.countdown(element, {
                    time: {
                        minutes: "[data-minutes]",
                        seconds: "[data-seconds]"
                    },
                    complete: function () {
                        if (
                            restart &&
                            discountCountdown.elementExists(message)
                        ) {
                            message.textContent =
                                "Need More Time? Last Chance For Additional 10% Off!";
                            countdown.startOver();
                            restart = false;
                        }
                    }
                });
            },
            processTask: function () {
                if (discountCountdown.hasCountdown()) {
                    discountCountdown.registerCountdown();
                } else {
                    const countdown = discountCountdown.requestResource(
                        "/js/5.0000/countdown.js",
                        "script"
                    );
                    countdown.onload =
                        discountCountdown.registerCountdown.bind(
                            discountCountdown
                        );
                }
            }
        });

        discountCountdown.processTask();
    }
})(window);
